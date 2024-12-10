provider "aws" {
  region = local.aws_region
}

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

locals {
  name              = "custom-vpc"
  vpc_cidr          = "10.0.0.0/16"
  aws_region        = "us-east-1"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  tags = {
    owner          = "EK TECH SOFTWARE SOLUTION"
    environment    = "dev"
    project        = "Meta"
    created_by     = "Terraform"
    cloud_provider = "aws"}
  }

module "jenkins-master" {
  source        = "../../../module/aws-vpc"
  name    = local.name
  vpc_cidr      = local.vpc_cidr
  aws_region = local.aws_region
  availability_zones = local.availability_zones
    tags          = local.tags
}