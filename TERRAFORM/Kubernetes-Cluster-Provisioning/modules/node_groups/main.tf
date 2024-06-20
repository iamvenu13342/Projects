module "eks_workers" {
  source  = "terraform-aws-modules/eks/aws//modules/node_groups"
  version = "17.0.0"

  cluster_name            = var.cluster_name
  node_group_name         = var.node_group_name
  desired_capacity        = var.node_group_desired_capacity
  max_capacity            = var.node_group_max_capacity
  min_capacity            = var.node_group_min_capacity

  instance_type           = "t3.medium"
  key_name                = "my-key"
}
