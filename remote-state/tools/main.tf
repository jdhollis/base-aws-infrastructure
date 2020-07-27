terraform {
  required_version = "~> 0.12.0"
  backend "local" {}
}

provider "aws" {
  profile = var.profile
  region  = var.region
  version = "~> 2.0"
}

provider "local" {
  version = "~> 1.4"
}

provider "template" {
  version = "~> 2.1"
}

data "aws_iam_role" "ops" {
  name = "Ops"
}

module "tools" {
  source = "../backend"

  env                     = "tools"
  generate_backend_tfvars = true
  key_base                = var.key_base
  principal               = data.aws_iam_role.ops.arn
  region                  = var.region
}

module "dev" {
  source = "../backend"

  env                     = "dev"
  generate_backend_tfvars = true
  key_base                = var.key_base
  principal               = data.aws_iam_role.ops.arn
  region                  = var.region
}

module "stage" {
  source = "../backend"

  env       = "stage"
  key_base  = var.key_base
  principal = data.aws_iam_role.ops.arn
  region    = var.region
}

module "prod" {
  source = "../backend"

  env       = "prod"
  key_base  = var.key_base
  principal = data.aws_iam_role.ops.arn
  region    = var.region
}

resource "local_file" "terraform_tfvars" {
  filename = "${path.module}/terraform.tfvars"
  content  = "key_base = \"${var.key_base}\""
}
