output "backend" {
  value = {
    bucket         = module.root.bucket
    dynamodb_table = module.root.dynamodb_table
    kms_key_id     = module.root.kms_key_id
    region         = var.region
  }
}
