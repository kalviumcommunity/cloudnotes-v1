output "network_id" {
  value       = aws_vpc.cloudnotes.id
  description = "ID of the CloudNotes VPC"
}

output "web_subnet_id" {
  value       = aws_subnet.web.id
  description = "ID of the web subnet"
}

output "app_subnet_id" {
  value       = aws_subnet.app.id
  description = "ID of the application subnet"
}

output "db_subnet_id" {
  value       = aws_subnet.db.id
  description = "ID of the database subnet"
}

output "security_group_id" {
  value       = aws_security_group.app.id
  description = "ID of the application security group"
}

output "database_security_group_id" {
  value       = aws_security_group.database.id
  description = "ID of the database security group"
}