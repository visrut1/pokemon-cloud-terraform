resource "aws_db_instance" "app_db" {
  #  identifier = "app-db"
  db_name              = "pokemon"
  engine               = "mariadb"
  engine_version       = "10.6.11"
  instance_class       = "db.t2.micro"
  allocated_storage    = 20
  option_group_name    = "default:mariadb-10-6"
  skip_final_snapshot  = true
  publicly_accessible  = false
  availability_zone    = "ap-south-1a"
  parameter_group_name = "default.mariadb10.6"
  username             = "admin"
  password             = "my-cool-password"
  port                 = 3306
  vpc_security_group_ids = [aws_security_group.database-security-group-rds.id]

}
