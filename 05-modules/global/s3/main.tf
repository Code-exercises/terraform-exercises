terraform {
//    backend "s3" {
//      key = "global/s3/terraform.tfstate"
//    }
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "s3_backend_bucket" {
  bucket = var.project-name
//  force_destroy = true
  lifecycle {
    prevent_destroy = true
  }
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "backend_lock_table" {
  name = "${var.project-name}-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}