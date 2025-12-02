# Giai đoạn 1: Build (Dùng Maven có sẵn của Docker để tránh lỗi quyền hạn)
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
# Lệnh quan trọng: -DfinalName=app sẽ ép tên file đầu ra thành "app.jar"
# Chúng ta dùng lệnh 'mvn' thay vì './mvnw' để tránh lỗi permission từ Windows
RUN mvn clean package -DskipTests -DfinalName=app

# Giai đoạn 2: Run
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
# Copy file app.jar (đã được định danh ở trên) vào
COPY --from=build /app/target/app.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]