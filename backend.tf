terraform {
  backend "azurerm" {
    resource_group_name  = "class_209"
    storage_account_name = "meubackendfortf"
    container_name       = "backend"
    key                  = "terraform.tfstate"
  }
}