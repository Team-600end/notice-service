FROM openjdk:11-jdk AS builder
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY src src
RUN chmod +x ./gradlew
RUN ./gradlew bootJar
FROM openjdk:11-slim
COPY --from=builder build/libs/*.jar notice-service.jar
VOLUME /tmp
EXPOSE 8083
ENTRYPOINT ["java", "-jar", "notice-service.jar"]