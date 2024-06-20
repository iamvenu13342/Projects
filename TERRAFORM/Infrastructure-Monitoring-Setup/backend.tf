terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "infra-monitoring/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }
}
