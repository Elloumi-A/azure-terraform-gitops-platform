terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "location" {
  description = "Azure region for the lab"
  type        = string
}

resource "azurerm_resource_group" "lab" {
  name     = "rg-devops-platform-lab"
  location = var.location
}
