resource "null_resource" "database" {
  triggers = {
    project = var.project_name
    subnet  = var.subnet_id
  }
}