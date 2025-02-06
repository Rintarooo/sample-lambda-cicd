resource "aws_ecr_repository" "lambda_repository" {
  name                 = local.ecr_repository_name
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = local.ecr_repository_name
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_ecr_lifecycle_policy" "lambda_lifecycle_policy" {
  repository = aws_ecr_repository.lambda_repository.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 10 images"
        selection = {
          tagStatus     = "any"
          countType     = "imageCountMoreThan"
          countNumber   = 10
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

data "aws_caller_identity" "current" {}

resource "null_resource" "push_image_to_ecr" {
  provisioner "local-exec" {
    command = <<EOF
      aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.ap-northeast-1.amazonaws.com
      cd ${path.module}/../../../../docker/lambda
      docker build \
        --platform linux/arm64 \
		    --provenance=false \
        --target runner \
        -t ${aws_ecr_repository.lambda_repository.repository_url}:0.0.1 .
      docker push ${aws_ecr_repository.lambda_repository.repository_url}:0.0.1
    EOF
  }
}