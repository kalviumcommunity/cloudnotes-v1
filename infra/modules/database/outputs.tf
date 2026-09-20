output "db_name" {
  description = "Name of the CloudNotes database."
  value       = var.db_name
}

output "db_endpoint" {
  description = "Local placeholder endpoint for the CloudNotes database."
  value       = "localhost:5432"
}
