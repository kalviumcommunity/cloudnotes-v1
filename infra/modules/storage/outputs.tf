output "bucket_name" {
  value = null_resource.asset_bucket.triggers.name
}

output "bucket_id" {
  value = null_resource.asset_bucket.id
}
