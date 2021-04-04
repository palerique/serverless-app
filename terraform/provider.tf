terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.35"
    }
  }
}

provider "aws" {
  profile     = var.aws_profile
  region      = var.aws_region
  max_retries = 1
}
