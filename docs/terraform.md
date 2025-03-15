# Terraform Documentation
## Overview
This document describes how Terraform is used to provision the Azure infrastructure. Terraform automates the creation of Azure resources, including:
- **Resource Group**: rg-ansiform
- **Virtual Network**: vnet-ansiform | 10.0.0.0/16
- **Subnet**: subnet-ansiform | 10.0.1.0/24
- **Public IP**: webapp-publicip-ansiform
- **Network Interface**: nic-ansiform
- **Virtual Machine**: webserver-vm
- **Network Security Group**: webapp-nsg | Allow Port 22 (SSH) & Port 80 (HTTP)
- **Azure MySQL Flexible Server**: db-ansiform
- **Azure Storage Account**: ansiformstorage

## Prerequisites
Before running Terraform, ensure you have:
- Terraform installed on your local machine
- Azure CLI authenticated
- An Azure subscription
- SSH key pair generated

## Folder structure
```sh
terraform/
├── main.tf
├── outputs.tf
└── providers.tf
```

## Terraform Configuration Files
### 1. providers.tf (Azure Provider Configuration)
```sh
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}

provider "azurerm" {
    features {}
    subscription_id = "3087dfe8-7fda-4ff3-adcf-86ab5103796b"
}
```
### 2. main.tf (Infrastructure Definition)
```sh
resource "azurerm_resource_group" "rg" {
    name     = "rg-ansiform"
    location = "North Europe"
}

resource "azurerm_virtual_network" "vnet" {
    name                = "vnet-ansiform"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
    name = "subnet-ansiform"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["10.0.1.0/24"]
}

resource azurerm_public_ip "webapp_ip" {
    name = "webapp-publicip-ansiform"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method = "Static"
}

resource azurerm_network_interface "nic" {
    name = "nic-ansiform"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
        name = "internal"
        subnet_id = azurerm_subnet.subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = azurerm_public_ip.webapp_ip.id
    }
}

resource "azurerm_linux_virtual_machine" "webapp" {
    name = "webserver-vm"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    size = "Standard_B1s"
    admin_username = "ansiform"
    network_interface_ids = [azurerm_network_interface.nic.id]

    admin_ssh_key {
        username = "ansiform"
        public_key = file("~/.ssh/id_rsa.pub")
    }

    os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer = "0001-com-ubuntu-server-jammy"
        sku = "22_04-lts-gen2"
        version = "latest"
    }
}


    resource "azurerm_network_security_group" "webapp_nsg" {
    name                = "webapp-nsg"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    security_rule {
        name                       = "AllowSSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

        security_rule {
        name                       = "AllowHTTP"
        priority                   = 1011
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}

resource "azurerm_network_interface_security_group_association" "webapp_nsg_association" {
    network_interface_id      = azurerm_network_interface.nic.id
    network_security_group_id = azurerm_network_security_group.webapp_nsg.id
}

resource "azurerm_mysql_flexible_server" "db" {
    name = "db-ansiform"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    administrator_login = "adminuser"
    administrator_password = "Password1234!"
    sku_name = "B_Standard_B1ms"
}

resource "azurerm_storage_account" "storage"{
    name = "ansiformstorage"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    account_tier = "Standard"
    account_replication_type = "LRS"
}
```

### 3. outputs.tf (Output Values)
```sh
output "public_ip" {
    value = azurerm_public_ip.webapp_ip.ip_address
}
```

## Running Terraform
1. Initialize Terraform:
```sh
terraform init
```
2. Plan the deployment:
```sh
terraform plan
```
3. Apply the changes:
```sh
terraform apply
```
