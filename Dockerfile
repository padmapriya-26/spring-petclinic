FROM maven:3.9.9-eclipse-temurin-17-noble  AS builder
WORKDIR /app
RUN git clone https://github.com/spring-projects/spring-petclinic.git
RUN cd /app/spring-petclinic && mvn clean package -DskipTests


FROM eclipse-temurin:17-jre
COPY --from=builder /app/spring-petclinic/target/*.jar /app/spring.jar
EXPOSE 8080
CMD ["java", "-jar", "/app/spring.jar"]
