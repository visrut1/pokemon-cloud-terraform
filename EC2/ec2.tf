resource "aws_security_group" "app-security-group" {
  name        = "app-security"
  description = "opening port 8080 for micronaut"
  vpc_id      = var.subnet_id
  ingress {
    description      = "Exposing 8080"
    from_port        = 8080
    protocol         = "tcp"
    to_port          = 8080
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]

  }
  ingress {
    description      = "SSH port"
    from_port        = 23
    protocol         = "tcp"
    to_port          = 23
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "tcp port"
    from_port        = 443
    protocol         = "tcp"
    to_port          = 443
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "http port"
    from_port        = 80
    protocol         = "tcp"
    to_port          = 80
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
resource "aws_instance" "pokemon_app_ec2" {
  ami             = "ami-0f8ca728008ff5af4"
  instance_type   = "t2.micro"
  key_name        = "app-server-key"
  subnet_id       = var.subnet_id
  security_groups = [aws_security_group.app-security-group.id]
}