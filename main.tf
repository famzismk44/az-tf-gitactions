# # resource "azurerm_resource_group" "demo" {
# #   name     = "terraform-rg"
# #   location = "East US"
# # }

# data "azurerm_resource_group" "prof" {
#   name = var.resource
# }

# resource "azurerm_virtual_network" "network" {
#   name                = var.network_name
#   address_space       = ["10.0.0.0/16"]
#   location            = data.azurerm_resource_group.prof.location
#   resource_group_name = data.azurerm_resource_group.prof.name
# }

# resource "azurerm_subnet" "subn" {
#   name                 = "internal"
#   resource_group_name  = data.azurerm_resource_group.prof.name
#   virtual_network_name = azurerm_virtual_network.network.name
#   address_prefixes     = ["10.0.2.0/24"]
# }

# resource "azurerm_network_interface" "interf" {
#   name                = "example-nic"
#   location            = data.azurerm_resource_group.prof.location
#   resource_group_name = data.azurerm_resource_group.prof.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.subn.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

# resource "azurerm_linux_virtual_machine" "myvm2" {
#   name                            = var.vm_name
#   resource_group_name             = data.azurerm_resource_group.prof.name
#   location                        = data.azurerm_resource_group.prof.location
#   size                            = var.size
#   admin_username                  = var.username
#   admin_password                  = var.password
#   disable_password_authentication = false
#   network_interface_ids = [
#     azurerm_network_interface.interf.id,
#   ]



#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }
# }



# # resource "azurerm_resource_group" "smk" {
# #   name     = "terra209-rg"
# #   location = "East US"
# # }

# resource "azurerm_storage_account" "stoage" {
#   name                     = var.storage_name
#   resource_group_name      = data.azurerm_resource_group.prof.name
#   location                 = data.azurerm_resource_group.prof.location
#   account_tier             = "Standard"
#   account_replication_type = "GRS"

#   tags = {
#     environment = "testing"
#   }
# }



data "azurerm_resource_group" "prof" {
  name = "class_209"
}

module "vm_name" {
  source = "./modules/vm"
}

module "storage_account_name" {
  source = "./modules/storage"
}