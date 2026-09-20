module "network" {
  source = "./modules/network"

  network_name = var.network_name
  web_cidr     = var.web_cidr
  app_cidr     = var.app_cidr
  db_cidr      = var.db_cidr
}

module "iam" {
  source = "./modules/iam"

  project_id           = var.project_id
  app_service_account  = var.app_service_account
  app_role             = var.app_role
}

module "compute" {
  source = "./modules/compute"

  app_name      = var.app_name
  subnet_id     = module.network.subnet_id
  sa_email      = module.iam.app_sa_email
  machine_type  = var.machine_type
}

module "database" {
  source = "./modules/database"

  db_name    = var.db_name
  network_id = module.network.network_id
  db_engine  = var.db_engine
  db_size    = var.db_size
}

module "storage" {
  source = "./modules/storage"

  bucket_name  = var.bucket_name
  storage_class = var.storage_class
}
