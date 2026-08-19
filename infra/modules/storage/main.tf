resource "null_resource" "bucket" {
  triggers = {
    name = "${var.project_name}-bucket"
  }
}