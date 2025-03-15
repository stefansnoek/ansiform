output "public_ip" {
    value = azurerm_public_ip.webapp_ip.ip_address
}
