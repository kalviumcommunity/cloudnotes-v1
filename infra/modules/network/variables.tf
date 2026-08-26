variable "vpc_cidr" {
  type = string
}

variable "web_subnet_cidr" {
  type = string
}

variable "app_subnet_cidr" {
  type = string
}

variable "db_subnet_cidr" {
  type = string
}

variable "allowed_cidr" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "web_subnet_name" {
  type = string
}

variable "app_subnet_name" {
  type = string
}

variable "db_subnet_name" {
  type = string
}

variable "security_group_name" {
  type = string
}

variable "database_security_group_name" {
  type = string
}

variable "http_port" {
  type = number
}

variable "db_port" {
  type = number
}