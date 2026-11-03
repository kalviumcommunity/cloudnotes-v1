output "app_instance_id" {
  value = null_resource.app_instance.id
}

output "app_private_ip" {
  value = null_resource.app_instance.triggers.private_ip
}
