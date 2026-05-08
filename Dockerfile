# ============================================
# Dockerfile - Trưa Nay Ăn Gì (Development)
# ============================================
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copy gradle wrapper & build files first (layer caching)
COPY gradlew .
COPY gradle/ gradle/
COPY build.gradle .
COPY settings.gradle .

# Fix line endings for gradlew (Windows → Linux)
RUN sed -i 's/\r$//' gradlew && chmod +x gradlew

# Download dependencies (cached layer)
RUN ./gradlew dependencies --no-daemon || true

# Copy source code
COPY src/ src/
COPY .env .env
COPY uploads/ uploads/

# Build the application (skip tests for dev)
RUN ./gradlew bootJar --no-daemon -x test

# Expose port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "build/libs/project_module_5-0.0.1-SNAPSHOT.jar"]
