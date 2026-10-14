output "app_ip" {
  description = "IP address of the CloudNotes application."
  value       = module.compute.app_ip
}

output "bucket_name" {
  description = "Name of the CloudNotes asset bucket."
  value       = module.storage.bucket_name
}

output "db_name" {
  description = "Name of the CloudNotes database."
  value       = module.database.db_name
}

output "network_id" {
  description = "ID of the CloudNotes network."
  value       = module.network.network_id
}

output "subnet_id" {
  description = "ID of the CloudNotes application subnet."
  value       = module.network.subnet_id
}

output "app_service_account" {
  description = "Application service account identifier."
  value       = module.iam.app_sa_email
}
