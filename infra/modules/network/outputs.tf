output "vpc_id" {
  value = null_resource.vpc.id
}

output "web_subnet_id" {
  value = null_resource.web_subnet.id
}

output "app_subnet_id" {
  value = null_resource.app_subnet.id
}

output "db_subnet_id" {
  value = null_resource.db_subnet.id
}

output "firewall_id" {
  value = null_resource.firewall.id
}
