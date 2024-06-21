provider "aws" {
  alias  = "primary"
  region = var.primary_region
}

provider "aws" {
  alias  = "secondary"
  region = var.secondary_region
}

module "primary" {
  source = "./primary"
  providers = {
    aws = aws.primary
  }
}

module "secondary" {
  source = "./secondary"
  providers = {
    aws = aws.secondary
  }
}

module "data_replication" {
  source = "./data-replication"
}

module "failover" {
  source = "./failover"
}
