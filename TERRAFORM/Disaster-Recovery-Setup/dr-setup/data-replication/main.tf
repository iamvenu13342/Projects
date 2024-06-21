resource "aws_dynamodb_table" "primary" {
  name         = "PrimaryTable"
  hash_key     = "id"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "id"
    type = "S"
  }

  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
}

resource "aws_dynamodb_table_replica" "secondary" {
  table_name = aws_dynamodb_table.primary.name
  replica {
    region_name = var.secondary_region
  }
}
