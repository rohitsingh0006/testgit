  terraform {
    backend "azurerm" {
        subscription_id = "1a65c9a7-b8cc-4be5-8bb1-997cca837c32"
        resource_group_name  = "tfstate01"
        storage_account_name = "tfstrg01"
        container_name       = "cont01"
        key                  = "terraform.tfstate"
        }
    }