terraform {
  backend "s3" {
    bucket       = "my-learning-terraform-state-bucket-998877"
    key          = "ec2/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.28.0"
    }
  }
  required_version = "~> 1.7"
}
