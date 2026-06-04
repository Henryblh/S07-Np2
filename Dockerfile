# Usa uma imagem oficial do Java 17 enxuta (Alpine)
FROM eclipse-temurin:17-jre-alpine

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia o arquivo .jar gerado na pasta target para dentro do container
COPY target/*.jar app.jar

# Expõe a porta que o Spring Boot usa por padrão
EXPOSE 8080

# Comando que será executado quando o container iniciar
ENTRYPOINT ["java", "-jar", "app.jar"]
