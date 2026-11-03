resource "null_resource" "vpc" {
  triggers = {
    name = "${var.project_name}-vpc"
    cidr = var.vpc_cidr
  }
}

resource "null_resource" "web_subnet" {
  triggers = {
    name   = "${var.project_name}-web-subnet"
    cidr   = var.web_subnet_cidr
    vpc_id = null_resource.vpc.id
  }
}

resource "null_resource" "app_subnet" {
  triggers = {
    name   = "${var.project_name}-app-subnet"
    cidr   = var.app_subnet_cidr
    vpc_id = null_resource.vpc.id
  }
}

resource "null_resource" "db_subnet" {
  triggers = {
    name   = "${var.project_name}-db-subnet"
    cidr   = var.db_subnet_cidr
    vpc_id = null_resource.vpc.id
  }
}

resource "null_resource" "firewall" {
  triggers = {
    name   = "${var.project_name}-firewall"
    web_id = null_resource.web_subnet.id
    app_id = null_resource.app_subnet.id
    db_id  = null_resource.db_subnet.id
    rule   = "allow-web-to-app;deny-public-db"
  }
}
