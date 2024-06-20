output "user_access_key" {
  description = "The access key for the deploy user"
  value       = aws_iam_access_key.user_key.id
}

output "user_secret_key" {
  description = "The secret key for the deploy user"
  value       = aws_iam_access_key.user_key.secret
  sensitive   = true
}
