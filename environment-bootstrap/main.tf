terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "dev_state" {
  bucket        = "enterprise-tfstate-dev-${random_id.suffix.hex}"
  force_destroy = false
}

resource "aws_s3_bucket_versioning" "dev_state" {
  bucket = aws_s3_bucket.dev_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "dev_locks" {
  name         = "enterprise-tflocks-dev"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "prod_state" {
  bucket        = "enterprise-tfstate-prod-${random_id.suffix.hex}"
  force_destroy = false
}

resource "aws_s3_bucket_versioning" "prod_state" {
  bucket = aws_s3_bucket.prod_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "prod_locks" {
  name         = "enterprise-tflocks-prod"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}

module "github_oidc" {
  source            = "../modules/github_oidc"
  github_repository = var.github_repository
}
