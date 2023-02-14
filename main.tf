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
}


resource "aws_security_group" "app-security-group" {
  name        = "app-security"
  description = "opening port 8080 for micronaut"
  vpc_id      = data.aws_vpc.default_vpc_data.id
  ingress {
    description      = "Exposing 8080"
    from_port        = 8080
    protocol         = "tcp"
    to_port          = 8080
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]

  }
  ingress {
    description = "SSH port"
    from_port   = 23
    protocol    = "tcp"
    to_port     = 23
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "tcp port"
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "http port"
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

data "aws_vpc" "default_vpc_data" {
  default = true
}

data "aws_subnet" "default_subnet" {
  id     = "subnet-02310a6225491ee33"
  vpc_id = data.aws_vpc.default_vpc_data.id
}

resource "aws_security_group" "database-security-group-rds" {
  name = "rds-ec2-sg"
  ingress{
    from_port = 3306
    protocol = "tcp"
    to_port = 3306
    security_groups = [aws_security_group.app-security-group.id]
  }
}

