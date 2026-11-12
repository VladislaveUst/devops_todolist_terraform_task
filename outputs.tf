output "public_ip_address" {
  description = "VM public IPv4 address."
  value       = module.network.public_ip_address
}

output "application_url" {
  description = "ToDo List URL for the allowed client."
  value       = "http://${module.network.public_ip_address}:8080/"
}

output "vm_id" {
  description = "Azure VM resource ID."
  value       = module.compute.vm_id
}
