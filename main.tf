variable "ARM_SUBSCRIPTION_ID" { type = string }

variable "ARM_TENANT_ID" { type = string }

variable "ARM_CLIENT_ID" { type = string }

variable "ARM_CLIENT_SECRET" { type = string }

terraform {
  required_version = ">=1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">3.43.0"
    }
  }
  cloud {
    organization = "testsp"
    workspaces {
      name = "TerraformCI"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
  subscription_id            = var.ARM_SUBSCRIPTION_ID
  tenant_id                  = var.ARM_TENANT_ID
  client_id                  = var.ARM_CLIENT_ID
  client_secret              = var.ARM_CLIENT_SECRET
}

resource "azurerm_resource_group" "rg" {
  name     = "813-1405035c-hands-on-with-terraform-on-azure"
  location = "eastus"
}


module "securestorage" {
  source               = "app.terraform.io/testsp/securestorage/azurerm"
  version              = "1.0.1"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_name = "mystorageacct12345unique"
  # Replace with a globally unique name

}