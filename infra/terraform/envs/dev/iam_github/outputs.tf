output "github_actions_oidc_role_arn" {
  description = "ARN of the GitHub Actions OIDC IAM role"
  value       = module.iam_github.github_actions_oidc_role_arn
}

output "github_actions_oidc_role_name" {
  description = "Name of the GitHub Actions OIDC IAM role"
  value       = module.iam_github.github_actions_oidc_role_name
}
