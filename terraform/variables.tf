variable "resource_group_name" {
  type    = string
  default = "rg-taskhub-dev"
}

variable "location" {
  type    = string
  default = "Central India"
}

variable "vnet_name" {
  type    = string
  default = "vnet-taskhub-dev"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "aks_subnet_name" {
  type    = string
  default = "snet-aks"
}

variable "aks_subnet_prefix" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "acr_name" {
  type    = string
  default = "taskhubacrdev260826"
}

variable "acr_sku" {
  type    = string
  default = "Basic"
}

variable "aks_name" {
  type    = string
  default = "aks-taskhub-dev"
}

variable "aks_dns_prefix" {
  type    = string
  default = "taskhub-dev"
}

variable "aks_node_count" {
  type    = number
  default = 1
}

variable "aks_vm_size" {
  type    = string
  default = "Standard_D2ls_v5"
}

variable "sql_server_name" {
  type    = string
  default = "taskhubsqlserver260826"
}

variable "database_name" {
  type    = string
  default = "taskhubdb"
}

variable "sql_admin_username" {
  type    = string
  default = "sqladminuser"
}

variable "sql_admin_password" {
  type      = string
  sensitive = true
}

variable "storage_account_name" {
  type    = string
  default = "taskhubstorage260826"
}

variable "storage_container_name" {
  type    = string
  default = "attachments"
}

variable "app_service_plan_name" {
  type    = string
  default = "asp-taskhub-dev"
}

variable "web_app_name" {
  type    = string
  default = "taskhub-frontend-dev260826"
}

variable "frontend_image_name" {
  type    = string
  default = "taskhub-frontend"
}

variable "frontend_image_tag" {
  type    = string
  default = "1.0"
}

variable "key_vault_name" {
  type    = string
  default = "kv-taskhub-dev260826"
}