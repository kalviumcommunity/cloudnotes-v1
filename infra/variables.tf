variable "region" {
  type        = string
  description = "AWS region used for CloudNotes resources"
}

variable "localstack_endpoint" {
  type        = string
  description = "LocalStack endpoint for zero-cost validation"
}


# =========================================================
# NETWORK VARIABLES
# =========================================================

variable "vpc_cidr" {
  type        = string
  description = "CIDR range for the CloudNotes VPC"
}

variable "web_subnet_cidr" {
  type        = string
  description = "CIDR range for the web subnet"
}

variable "app_subnet_cidr" {
  type        = string
  description = "CIDR range for the application subnet"
}

variable "db_subnet_cidr" {
  type        = string
  description = "CIDR range for the database subnet"
}

variable "allowed_cidr" {
  type        = string
  description = "CIDR range allowed to access the application"
}

variable "vpc_name" {
  type        = string
  description = "Name of the CloudNotes VPC"
}

variable "web_subnet_name" {
  type        = string
  description = "Name of the web subnet"
}

variable "app_subnet_name" {
  type        = string
  description = "Name of the application subnet"
}

variable "db_subnet_name" {
  type        = string
  description = "Name of the database subnet"
}

variable "security_group_name" {
  type        = string
  description = "Name of the application security group"
}

variable "database_security_group_name" {
  type        = string
  description = "Name of the database security group"
}

variable "http_port" {
  type        = number
  description = "HTTP port"
}

variable "db_port" {
  type        = number
  description = "Database port"
}


# =========================================================
# COMPUTE VARIABLES
# =========================================================

variable "ami_id" {
  type        = string
  description = "AMI identifier for the CloudNotes application"
}

variable "machine_type" {
  type        = string
  description = "EC2 instance type"
}

variable "instance_name" {
  type        = string
  description = "Name of the CloudNotes application instance"
}


# =========================================================
# STORAGE VARIABLES
# =========================================================

variable "bucket_name" {
  type        = string
  description = "CloudNotes assets bucket name"
}


# =========================================================
# IAM VARIABLES
# =========================================================

variable "role_name" {
  type        = string
  description = "CloudNotes application IAM role name"
}


# =========================================================
# DATABASE VARIABLES
# =========================================================

variable "db_subnet_group_name" {
  type        = string
  description = "Database subnet group name"
}

variable "db_identifier" {
  type        = string
  description = "Database instance identifier"
}

variable "db_name" {
  type        = string
  description = "Database name"
}

variable "db_username" {
  type        = string
  description = "Database username"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "Database password"
}

variable "db_instance_class" {
  type        = string
  description = "Database instance class"
}

variable "db_allocated_storage" {
  type        = number
  description = "Database storage in GB"
}