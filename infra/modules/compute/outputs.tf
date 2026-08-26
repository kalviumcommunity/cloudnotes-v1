output "instance_id" {
  value       = aws_instance.app.id
  description = "ID of the CloudNotes application instance"
}

output "instance_ip" {
  value       = aws_instance.app.private_ip
  description = "Private IP address of the CloudNotes application"
}