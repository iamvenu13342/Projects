module "vpc" {
  source = "./modules/vpc"
}

module "eks" {
  source          = "./modules/eks"
  cluster_name    = "my-cluster"
  cluster_version = "1.21"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
}
