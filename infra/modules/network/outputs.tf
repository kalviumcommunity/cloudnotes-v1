output "network_id" {
  description = "Generated network identifier"
  value       = random_pet.network.id
}


output "subnet_id" {
  description = "Generated subnet identifier"
  value       = random_pet.subnet.id
}
