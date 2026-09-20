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
