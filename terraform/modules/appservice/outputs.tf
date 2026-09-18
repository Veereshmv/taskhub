output "web_app_name" {
  value = azurerm_linux_web_app.frontend.name
}

output "web_app_hostname" {
  value = azurerm_linux_web_app.frontend.default_hostname
}

output "web_app_identity_principal_id" {
  value = azurerm_linux_web_app.frontend.identity[0].principal_id
}