resource "aws_lambda_function" "function" {
  function_name = local.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.lambda_repository.repository_url}:0.0.1"
  architectures = var.architectures
  memory_size   = 128
  timeout       = 30

  depends_on = [
    null_resource.push_image_to_ecr
  ]

  lifecycle {
    ignore_changes = all
  }

  tags = {
    Name        = local.lambda_function_name
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}
