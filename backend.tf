terraform {
  backend "azurerm" {
    resource_group_name  = "class1016"
    storage_account_name = "meubackendfortf"
    container_name       = "mybackendtf"
    key                  = "terraform.tfstate"
  }
}