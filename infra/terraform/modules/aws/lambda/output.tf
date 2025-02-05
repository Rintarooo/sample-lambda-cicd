output "ecr_repository_name" {
  description = "Name of the ECR repository"
  value       = aws_ecr_repository.lambda_repository.name
}
