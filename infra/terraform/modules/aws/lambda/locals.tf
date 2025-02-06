locals {
  lambda_function_name = "${var.project}-${var.environment}-lambda"
  ecr_repository_name = "${var.project}-${var.environment}-lambda"
  lambda_role_name = "${var.project}-${var.environment}-lambda-role"
}
