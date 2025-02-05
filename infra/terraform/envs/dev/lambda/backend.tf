terraform {
  required_version = "~> 1.7.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.39.0"
    }
  }

  cloud {
    hostname     = "app.terraform.io"
    organization = "RintaroooOrg"

    workspaces {
      project = "sample-lambda-cicd"
      name    = "dev-lambda"
    }
  }
}

