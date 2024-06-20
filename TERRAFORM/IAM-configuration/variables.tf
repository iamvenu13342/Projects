variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "iam_user_name" {
  description = "The name of the IAM user"
  type        = string
  default     = "deploy_user"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket for policies"
  type        = string
  default     = "mybucket"
}
