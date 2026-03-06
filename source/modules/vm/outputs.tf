output "public_ip" {
  value = try(azurerm_public_ip.public_ip[0].ip_address, null)
}

output "private_ip" {
  value = azurerm_network_interface.nic.private_ip_address
}