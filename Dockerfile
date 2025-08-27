FROM ubuntu:latest
LABEL authors="wellyson"

FROM maven:3.9.0-eclipse-temurin-17 AS builder

WORKDIR /app

COPY pom.xml /app
COPY src /app/src

RUN mvn clean install -DskipTests

FROM eclipse-temurin

WORKDIR /app

RUN apt-get update && apt-get install -y bash && rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/target/avaliacao-0.0.1-SNAPSHOT.jar /app/avaliacao.jar

ENTRYPOINT ["java", "-jar", "avaliacao.jar"]