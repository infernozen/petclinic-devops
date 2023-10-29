FROM openjdk:22-jdk-bullseye

EXPOSE 8080

COPY ./target/spring-petclinic-3.1.0-SNAPSHOT.jar /usr/app/

WORKDIR /usr/app

ARG VALUE="not set"

ENV MYSQL_URL=${VALUE} 

CMD ["java", "-jar", "spring-petclinic-3.1.0-SNAPSHOT.jar"]
