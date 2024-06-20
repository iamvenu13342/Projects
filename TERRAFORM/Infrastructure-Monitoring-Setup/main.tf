module "vpc" {
  source = "./vpc"
}

module "ec2_instances" {
  source = "./ec2_instances"
}

module "security_groups" {
  source = "./security_groups"
}

module "iam_roles" {
  source = "./iam_roles"
}
