variable "db_name" {
  description = "Name of the CloudNotes database."
  type        = string
}

variable "network_id" {
  description = "ID of the private network where the database is placed."
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
