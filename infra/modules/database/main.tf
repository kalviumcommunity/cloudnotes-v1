resource "aws_db_subnet_group" "cloudnotes" {
  name = var.subnet_group_name

  subnet_ids = var.subnet_ids

  tags = {
    Name = var.subnet_group_name
  }
}

resource "aws_db_instance" "cloudnotes" {
  identifier             = var.db_identifier
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  port                   = var.db_port
  db_subnet_group_name   = aws_db_subnet_group.cloudnotes.name
  vpc_security_group_ids = [var.security_group_id]

  publicly_accessible = false
  skip_final_snapshot = true
}