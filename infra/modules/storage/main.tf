resource "null_resource" "bucket" {
  triggers = {
    bucket_name  = var.bucket_name
    storage_class = var.storage_class
  }
}
