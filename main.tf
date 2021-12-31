terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
  backend "azurerm" {
        resource_group_name  = "tf_be_rg"
        storage_account_name = "tfbestorageacc"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Creating a Resource Group
resource "azurerm_resource_group" "kgs_rg02" {
  name     = "${var.prefix}-rg02"
  location = "Central India"
}

# Creating a VNet
resource "azurerm_virtual_network" "kgs_vnet02" {
  name                = "${var.prefix}-vnet02"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.kgs_rg02.location
  resource_group_name = azurerm_resource_group.kgs_rg02.name
}

# Creating a subnet
resource "azurerm_subnet" "kgs_subnet02" {
  name                 = "${var.prefix}-subnet02"
  resource_group_name  = azurerm_resource_group.kgs_rg02.name
  virtual_network_name = azurerm_virtual_network.kgs_vnet02.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "kgs_nic02" {
  name                = "${var.prefix}-nic02"
  location            = azurerm_resource_group.kgs_rg02.location
  resource_group_name = azurerm_resource_group.kgs_rg02.name

  ip_configuration {
    name                          = "config2"
    subnet_id                     = azurerm_subnet.kgs_subnet02.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Creating a VM
resource "azurerm_windows_virtual_machine" "kgs_vm02" {
  name                = "${var.prefix}-vm02"
  resource_group_name = azurerm_resource_group.kgs_rg02.name
  location            = azurerm_resource_group.kgs_rg02.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.kgs_nic02.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  tags = {
    company = "kgs"
  }
}

output "azurerm_virtual_machine" {
  value       = azurerm_windows_virtual_machine.kgs_vm02.name
  description = "Name of the Azure VM."
}
