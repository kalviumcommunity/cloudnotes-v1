output "vm_name" {
  value = module.compute.vm_name
}

output "database_name" {
  value = module.database.db_name
}

output "bucket_name" {
  value = module.storage.bucket_name
}

output "service_account" {
  value = module.iam.app_sa_email
}

output "network_id" {
  value = module.network.network_id
}
