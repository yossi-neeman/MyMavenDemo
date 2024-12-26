# Use an official Maven image to build the application
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Second stage to create a lighter image with only the compiled app
FROM openjdk:17-jre-slim
WORKDIR /app
COPY --from=build /app/target/MyDemo-0.0.1-SNAPSHOT.jar ./MyDemo-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java", "-jar", "MyDemo-0.0.1-SNAPSHOT.jar"]