output "network_id" {
  description = "ID of the CloudNotes network."
  value       = null_resource.network.id
}

output "subnet_id" {
  description = "ID of the CloudNotes application subnet."
  value       = null_resource.app_subnet.id
}

output "network_name" {
  description = "Name of the CloudNotes network."
  value       = var.network_name
}

output "subnet_name" {
  description = "Name of the application subnet."
  value       = "${var.network_name}-app"
}

output "subnet_cidr" {
  description = "CIDR range of the application subnet."
  value       = var.app_cidr
}
