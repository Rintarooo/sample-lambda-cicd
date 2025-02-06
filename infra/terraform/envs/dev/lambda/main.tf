module "lambda" {
  source = "../../../modules/aws/lambda"

  project     = var.project
  environment = var.environment
  architectures = var.architectures
}

