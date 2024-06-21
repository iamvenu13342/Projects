variable "cluster_name" {
  description = "The name of the EKS cluster"
}

variable "cluster_version" {
  description = "The version of the EKS cluster"
}

variable "subnets" {
  description = "The subnets for the EKS cluster"
}

variable "vpc_id" {
  description = "The VPC ID for the EKS cluster"
}
