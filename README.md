# Application — ECS CI/CD

Minimal Spring Boot web application deployed to Amazon ECS Fargate via blue/green deployment.

## Pages

| Path | Description |
|------|-------------|
| `/` | Home page — displays student name and lab name |
| `/actuator/health` | ALB health check endpoint |

## Local Development

```bash
mvn spring-boot:run
# Open http://localhost:8080
```

## Docker Build

```bash
docker build -t ecs-cicd-app .
docker run -p 8080:8080 ecs-cicd-app
```

## GitHub Actions Secrets Required

| Secret | Value |
|--------|-------|
| `AWS_ROLE_ARN` | ARN of the GitHub Actions IAM role (output of ecr-stack) |
| `AWS_REGION` | e.g. `us-east-1` |
| `ECR_REPOSITORY_URI` | ECR repository URI (output of ecr-stack) |
| `AWS_ACCOUNT_ID` | 12-digit AWS account ID |
| `ARTIFACT_BUCKET` | S3 bucket name (output of pipeline-stack) |

## Deployment Files

| File | Purpose |
|------|---------|
| `appspec.yaml` | CodeDeploy ECS blue/green deployment spec |
| `taskdef.json` | ECS task definition template — `<IMAGE1_NAME>` replaced by CodePipeline |
| `Dockerfile` | Multi-stage build: Maven build → JRE runtime |
