terraform {
  required_version = "~> 0.12.0"
  backend "s3" {}
}

provider "aws" {
  profile = var.profile
  region  = var.region
  version = "~> 2.0"
}

provider "local" {
  version = "~> 1.4"
}

locals {
  split_email  = split("@", var.base_email)
  email_user   = element(local.split_email, 0)
  email_domain = element(local.split_email, 1)
}

resource "aws_organizations_account" "tools" {
  email     = "${local.email_user}+tools@${local.email_domain}"
  name      = "tools"
  role_name = "Ops"

  lifecycle {
    ignore_changes = [role_name]
  }
}

resource "aws_organizations_account" "dev" {
  email     = "${local.email_user}+dev@${local.email_domain}"
  name      = "dev"
  role_name = "Ops"

  lifecycle {
    ignore_changes = [role_name]
  }
}

resource "aws_organizations_account" "stage" {
  email     = "${local.email_user}+stage@${local.email_domain}"
  name      = "stage"
  role_name = "Ops"

  lifecycle {
    ignore_changes = [role_name]
  }
}

resource "aws_organizations_account" "prod" {
  email     = "${local.email_user}+prod@${local.email_domain}"
  name      = "prod"
  role_name = "Ops"

  lifecycle {
    ignore_changes = [role_name]
  }
}

resource "local_file" "terraform_tfvars" {
  content  = "base_email = \"${var.base_email}\""
  filename = "${path.module}/terraform.tfvars"
}

resource "local_file" "aws_config" {
  content = <<EOF
[profile ${var.profile}-tools]
source_profile = ${var.profile}
role_arn = arn:aws:iam::${aws_organizations_account.tools.id}:role/Ops

[profile ${var.profile}-dev]
source_profile = ${var.profile}
role_arn = arn:aws:iam::${aws_organizations_account.dev.id}:role/Ops

[profile ${var.profile}-stage]
source_profile = ${var.profile}
role_arn = arn:aws:iam::${aws_organizations_account.stage.id}:role/Ops

[profile ${var.profile}-prod]
source_profile = ${var.profile}
role_arn = arn:aws:iam::${aws_organizations_account.prod.id}:role/Ops
EOF

  filename = "${path.module}/aws_config.ini"
}
