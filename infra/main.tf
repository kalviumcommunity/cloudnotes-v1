module "network" {
  source = "./modules/network"

  network_name = var.network_name
}

module "iam" {
  source = "./modules/iam"
}

module "compute" {
  source = "./modules/compute"

  subnet_id = module.network.subnet_id
  sa_email  = module.iam.app_sa_email
}

module "database" {
  source = "./modules/database"

  network_id = module.network.network_id
}

module "storage" {
  source = "./modules/storage"

  bucket_name = var.bucket_name
}
