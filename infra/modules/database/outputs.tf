output "db_identifier" {
  value       = aws_db_instance.cloudnotes.identifier
  description = "CloudNotes database identifier"
}

output "db_name" {
  value       = aws_db_instance.cloudnotes.db_name
  description = "CloudNotes database name"
}

output "db_endpoint" {
  value       = aws_db_instance.cloudnotes.endpoint
  description = "CloudNotes database endpoint"
}