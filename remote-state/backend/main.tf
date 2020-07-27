locals {
  key = var.env == "root" ? var.key_base : "${var.key_base}-${var.env}"
}

module "state_key" {
  source = "github.com/jdhollis/s3-kms-key"

  alias_name = "${local.key}-state-key"
  principals = [var.principal]
}

resource "aws_s3_bucket" "state" {
  bucket = "${local.key}-state"

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "state" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = aws_s3_bucket.state.id
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "state_locking" {
  name         = "${local.key}-state-locking"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

data template_file "backend" {
  template = file("${path.module}/../backend.tpl.tfvars")

  vars = {
    bucket         = aws_s3_bucket.state.id
    dynamodb_table = aws_dynamodb_table.state_locking.name
    kms_key_id     = module.state_key.arn
    region         = var.region
  }
}

resource "local_file" "backend_tfvars" {
  count    = var.generate_backend_tfvars ? 1 : 0
  content  = data.template_file.backend.rendered
  filename = "${path.module}/../backends/${var.env}.tfvars"
}
