resource "aws_vpc" "cloudnotes" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "web" {
  vpc_id     = aws_vpc.cloudnotes.id
  cidr_block = var.web_subnet_cidr

  tags = {
    Name = var.web_subnet_name
  }
}

resource "aws_subnet" "app" {
  vpc_id     = aws_vpc.cloudnotes.id
  cidr_block = var.app_subnet_cidr

  tags = {
    Name = var.app_subnet_name
  }
}

resource "aws_subnet" "db" {
  vpc_id     = aws_vpc.cloudnotes.id
  cidr_block = var.db_subnet_cidr

  tags = {
    Name = var.db_subnet_name
  }
}

resource "aws_security_group" "app" {
  name        = var.security_group_name
  description = "Firewall rules for the CloudNotes application"
  vpc_id      = aws_vpc.cloudnotes.id

  ingress {
    description = "HTTP"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.security_group_name
  }
}

resource "aws_security_group" "database" {
  name        = var.database_security_group_name
  description = "Firewall rules for the CloudNotes database"
  vpc_id      = aws_vpc.cloudnotes.id

  ingress {
    description = "PostgreSQL from application subnet"
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = [var.app_subnet_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.database_security_group_name
  }
}