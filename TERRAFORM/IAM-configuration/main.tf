terraform {
  required_version = ">= 1.0.0"
  backend "s3" {
    bucket = "my-terraform-state-bucket"
    key    = "iam/terraform.tfstate"
    region = "us-west-2"
  }
}

provider "aws" {
  region = var.aws_region
}

module "iam" {
  source = "./modules/iam"
}
