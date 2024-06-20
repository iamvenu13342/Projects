variable "subnet_id" {
  description = "The Subnet ID where instances will be deployed"
  type        = string
}

variable "security_groups" {
  description = "List of security group IDs"
  type        = list(string)
}
