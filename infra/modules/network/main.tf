resource "null_resource" "network" {
  triggers = {
    network_name = var.network_name
  }
}

resource "null_resource" "web_subnet" {
  triggers = {
    network_id = null_resource.network.id
    subnet     = "${var.network_name}-web"
    cidr       = var.web_cidr
  }
}

resource "null_resource" "app_subnet" {
  triggers = {
    network_id = null_resource.network.id
    subnet     = "${var.network_name}-app"
    cidr       = var.app_cidr
  }
}

resource "null_resource" "db_subnet" {
  triggers = {
    network_id = null_resource.network.id
    subnet     = "${var.network_name}-db"
    cidr       = var.db_cidr
  }
}

resource "null_resource" "firewall" {
  triggers = {
    network_id = null_resource.network.id
    name       = "${var.network_name}-firewall"
  }
}
