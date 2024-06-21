resource "aws_s3_bucket" "artifact" {
  bucket = var.artifact_bucket_name
}

resource "aws_s3_bucket" "static_assets" {
  bucket = var.static_assets_bucket_name
}
