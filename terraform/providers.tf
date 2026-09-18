terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-taskhub-tfstate-new"
    storage_account_name = "taskhubtfstate001new"
    container_name       = "tfstatenew"
    key                  = "taskhub-dev.tfstate"
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  features {}
}

