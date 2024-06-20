output "user_access_key" {
  description = "The access key for the IAM user"
  value       = aws_iam_access_key.user_key.id
}

output "user_secret_key" {
  description = "The secret key for the IAM user"
  value       = aws_iam_access_key.user_key.secret
  sensitive   = true
}
