variable "region" {
  default = "us-west-2"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "availability_zone" {
  default = "us-west-2a"
}

variable "artifact_bucket_name" {
  default = "my-artifact-bucket"
}

variable "static_assets_bucket_name" {
  default = "my-static-assets-bucket"
}

variable "cluster_name" {
  default = "my-eks-cluster"
}

variable "db_name" {
  default = "mydb"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  default = "mypassword"
}

variable "key_name" {
  default = "my-key-pair"
}
