terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.5.0"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  region  = "ap-south-1"
  profile = "default"
  default_tags {}
}

data "aws_vpc" "default_vpc_data" {
  default = true
}

data "aws_subnet" "default_subnet" {
  id     = "subnet-02310a6225491ee33"
  vpc_id = data.aws_vpc.default_vpc_data.id
}

module "ec2" {
  source    = "./EC2"
  subnet_id = data.aws_subnet.default_subnet.id
  vpc_id = data.aws_vpc.default_vpc_data.id
}

module "rds" {
  source      = "./DB"
  instance_sg = module.ec2.instance-sg-id
}