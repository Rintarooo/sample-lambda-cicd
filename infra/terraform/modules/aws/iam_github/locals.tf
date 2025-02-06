locals {
  github_actions_oidc_role_name    = "${var.project}-${var.environment}-github-actions-oidc-role"
  ecr_push_inline_policy_name      = "${var.project}-${var.environment}-ecr-push-inline-policy"
  deploy_lambda_inline_policy_name = "${var.project}-${var.environment}-deploy-lambda-inline-policy"
  ssm_parameter_name               = "/version/lambda/${var.lambda_function_name}"
}
