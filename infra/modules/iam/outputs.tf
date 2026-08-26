output "app_role_arn" {
  value       = aws_iam_role.app.arn
  description = "ARN of the CloudNotes application IAM role"
}

output "app_role_name" {
  value       = aws_iam_role.app.name
  description = "Name of the CloudNotes application IAM role"
}

output "instance_profile_name" {
  value       = aws_iam_instance_profile.app.name
  description = "Name of the EC2 instance profile"
}