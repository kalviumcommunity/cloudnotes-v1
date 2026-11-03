variable "project_name" {
  description = "Name of the CloudNotes project"
  type        = string
  default     = "cloudnotes"
}

variable "region" {
  description = "Deployment region"
  type        = string
  default     = "asia-south1"
}

variable "vpc_cidr" {
  description = "CIDR range for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "web_subnet_cidr" {
  description = "CIDR range for the web subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "app_subnet_cidr" {
  description = "CIDR range for the application subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "db_subnet_cidr" {
  description = "CIDR range for the database subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "app_instance_type" {
  description = "Application instance size"
  type        = string
  default     = "small"
}

variable "app_private_ip" {
  description = "Illustrative private IP for the application"
  type        = string
  default     = "10.0.2.10"
}

variable "db_name" {
  description = "CloudNotes database name"
  type        = string
  default     = "cloudnotes_db"
}

variable "bucket_name" {
  description = "CloudNotes asset bucket name"
  type        = string
  default     = "cloudnotes-assets-local"
}

variable "app_service_account_name" {
  description = "Application service account name"
  type        = string
  default     = "cloudnotes-app"
}

variable "app_roles" {
  description = "Illustrative least-privilege application roles"
  type        = list(string)
  default     = ["storage.objectViewer"]
}
