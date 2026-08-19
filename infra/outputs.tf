output "app_instance_id" {
  value = module.compute.instance_id
}

output "bucket_name" {
  value = module.storage.bucket_name
}

output "database_id" {
  value = module.database.db_id
}

output "service_account" {
  value = module.iam.service_account_email
}