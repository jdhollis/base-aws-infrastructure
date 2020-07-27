output "bucket" {
  value = aws_s3_bucket.state.id
}

output "dynamodb_table" {
  value = aws_dynamodb_table.state_locking.name
}

output "kms_key_id" {
  value = module.state_key.arn
}
