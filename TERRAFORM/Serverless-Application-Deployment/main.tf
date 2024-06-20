terraform {
  required_version = ">= 1.0.0"
  backend "s3" {
    bucket = "my-terraform-state-bucket"
    key    = "serverless-app/terraform.tfstate"
    region = "us-west-2"
  }
}

provider "aws" {
  region = var.aws_region
}

module "iam" {
  source = "./iam"
}

module "lambda" {
  source             = "./lambda"
  lambda_role_arn    = module.iam.lambda_exec_arn
}

module "api_gateway" {
  source         = "./api_gateway"
  lambda_invoke_arn = module.lambda.lambda_invoke_arn
}
