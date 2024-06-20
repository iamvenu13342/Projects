output "node_group_id" {
  value = module.eks_workers.node_groups["example"].id
}
