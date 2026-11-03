resource "null_resource" "app_instance" {
  triggers = {
    name                  = "${var.project_name}-app"
    subnet_id             = var.subnet_id
    service_account_email = var.service_account_email
    instance_type         = var.instance_type
    private_ip            = var.private_ip
  }
}
