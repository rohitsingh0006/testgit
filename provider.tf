# this is newly added file for provider 
terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "4.23.0"
        }
    }
}

provider "azurerm" {
    features {}
    subscription_id = "67bc5246-befd-4265-a0e6-6b7f6196364f"
}