terraform {
  backend "s3" {
    bucket = "romach007-terraform"
    key = "global/s3/terraform.tfstate"
    region = "eu-central-1"
    dynamodb_table = "romach007-terraform-backend-lock"
    encrypt = true
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "s3_backend_bucket" {
  bucket = "romach007-terraform"
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
  name = "romach007-terraform-backend-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.s3_backend_bucket.arn
  description = "The ARN of the S3 bucket"
}
