FROM eclipse-temurin:21-jdk-alpine
VOLUME /tmp
COPY target/*.jar app.jar
COPY .env .env 
ENTRYPOINT ["java","-jar","/app.jar"]
