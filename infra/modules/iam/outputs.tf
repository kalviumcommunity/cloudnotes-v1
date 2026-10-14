output "app_sa_email" {
  description = "Email-style identifier of the CloudNotes application service account."
  value       = "${var.app_service_account}@${var.project_id}.iam"
}

