variable "subnet_ids" {
  description = "List of subnet IDs for the RDS instance"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for the RDS instance"
  type        = string
}
