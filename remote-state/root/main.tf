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

data "aws_caller_identity" "current" {}

module "root" {
  source = "../backend"

  env                     = "root"
  generate_backend_tfvars = true
  key_base                = var.key_base
  principal               = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
  region                  = var.region
}

resource "local_file" "terraform_tfvars" {
  content  = "key_base = \"${var.key_base}\""
  filename = "${path.module}/terraform.tfvars"
}
