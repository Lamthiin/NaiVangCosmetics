# Giai đoạn 1: Build
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
# Chạy lệnh build mặc định (sẽ tạo ra file tên gốc: NaiVangCosmetics-0.0.1-SNAPSHOT.jar)
RUN mvn clean package -DskipTests

# Giai đoạn 2: Run
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
# COPY chính xác tên file được tạo ra từ pom.xml của bạn
COPY --from=build /app/target/NaiVangCosmetics-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]