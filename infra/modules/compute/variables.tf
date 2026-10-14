variable "app_name" {
  description = "Name of the CloudNotes application instance."
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet where the application instance is placed."
  type        = string
}

variable "sa_email" {
  description = "Service account identifier used by the application."
  type        = string
}

variable "machine_type" {
  description = "Machine type for the CloudNotes application instance."
  type        = string
}
