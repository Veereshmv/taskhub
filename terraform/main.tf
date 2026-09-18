data "azurerm_client_config" "current" {}

module "resource_group" {
  source = "./modules/resource-group"

  resource_group_name = var.resource_group_name
  location            = var.location
}

module "network" {
  source = "./modules/network"

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location

  vnet_name          = var.vnet_name
  vnet_address_space = var.vnet_address_space

  aks_subnet_name   = var.aks_subnet_name
  aks_subnet_prefix = var.aks_subnet_prefix
}

module "acr" {

  source = "./modules/acr"

  acr_name = var.acr_name

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location

  sku = var.acr_sku
}

module "aks" {
  source = "./modules/aks"

  aks_name            = var.aks_name
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location

  dns_prefix = var.aks_dns_prefix
  subnet_id  = module.network.aks_subnet_id

  node_count = var.aks_node_count
  vm_size    = var.aks_vm_size
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = module.acr.acr_id
  role_definition_name = "AcrPull"
  principal_id         = module.aks.kubelet_identity_object_id
}


module "sql" {
  source = "./modules/sql"

  sql_server_name = var.sql_server_name
  database_name   = var.database_name

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location

  admin_username = var.sql_admin_username
  admin_password = var.sql_admin_password
}

module "storage" {
  source = "./modules/storage"

  storage_account_name = var.storage_account_name
  container_name       = var.storage_container_name

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
}

module "appservice" {
  source = "./modules/appservice"

  app_service_plan_name = var.app_service_plan_name
  web_app_name          = var.web_app_name

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location

  acr_login_server    = module.acr.acr_login_server
  frontend_image_name = var.frontend_image_name
  frontend_image_tag  = var.frontend_image_tag
}

resource "azurerm_role_assignment" "appservice_acr_pull" {
  scope                = module.acr.acr_id
  role_definition_name = "AcrPull"
  principal_id         = module.appservice.web_app_identity_principal_id
}

module "keyvault" {
  source = "./modules/keyvault"

  key_vault_name = var.key_vault_name

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location

  tenant_id = data.azurerm_client_config.current.tenant_id
}
