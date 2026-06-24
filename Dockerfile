# ── Build stage ───────────────────────────────────────────────────────────────
FROM maven:3.9-amazoncorretto-17 AS build
WORKDIR /workspace
COPY pom.xml .
# Pre-fetch dependencies (layer cached unless pom.xml changes)
RUN mvn dependency:go-offline -q
COPY src ./src
RUN mvn package -DskipTests -q

# ── Runtime stage ──────────────────────────────────────────────────────────────
FROM amazoncorretto:17-al2023
WORKDIR /app

# Non-root user for security
RUN dnf install -y shadow-utils && dnf clean all \
    && groupadd -r appgroup && useradd -r -g appgroup appuser
USER appuser

COPY --from=build /workspace/target/ecs-cicd-app-1.0.0.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
