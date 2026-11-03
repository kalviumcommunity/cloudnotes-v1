module "iam" {
  source = "./modules/iam"

  project_name             = var.project_name
  app_service_account_name = var.app_service_account_name
  app_roles                = var.app_roles
}

module "network" {
  source = "./modules/network"

  project_name    = var.project_name
  region          = var.region
  vpc_cidr        = var.vpc_cidr
  web_subnet_cidr = var.web_subnet_cidr
  app_subnet_cidr = var.app_subnet_cidr
  db_subnet_cidr  = var.db_subnet_cidr
}

module "compute" {
  source = "./modules/compute"

  project_name          = var.project_name
  subnet_id             = module.network.app_subnet_id
  service_account_email = module.iam.app_sa_email
  instance_type         = var.app_instance_type
  private_ip            = var.app_private_ip
}

module "database" {
  source = "./modules/database"

  project_name = var.project_name
  db_subnet_id = module.network.db_subnet_id
  db_name      = var.db_name
}

module "storage" {
  source = "./modules/storage"

  project_name          = var.project_name
  bucket_name           = var.bucket_name
  region                = var.region
  service_account_email = module.iam.app_sa_email
}
