resource "aws_api_gateway_rest_api" "my_api" {
  name        = "MyAPI"
  description = "This is my API"
}

output "api_gateway_id" {
  value = aws_api_gateway_rest_api.my_api.id
}

output "api_gateway_root_resource_id" {
  value = aws_api_gateway_rest_api.my_api.root_resource_id
}
