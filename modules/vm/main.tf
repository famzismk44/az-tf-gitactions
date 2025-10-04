data "azurerm_resource_group" "prof" {
  name = "class_209"
}

resource "azurerm_virtual_network" "network" {
  name                = "fam-network"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.prof.location
  resource_group_name = data.azurerm_resource_group.prof.name
}

resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = data.azurerm_resource_group.prof.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = data.azurerm_resource_group.prof.location
  resource_group_name = data.azurerm_resource_group.prof.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "terra-machine"
  resource_group_name = data.azurerm_resource_group.prof.name
  location            = data.azurerm_resource_group.prof.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password = "Admin@123456$"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]



  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}