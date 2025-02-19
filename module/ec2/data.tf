data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["default-vpc"] # Replace with the actual Name tag value of your VPC
  }
}

data "aws_subnet" "subnet_01" {
  filter {
    name   = "tag:Name"
    values = ["default01"] 
  }
}

data "aws_ami" "jenkins_master_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["s7-s8-jenkins-master"]
  }
}
