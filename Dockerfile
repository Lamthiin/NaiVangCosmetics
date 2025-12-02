# Giai đoạn 1: Build
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
# Dùng lệnh -DfinalName=app để ÉP Maven đặt tên file đầu ra là app.jar
# (Không cần quan tâm pom.xml đặt tên là gì nữa)
RUN mvn clean package -DskipTests -DfinalName=app

# Giai đoạn 2: Run
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
# Bây giờ chắc chắn 100% file nằm ở target/app.jar
COPY --from=build /app/target/app.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]