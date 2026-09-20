resource "null_resource" "app_service_account" {
  triggers = {
    project_id = var.project_id
    name       = var.app_service_account
  }
}

resource "null_resource" "app_role_binding" {
  triggers = {
    service_account = null_resource.app_service_account.id
    role            = var.app_role
  }
}
