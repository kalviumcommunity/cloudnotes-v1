variable "project_name" {
  description = "Logical name of the CloudNotes project."
  type        = string
}

variable "project_id" {
  description = "Project identifier used by the IAM module."
  type        = string
}

variable "region" {
  description = "Region in which CloudNotes infrastructure is modeled."
  type        = string
}

variable "network_name" {
  description = "Name of the CloudNotes network."
  type        = string
}

variable "web_cidr" {
  description = "CIDR range for the web subnet."
  type        = string
}

variable "app_cidr" {
  description = "CIDR range for the application subnet."
  type        = string
}

variable "db_cidr" {
  description = "CIDR range for the database subnet."
  type        = string
}

variable "app_name" {
  description = "Name of the CloudNotes application instance."
  type        = string
}

variable "machine_type" {
  description = "Machine type for the CloudNotes application instance."
  type        = string
}

variable "app_service_account" {
  description = "Name of the CloudNotes application service account."
  type        = string
}

variable "app_role" {
  description = "Least-privilege role for the CloudNotes application."
  type        = string
}

variable "db_name" {
  description = "Name of the CloudNotes database."
  type        = string
}

variable "db_engine" {
  description = "Database engine used by CloudNotes."
  type        = string
}

variable "db_size" {
  description = "Size or tier of the CloudNotes database."
  type        = string
}

variable "bucket_name" {
  description = "Name of the CloudNotes storage bucket."
  type        = string
}

variable "storage_class" {
  description = "Storage class for the CloudNotes storage bucket."
  type        = string
}
