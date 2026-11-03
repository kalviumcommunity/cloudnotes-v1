output "app_sa_email" {
  value = null_resource.service_account.triggers.email
}

output "role_binding_id" {
  value = null_resource.role_binding.id
}
