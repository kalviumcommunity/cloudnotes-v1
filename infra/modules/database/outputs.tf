output "database_id" {
  value = null_resource.database.id
}

output "database_name" {
  value = null_resource.database.triggers.database
}
