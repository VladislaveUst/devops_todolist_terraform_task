output "subnet_id" {
  description = "ID of the secured application subnet."
  value       = azurerm_subnet.main.id
  depends_on  = [azurerm_subnet_network_security_group_association.main]
}

output "public_ip_address_id" {
  description = "ID of the public IP resource."
  value       = azurerm_public_ip.main.id
}

output "public_ip_address" {
  description = "Public IPv4 address."
  value       = azurerm_public_ip.main.ip_address
}
