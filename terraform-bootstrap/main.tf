terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "backend_rg" {
  name     = "rg-taskhub-tfstate-new"
  location = "Central India"
}

resource "azurerm_storage_account" "backend_storage" {
  name                = "taskhubtfstate001new"
  resource_group_name = azurerm_resource_group.backend_rg.name
  location            = azurerm_resource_group.backend_rg.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "backend_container" {
  name               = "tfstatenew"
  storage_account_id = azurerm_storage_account.backend_storage.id
}