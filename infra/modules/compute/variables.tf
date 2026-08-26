variable "ami_id" {
  type        = string
  description = "AMI identifier for the CloudNotes application"
}

variable "machine_type" {
  type        = string
  description = "EC2 instance type"
}

variable "subnet_id" {
  type        = string
  description = "Application subnet ID"
}

variable "security_group_id" {
  type        = string
  description = "Application security group ID"
}

variable "instance_name" {
  type        = string
  description = "Name of the application instance"
}

variable "instance_profile_name" {
  type        = string
  description = "IAM instance profile attached to the application"
}