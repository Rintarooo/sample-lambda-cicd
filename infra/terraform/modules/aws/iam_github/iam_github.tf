data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "github_actions_oidc_trust_policy" {
  source_policy_documents = [
    templatefile("${path.module}/policies/github_actions_oidc_trust_policy.json", {
      account_id = data.aws_caller_identity.current.account_id
      repository = var.github_repository
    })
  ]
}

resource "aws_iam_role" "github_actions_oidc_role" {
  name               = local.github_actions_oidc_role_name
  assume_role_policy = data.aws_iam_policy_document.github_actions_oidc_trust_policy.json

  tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

data "aws_iam_policy_document" "push_ecr" {
  source_policy_documents = [
    templatefile("${path.module}/policies/push_ecr_policy.json", {
      ecr_repository_arn = var.ecr_repository_arn
    })
  ]
}

resource "aws_iam_role_policy" "push_ecr_inline_policy" {
  name   = local.ecr_push_inline_policy_name
  role   = aws_iam_role.github_actions_oidc_role.id
  policy = data.aws_iam_policy_document.push_ecr.json
}

data "aws_iam_policy_document" "deploy_lambda" {
  source_policy_documents = [
    templatefile("${path.module}/policies/deploy_lambda_policy.json", {
      lambda_function_arn      = var.lambda_function_arn
      lambda_function_role_arn = var.lambda_function_role_arn
      account_id               = data.aws_caller_identity.current.account_id
      ssm_parameter_name       = local.ssm_parameter_name
    })
  ]
}

resource "aws_iam_role_policy" "deploy_lambda_inline_policy" {
  name   = local.deploy_lambda_inline_policy_name
  role   = aws_iam_role.github_actions_oidc_role.id
  policy = data.aws_iam_policy_document.deploy_lambda.json
}
