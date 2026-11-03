resource "null_resource" "database" {
  triggers = {
    name         = "${var.project_name}-database"
    database     = var.db_name
    subnet_id    = var.db_subnet_id
    private_only = "true"
  }
}
