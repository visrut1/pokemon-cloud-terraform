resource "aws_instance" "pokemon_app_ec2" {
  ami             = "ami-0f8ca728008ff5af4"
  instance_type   = "t2.micro"
  key_name        = "app-server-key"
  subnet_id       = data.aws_subnet.default_subnet.id
  security_groups = [aws_security_group.app-security-group.id]
}
