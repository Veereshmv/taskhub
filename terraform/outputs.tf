output "resource_group_name" {
  value = module.resource_group.resource_group_name
}

output "resource_group_location" {
  value = module.resource_group.resource_group_location
}

output "vnet_id" {
  value = module.network.vnet_id
}

output "aks_subnet_id" {
  value = module.network.aks_subnet_id
}

output "acr_name" {
  value = module.acr.acr_name
}

output "acr_login_server" {
  value = module.acr.acr_login_server
}

output "aks_name" {
  value = module.aks.aks_name
}

output "aks_id" {
  value = module.aks.aks_id
}

output "sql_server_name" {
  value = module.sql.sql_server_name
}

output "database_name" {
  value = module.sql.database_name
}

output "sql_server_fqdn" {
  value = module.sql.server_fqdn
}

output "storage_account_name" {
  value = module.storage.storage_account_name
}

output "storage_container_name" {
  value = module.storage.container_name
}

output "storage_blob_endpoint" {
  value = module.storage.primary_blob_endpoint
}

output "web_app_name" {
  value = module.appservice.web_app_name
}

output "web_app_hostname" {
  value = module.appservice.web_app_hostname
}

output "key_vault_name" {
  value = module.keyvault.key_vault_name
}

output "key_vault_id" {
  value = module.keyvault.key_vault_id
}