resource "null_resource" "service_account" {
  triggers = {
    name    = var.app_service_account_name
    project = var.project_name
    email   = "${var.app_service_account_name}@${var.project_name}.local"
  }
}

resource "null_resource" "role_binding" {
  triggers = {
    service_account_id = null_resource.service_account.id
    roles              = join(",", var.app_roles)
    scope              = "cloudnotes-assets"
  }
}
