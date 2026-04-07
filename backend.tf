  terraform {
    backend "azurerm" {
        subscription_id = "67bc5246-befd-4265-a0e6-6b7f6196364f"
        resource_group_name  = "rg-tfstate-dev"
        storage_account_name = "stsharedtfstatedev"
        container_name       = "tfstate-dev"
        key                  = "testgit.terraform.tfstate"
        }
    }
