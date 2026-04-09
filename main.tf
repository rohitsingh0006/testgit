resource "azurerm_resource_group" "rgs" {
    name = "rg-dev01"
    location ="South India"
}

resource "azurerm_resource_group" "rg01" {
  name     = "resgrp01"
  location = "Central India"
}

resource "azurerm_virtual_network" "vnet01" {
  name                = "virnet01"
  location            = azurerm_resource_group.rg01.location
  resource_group_name = azurerm_resource_group.rg01.name
  address_space       = ["192.168.0.0/16"]
}

resource "azurerm_subnet" "sub01" {
  name                 = "subnet01"
  resource_group_name  = azurerm_resource_group.rg01.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = ["192.168.1.0/24"]
}

resource "azurerm_subnet" "azbas01" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg01.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = ["192.168.2.0/24"]
}

resource "azurerm_public_ip" "pip01" {
  name                = "pip01"
  location            = azurerm_resource_group.rg01.location
  resource_group_name = azurerm_resource_group.rg01.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "nic01" {
  name                = "nic01"
  location            = azurerm_resource_group.rg01.location
  resource_group_name = azurerm_resource_group.rg01.name

  ip_configuration {
    name                          = "ip01"
    subnet_id                     = azurerm_subnet.sub01.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm01" {
  name                = "vm01"
  location            = azurerm_resource_group.rg01.location
  resource_group_name = azurerm_resource_group.rg01.name
  network_interface_ids = [azurerm_network_interface.nic01.id]

  disable_password_authentication = false
  admin_username                  = "adminuser"
  admin_password                  = "admin@123"
  size                            = "Standard_D2s_v4"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "24_04-lts"
    version   = "latest"
  }
}

resource "azurerm_bastion_host" "bas01" {
  name                = "bas01"
  location            = azurerm_resource_group.rg01.location
  resource_group_name = azurerm_resource_group.rg01.name

  ip_configuration {
    name                 = "baseip01"
    subnet_id            = azurerm_subnet.azbas01.id
    public_ip_address_id = azurerm_public_ip.pip01.id
  }
}
