variable "region" {
  description = "The AWS region to deploy resources in"
  default     = "us-west-2"
}

variable "vpc_id" {
  description = "The VPC ID where resources will be deployed"
  type        = string
}

variable "subnet_id" {
  description = "The Subnet ID where instances will be deployed"
  type        = string
}
