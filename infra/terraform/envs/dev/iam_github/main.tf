module "iam_github" {
  source = "../../../modules/aws/iam_github"

  project           = var.project
  environment       = var.environment
  github_repository = var.github_repository

  ecr_repository_arn       = data.terraform_remote_state.lambda.outputs.ecr_repository_arn
  lambda_function_name     = data.terraform_remote_state.lambda.outputs.lambda_function_name
  lambda_function_arn      = data.terraform_remote_state.lambda.outputs.lambda_function_arn
  lambda_function_role_arn = data.terraform_remote_state.lambda.outputs.lambda_function_role_arn
}
