module "s3_logs" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 4.0"

  bucket = "${var.project_name}-logs"

  versioning = {
    enabled = true
  }

  lifecycle_rule = [{
    id = "1"
    enabled = true
    expiration = {
      days = 90
    }
  }]

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = local.tags
}
