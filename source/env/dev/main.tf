terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

module "vnet" {
  source = "../../modules/vnet"

  vnet_name           = var.vnet_name
  subnet1_name        = var.subnet1_name
  subnet2_name        = var.subnet2_name
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
}


module "public_vm" {
  source = "../../modules/vm"

  vm_name             = "jumpbox"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  subnet_id = module.vnet.subnet1_id

  ssh_public_key = "~/.ssh/azure_rsa.pub"

  create_public_ip = true
}

module "private_vm" {
  source = "../../modules/vm"

  vm_name             = "private-vm"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  subnet_id = module.vnet.subnet2_id

  ssh_public_key = "~/.ssh/azure_rsa.pub"

  create_public_ip = false
}


module "nsg_public" {
  source              = "../../modules/nsg"
  nsg_name            = "public-nsg"
  nsg_type            = "public"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}

module "nsg_private" {
  source                = "../../modules/nsg"
  nsg_name              = "private-nsg"
  nsg_type              = "private"
  jumpbox_subnet_prefix = "10.0.10.0/24"
  location              = var.location
  resource_group_name   = azurerm_resource_group.main.name
}

resource "azurerm_subnet_network_security_group_association" "public_assoc" {
  subnet_id                 = module.vnet.subnet1_id
  network_security_group_id = module.nsg_public.nsg_id
}

resource "azurerm_subnet_network_security_group_association" "private_assoc" {
  subnet_id                 = module.vnet.subnet2_id
  network_security_group_id = module.nsg_private.nsg_id
}

output "jumpbox_public_ip" {
  value = module.public_vm.public_ip
}

output "private_vm_ip" {
  value = module.private_vm.private_ip
}