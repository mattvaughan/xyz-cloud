FROM openjdk:11-jre

RUN wget https://github.com/karatelabs/karate/releases/download/v1.4.0/karate-1.4.0.jar

COPY message.feature .
COPY karate-config.js .

ENTRYPOINT ["java", "-jar", "./karate-1.4.0.jar"]
