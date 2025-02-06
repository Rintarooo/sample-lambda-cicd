data "terraform_remote_state" "lambda" {
  backend = "remote"

  config = {
    organization = "RintaroooOrg"
    workspaces = {
      name = "dev-lambda"
    }
  }
}
