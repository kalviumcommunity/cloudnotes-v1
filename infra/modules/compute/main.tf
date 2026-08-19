resource "null_resource" "compute_instance" {
  triggers = {
    project = var.project_name
    subnet  = var.subnet_id
    sa      = var.sa_email
  }
}