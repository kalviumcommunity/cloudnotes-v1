resource "null_resource" "app_instance" {
  triggers = {
    app_name      = var.app_name
    subnet_id     = var.subnet_id
    service_account = var.sa_email
    machine_type  = var.machine_type
  }
}
