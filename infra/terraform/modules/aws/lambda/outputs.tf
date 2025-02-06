output "ecr_repository_name" {
  description = "Name of the ECR repository"
  value       = aws_ecr_repository.lambda_repository.name
}

output "ecr_repository_arn" {
  description = "ARN of the ECR repository"
  value       = aws_ecr_repository.lambda_repository.arn
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.function.function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.function.arn
}

output "lambda_function_image_uri" {
  description = "Image URI of the Lambda function"
  value       = aws_lambda_function.function.image_uri
}

output "lambda_function_role_name" {
  description = "Name of the Lambda function's IAM role"
  value       = aws_iam_role.lambda_role.name
}

output "lambda_function_role_arn" {
  description = "ARN of the Lambda function's IAM role"
  value       = aws_iam_role.lambda_role.arn
}
