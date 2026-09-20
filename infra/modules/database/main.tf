resource "null_resource" "database" {
  triggers = {
    db_name    = var.db_name
    network_id = var.network_id
    engine     = var.db_engine
    size       = var.db_size
  }
}
