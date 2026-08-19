module "network" {
  source = "./modules/network"

  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
}

module "iam" {
  source = "./modules/iam"

  project_name = var.project_name
}

module "storage" {
  source = "./modules/storage"

  project_name = var.project_name
}

module "database" {
  source = "./modules/database"

  project_name = var.project_name
  subnet_id    = module.network.db_subnet_id
}

module "compute" {
  source = "./modules/compute"

  project_name = var.project_name
  subnet_id    = module.network.app_subnet_id
  sa_email     = module.iam.service_account_email
}

