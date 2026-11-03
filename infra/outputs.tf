output "vpc_id" {
  description = "CloudNotes virtual network identifier"
  value       = module.network.vpc_id
}

output "app_instance_id" {
  description = "CloudNotes application instance identifier"
  value       = module.compute.app_instance_id
}

output "app_private_ip" {
  description = "CloudNotes application private IP"
  value       = module.compute.app_private_ip
}

output "database_name" {
  description = "CloudNotes database name"
  value       = module.database.database_name
}

output "database_id" {
  description = "CloudNotes database identifier"
  value       = module.database.database_id
}

output "bucket_name" {
  description = "CloudNotes asset bucket name"
  value       = module.storage.bucket_name
}

output "app_service_account_email" {
  description = "CloudNotes application service account"
  value       = module.iam.app_sa_email
}
