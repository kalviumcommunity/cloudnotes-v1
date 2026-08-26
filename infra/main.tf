# =========================================================
# NETWORK
# =========================================================

module "network" {
  source = "./modules/network"

  vpc_cidr = var.vpc_cidr

  web_subnet_cidr = var.web_subnet_cidr
  app_subnet_cidr = var.app_subnet_cidr
  db_subnet_cidr  = var.db_subnet_cidr

  allowed_cidr = var.allowed_cidr

  vpc_name        = var.vpc_name
  web_subnet_name = var.web_subnet_name
  app_subnet_name = var.app_subnet_name
  db_subnet_name  = var.db_subnet_name

  security_group_name          = var.security_group_name
  database_security_group_name = var.database_security_group_name

  http_port = var.http_port
  db_port   = var.db_port
}


# =========================================================
# STORAGE
# =========================================================

module "storage" {
  source = "./modules/storage"

  bucket_name = var.bucket_name
}


# =========================================================
# IAM
# =========================================================

module "iam" {
  source = "./modules/iam"

  role_name  = var.role_name
  bucket_arn = module.storage.bucket_arn
}


# =========================================================
# COMPUTE
# =========================================================

module "compute" {
  source = "./modules/compute"

  ami_id       = var.ami_id
  machine_type = var.machine_type

  subnet_id = module.network.app_subnet_id

  security_group_id = module.network.security_group_id

  instance_name = var.instance_name

  instance_profile_name = module.iam.instance_profile_name
}


# =========================================================
# DATABASE
# =========================================================

module "database" {
  source = "./modules/database"

  subnet_group_name = var.db_subnet_group_name

  subnet_ids = [
    module.network.db_subnet_id
  ]

  security_group_id = module.network.database_security_group_id

  db_identifier = var.db_identifier
  db_name       = var.db_name
  db_username   = var.db_username
  db_password   = var.db_password

  db_port = var.db_port

  instance_class    = var.db_instance_class
  allocated_storage = var.db_allocated_storage
}