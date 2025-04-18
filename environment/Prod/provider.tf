terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.104.0"
    }
  }
backend "azurerm" {
    resource_group_name  = "my-rg"
    storage_account_name = "mystorageaccount"
    container_name       = "tfstate"
    key                  = "Prod.tfstate"
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
    
  }

