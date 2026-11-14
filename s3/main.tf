provider "aws" {
  region  = var.region
  profile = "learn-terraform"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-learning-terraform-state-bucket-998877" # Needs to be globally unique

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}
