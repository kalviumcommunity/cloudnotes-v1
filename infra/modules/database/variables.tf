variable "subnet_group_name" {
  type        = string
  description = "Name of the database subnet group"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for the database"
}

variable "security_group_id" {
  type        = string
  description = "Database security group ID"
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

variable "db_port" {
  type        = number
  description = "Database port"
}

variable "instance_class" {
  type        = string
  description = "Database instance class"
}

variable "allocated_storage" {
  type        = number
  description = "Database storage in GB"
}