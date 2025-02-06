output "ecr_repository_name" {
  description = "Name of the ECR repository"
  value       = module.lambda.ecr_repository_name
}

output "ecr_repository_arn" {
  description = "ARN of the ECR repository"
  value       = module.lambda.ecr_repository_arn
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = module.lambda.lambda_function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = module.lambda.lambda_function_arn
}

output "lambda_function_image_uri" {
  description = "Image URI of the Lambda function"
  value       = module.lambda.lambda_function_image_uri
}

output "lambda_function_role_name" {
  description = "Name of the Lambda function's IAM role"
  value       = module.lambda.lambda_function_role_name
}

output "lambda_function_role_arn" {
  description = "ARN of the Lambda function's IAM role"
  value       = module.lambda.lambda_function_role_arn
}
