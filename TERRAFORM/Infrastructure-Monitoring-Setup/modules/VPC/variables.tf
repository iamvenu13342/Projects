variable "name" {
  description = "The name of the VPC"
  type        = string
}

variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "A list of availability zones"
  type        = list(string)
}

variable "private_subnets" {
  description = "A list of private subnet CIDRs"
  type        = list(string)
}

variable "public_subnets" {
  description = "A list of public subnet CIDRs"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Enable NAT gateway"
  type        = bool
}

variable "single_nat_gateway" {
  description = "Use a single NAT gateway"
  type        = bool
}
