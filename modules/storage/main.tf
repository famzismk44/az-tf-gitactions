data "azurerm_resource_group" "prof" {
  name = "class_209"
}

resource "azurerm_storage_account" "example" {
  name                     = "nextgenstoage289"
  resource_group_name      = data.azurerm_resource_group.prof.name
  location                 = data.azurerm_resource_group.prof.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}