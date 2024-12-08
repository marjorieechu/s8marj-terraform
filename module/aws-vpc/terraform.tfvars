
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