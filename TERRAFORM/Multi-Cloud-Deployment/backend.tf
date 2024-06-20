terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "multi-cloud/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }
}
