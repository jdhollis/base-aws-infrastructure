terraform {
  required_version = "~> 0.12.0"
  backend "s3" {}
}

provider "aws" {
  profile = var.profile
  region  = var.region
  version = "~> 2.0"
}

data "aws_caller_identity" "current" {}

provider "aws" {
  alias   = "tools"
  profile = "${var.profile}-tools"
  region  = var.region
  version = "~> 2.0"
}

module "tools" {
  source = "./env"

  providers = {
    aws = aws.tools
  }

  root_account_id = data.aws_caller_identity.current.account_id
}

provider "aws" {
  alias   = "dev"
  profile = "${var.profile}-dev"
  region  = var.region
  version = "~> 2.0"
}

module "dev" {
  source = "./env"

  providers = {
    aws = aws.dev
  }

  root_account_id = data.aws_caller_identity.current.account_id
}

provider "aws" {
  alias   = "stage"
  profile = "${var.profile}-stage"
  region  = var.region
  version = "~> 2.0"
}

module "stage" {
  source = "./env"

  providers = {
    aws = aws.stage
  }

  root_account_id = data.aws_caller_identity.current.account_id
}

provider "aws" {
  alias   = "prod"
  profile = "${var.profile}-prod"
  region  = var.region
  version = "~> 2.0"
}

module "prod" {
  source = "./env"

  providers = {
    aws = aws.prod
  }

  root_account_id = data.aws_caller_identity.current.account_id
}
