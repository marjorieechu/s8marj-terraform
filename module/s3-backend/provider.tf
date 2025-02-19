## Terraform block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  alias  = "source"
  region = var.aws_region_source
}

provider "aws" {
  alias  = "backup"
  region = var.aws_region_backup
}