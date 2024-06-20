variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "The name of the node group"
  type        = string
}

variable "node_group_desired_capacity" {
  description = "The desired number of nodes in the node group"
  type        = number
}

variable "node_group_max_capacity" {
  description = "The maximum number of nodes in the node group"
  type        = number
}

variable "node_group_min_capacity" {
  description = "The minimum number of nodes in the node group"
  type        = number
}
