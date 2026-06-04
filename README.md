# Spring PetClinic - Projeto S07 (NP2)

Este repositório contém a aplicação Spring PetClinic, adaptada para atender aos requisitos de DevOps (CI/CD e Infraestrutura como Código) da disciplina S07.

A aplicação é um sistema de gerenciamento de clínica veterinária construído com Spring Boot, Java 17 e Maven.

---

## 🛠️ Pré-requisitos

Para executar e trabalhar neste projeto na sua máquina, você precisará ter instalado:

* Java 17 ou superior (JDK completo).
* Git.
* Docker e Docker Compose.
* IDE recomendada: IntelliJ IDEA ou VS Code.

---

## 🚀 Como executar o sistema (Modo DevOps)

Toda a nossa infraestrutura está definida como código. A aplicação já está configurada para rodar em um container e se conectar automaticamente a um banco de dados MySQL, também em container.

**Passo 1: Clone o repositório**
Abra o seu terminal e rode:
`git clone https://github.com/Henryblh/S07-Np2`
`cd S07-Np2`

**Passo 2: Suba a infraestrutura com Docker Compose**
Execute o comando abaixo na raiz do projeto para baixar as imagens e iniciar a rede de containers em segundo plano:
`docker compose up -d`

**Passo 3: Acesse a aplicação**
Aguarde alguns segundos para o banco de dados inicializar e o Spring Boot conectar.
Abra o seu navegador e acesse: `http://localhost:8080/`

**Passo 4: Acompanhe os logs (Opcional)**
Para verificar o status da aplicação ou debugar erros, use os comandos:
* Logs da aplicação: `docker compose logs -f petclinic-app`
* Logs do banco de dados: `docker compose logs -f mysql-db`

**Passo 5: Para desligar o sistema**
Quando terminar de testar, derrube a infraestrutura com segurança (os dados do banco serão salvos nos volumes do Docker):
`docker compose down`

---

## ⚙️ Configuração do Banco de Dados

Por padrão, a aplicação pura usa um banco em memória (H2). No entanto, para atender aos requisitos do projeto (comunicação entre containers e persistência), nós configuramos o perfil `mysql`.

O arquivo `docker-compose.yml` já injeta as seguintes variáveis de ambiente no container da aplicação automaticamente:
* `SPRING_PROFILES_ACTIVE=mysql`
* `SPRING_DATASOURCE_URL=jdbc:mysql://petclinic-mysql:3306/petclinic`

Você não precisa instalar o MySQL na sua máquina. O Docker gerencia tudo.

---

## 🧪 Como rodar os testes localmente

O projeto exige uma cobertura de testes $\ge90\%$. Para rodar a suíte de testes unitários e de integração via linha de comando, execute:

No Windows:
`./mvnw test`

No Linux/Mac:
`./mvnw test`

O Maven irá gerar os relatórios de execução na pasta `target/surefire-reports/`.

---

## 🚧 Próximos Passos (Fase 2 - Jenkins e Automação)

A infraestrutura atual contempla **2 containers** (Aplicação via Docker Hub + MySQL local).
Para finalizar a entrega da NP2, as seguintes etapas devem ser construídas:

1. **Adicionar o Container do Jenkins:** Incluir o serviço do Jenkins no `docker-compose.yml` utilizando um `Dockerfile` local.
2. **Adicionar o Container de E-mail:** Subir um serviço como o MailHog no `docker-compose.yml` para receber a notificação final.
3. **Criar o Jenkinsfile:** Automatizar as etapas de Teste, Build e Envio de E-mail sem usar a interface gráfica.
4. **Gerenciar Artefatos:** Garantir que o `.jar` gerado e o relatório de testes fiquem salvos no Jenkins.
5. **Preencher a seção de IA:** Documentar o uso de Inteligência Artificial no final deste README.
