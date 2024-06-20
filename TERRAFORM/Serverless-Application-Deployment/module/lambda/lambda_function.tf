resource "aws_lambda_function" "my_lambda" {
  function_name = "my_lambda_function"
  handler       = "index.handler"
  runtime       = "nodejs14.x"
  role          = var.lambda_role_arn

  filename         = "lambda_function_payload.zip"
  source_code_hash = filebase64sha256("lambda_function_payload.zip")
}

output "lambda_function_name" {
  value = aws_lambda_function.my_lambda.function_name
}

output "lambda_invoke_arn" {
  value = aws_lambda_function.my_lambda.invoke_arn
}
