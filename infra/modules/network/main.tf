resource "null_resource" "vpc" {
  triggers = {
    cidr = var.vpc_cidr
  }
}

resource "null_resource" "app_subnet" {
  triggers = {
    name = "app-subnet"
  }
}

resource "null_resource" "db_subnet" {
  triggers = {
    name = "db-subnet"
  }
}