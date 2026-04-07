# 1. Create a resource group
az group create --name rg-tfstate-dev --location southindia

# 2. Create a storage account
az storage account create --name stsharedtfstatedev --resource-group rg-tfstate-dev --location southindia --sku Standard_LRS --kind StorageV2

# 3. Create a container inside the storage account
az storage container create --name tfstate-dev --account-name stsharedtfstatedev --auth-mode login
