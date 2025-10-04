terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.46.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "ede4e123-1257-4a3f-843a-e1864c8481ba"
}





