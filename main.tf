terraform {
    required_providers {
        azurerm = {
            source ="hashicorp/azurerm"
            version = "4.24.0"
        }
    }
}


provider "azurerm" {
    features {}
    subscription_id = "1a65c9a7-b8cc-4be5-8bb1-997cca837c32"
}

resource "azurerm_resource_group" "rgrg01" {
    name = "stst01"
    location ="Central India"
}
resource "azurerm_resource_group" "rgrg02" {
    name = "stpt02"
    location ="East US"
}