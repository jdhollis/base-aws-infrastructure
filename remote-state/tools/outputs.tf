output "backend" {
  value = {
    tools = {
      bucket         = module.tools.bucket
      dynamodb_table = module.tools.dynamodb_table
      kms_key_id     = module.tools.kms_key_id
      region         = var.region
    }

    dev = {
      bucket         = module.dev.bucket
      dynamodb_table = module.dev.dynamodb_table
      kms_key_id     = module.dev.kms_key_id
      region         = var.region
    }

    stage = {
      bucket         = module.stage.bucket
      dynamodb_table = module.stage.dynamodb_table
      kms_key_id     = module.stage.kms_key_id
      region         = var.region
    }

    prod = {
      bucket         = module.prod.bucket
      dynamodb_table = module.prod.dynamodb_table
      kms_key_id     = module.prod.kms_key_id
      region         = var.region
    }
  }
}
