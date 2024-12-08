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
    aws_region = "us-east-1"
    aws_iam_group = "hr-dept"
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
    tags = {
        owner          = "EK TECH SOFTWARE SOLUTION"
        environment    = "dev"
        project        = "HR"
        created_by     = "Terraform"
        cloud_provider = "aws"}
}

module "jenkins-master" {
  source        = "../../../modules/iam"
  aws_region = local.aws_region
  aws_iam_group =local.aws_iam_group
  policy_arn = local.policy_arn
  tags          = local.tags
}