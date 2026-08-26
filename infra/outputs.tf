output "app_instance_id" {
  value       = module.compute.instance_id
  description = "ID of the CloudNotes application instance"
}

output "app_instance_ip" {
  value       = module.compute.instance_ip
  description = "Private IP address of the CloudNotes application"
}

output "network_id" {
  value       = module.network.network_id
  description = "ID of the CloudNotes VPC"
}

output "app_subnet_id" {
  value       = module.network.app_subnet_id
  description = "ID of the CloudNotes application subnet"
}

output "db_subnet_id" {
  value       = module.network.db_subnet_id
  description = "ID of the CloudNotes database subnet"
}

output "bucket_name" {
  value       = module.storage.bucket_name
  description = "CloudNotes assets bucket name"
}

output "database_name" {
  value       = module.database.db_name
  description = "CloudNotes database name"
}

output "database_identifier" {
  value       = module.database.db_identifier
  description = "CloudNotes database identifier"
}

output "app_role_arn" {
  value       = module.iam.app_role_arn
  description = "CloudNotes application IAM role ARN"
}