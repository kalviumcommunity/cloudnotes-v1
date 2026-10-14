variable "project_id" {
  description = "Project identifier for the CloudNotes IAM configuration."
  type        = string
}

variable "app_service_account" {
  description = "Name of the CloudNotes application service account."
  type        = string
}

variable "app_role" {
  description = "Least-privilege role assigned to the CloudNotes application."
  type        = string
}
