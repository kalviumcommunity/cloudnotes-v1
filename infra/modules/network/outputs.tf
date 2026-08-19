output "app_subnet_id" {
  value = null_resource.app_subnet.id
}

output "db_subnet_id" {
  value = null_resource.db_subnet.id
}