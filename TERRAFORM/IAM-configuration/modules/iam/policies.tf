resource "aws_iam_policy" "deploy_policy" {
  name        = "deploy_policy"
  description = "A policy for deployment"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "s3:List*"
        ],
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action = "s3:GetObject",
        Effect = "Allow",
        Resource = "arn:aws:s3:::${var.s3_bucket_name}/*"
      }
    ]
  })
}
