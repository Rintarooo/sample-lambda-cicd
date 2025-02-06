output "github_actions_oidc_role_arn" {
  description = "ARN of the GitHub Actions OIDC IAM role"
  value       = aws_iam_role.github_actions_oidc_role.arn
}

output "github_actions_oidc_role_name" {
  description = "Name of the GitHub Actions OIDC IAM role"
  value       = aws_iam_role.github_actions_oidc_role.name
}
