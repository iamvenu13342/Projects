resource "aws_api_gateway_resource" "my_resource" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "resource"
}

output "api_gateway_resource_id" {
  value = aws_api_gateway_resource.my_resource.id
}
