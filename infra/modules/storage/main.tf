resource "null_resource" "asset_bucket" {
  triggers = {
    name                  = var.bucket_name
    project               = var.project_name
    location              = var.region
    service_account_email = var.service_account_email
    public_access         = "false"
  }
}
