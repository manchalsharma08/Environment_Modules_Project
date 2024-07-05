terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.104.0"
    }
     random = {
      source  = "hashicorp/random"
      version = "3.6.1"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

  provider "random" {
  # Configuration options
    
  }

