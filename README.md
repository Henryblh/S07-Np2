# Projeto S07 (NP2) - Aplicando DevOps na Prática

## 🐾 Visão Geral do Sistema e Funcionalidades

O sistema base escolhido para a aplicação DevOps foi o **Spring PetClinic**. É uma aplicação web em Java (Spring Boot) desenvolvida para gerenciar uma clínica veterinária.

**Principais Funcionalidades da Aplicação:**
* Cadastro e gestão de Médicos Veterinários e suas especialidades.
* Cadastro de Tutores (Owners) e seus respectivos Pets.
* Agendamento e histórico de Visitas à clínica.
* Persistência de dados utilizando um banco de dados relacional (MySQL).

**Principais Funcionalidades da Infraestrutura DevOps:**
* **Pipeline As Code:** Automação completa de Testes, Build e Notificação via `Jenkinsfile`.
* **Infraestrutura como Código:** Orquestração de 4 containers simulando um ambiente real (Aplicação, Banco de Dados, Servidor de CI/CD e Servidor de E-mail).

---

## 🛠️ Pré-requisitos

Para executar este projeto localmente, você precisará ter instalado em sua máquina:
* Docker
* Docker Compose
* Git

---

## 🚀 Instalação e Execução

**Passo 1: Clone o repositório**
```bash
git clone https://github.com/Henryblh/S07-Np2
cd S07-Np2
```

**Passo 2: Configure as Variáveis de Ambiente**
O pipeline exige um e-mail de destino configurado dinamicamente.
1. Encontre o arquivo `.env.example` na raiz do projeto.
2. Renomeie-o para `.env` (ou crie uma cópia com este nome).
3. Insira o e-mail desejado: `NOTIFICATION_EMAIL=seu_email@teste.com`

**Passo 3: Suba a Infraestrutura**
Execute o comando abaixo para construir as imagens necessárias e iniciar os 4 containers em segundo plano:
```bash
docker compose up -d --build
```

**Passo 4: Acesso aos Serviços**
Após alguns segundos para a inicialização dos serviços, acesse pelo navegador:
* **Aplicação PetClinic:** `http://localhost:8080/`
* **Jenkins (Painel de CI/CD):** `http://localhost:8081/`
* **MailHog (Caixa de E-mail):** `http://localhost:8025/`

Para encerrar a aplicação e destruir os containers (mantendo os dados salvos nos volumes), execute:
```bash
docker compose down
```

---

## ⚙️ Arquitetura dos Containers

A nossa infraestrutura atende ao requisito de 4+ containers, orquestrados da seguinte forma:
1. **petclinic-app:** Container da aplicação gerado via `Dockerfile` e baixado do Docker Hub (`henryblh/petclinic:v1`).
2. **petclinic-mysql:** Banco de dados MySQL 8.0, comunicando-se com a aplicação via rede interna `petclinic-net`.
3. **jenkins:** Servidor de automação construído localmente via `./jenkins/Dockerfile` (instalando Maven, Docker e cURL).
4. **mailhog:** Servidor SMTP de testes para interceptar o envio de e-mails do pipeline.

---

## 🤖 Uso de Inteligência Artificial

Conforme os requisitos da disciplina, documentamos abaixo o uso de ferramentas de IA durante o desenvolvimento do projeto.

* **Modelos Utilizados:** Gemini.
* **Para quê foram usados:** Debugging de erros do `Jenkinsfile`, correção de sintaxe de arquivos YAML
* **Dinâmica de uso:** A ferramenta foi utilizada como um assistente de "Pair Programming". Quando um erro de terminal ou quebra de build ocorria, os logs eram submetidos à IA para análise e proposta de correção.

### Exemplos Reais de Prompts

**Prompt 1: Correção de sintaxe no Docker Compose**
* **Prompt:** *"foi feito alterações no dockercompose deve ter adiciona e apagado algo sem queren... [código do colega]. [codigo antigo] Essa é a nossa que esta funcionado. qual foi a mundaça? a mudança explica o erro? é possivel mesclar as duas sem quebrar a estrutura?"*
* **Resultado:** A IA identificou que as alterações do YAML do colega e que variáveis essenciais (como o perfil do MySQL) haviam sido apagadas. A resposta foi **aceita e integrada**, mesclando os serviços antigos com os novos.

**Prompt 2: Erro de variável de ambiente no Jenkinsfile**
* **Prompt:** *"[Log de erro: java.lang.NoSuchMethodError: No such DSL method 'export' found]. o console registra um erro apenas na ultima etapa"*
* **Resultado:** A IA explicou que o comando `export` nativo do Linux não funciona dentro do bloco `script` do Groovy no Jenkins. Sugeriu a substituição pela função `withEnv`. A resposta foi **aceita e implementada**, resolvendo a quebra do pipeline.

**Prompt 3: Falha no pacote Sendmail do Linux**
* **Prompt:** *"[Log de erro: sendmail: illegal option -- S]. Erros diferentes eu acho interprete."*
* **Resultado:** A IA diagnosticou que a imagem base do Jenkins usa uma versão do Debian incompatível com a flag `-S` do `sendmail` usada no script. A sugestão foi reescrever o script `send_notification.sh` utilizando o comando nativo `curl smtp://`. A resposta foi **aceita**, evitando a necessidade de reconstruir os containers com novos pacotes.

