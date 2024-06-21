provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./vpc"
}

module "iam" {
  source = "./iam"
}

module "s3" {
  source = "./s3"
  artifact_bucket_name      = var.artifact_bucket_name
  static_assets_bucket_name = var.static_assets_bucket_name
}

module "eks" {
  source           = "./eks"
  cluster_name     = var.cluster_name
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
}

module "ecr" {
  source = "./ecr"
}

module "rds" {
  source = "./rds"
  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}

module "ec2" {
  source = "./ec2"
  key_name = var.key_name
}

module "cloudfront" {
  source = "./cloudfront"
}

module "codepipeline" {
  source = "./codepipeline"
}

module "cloudwatch" {
  source = "./cloudwatch"
}
