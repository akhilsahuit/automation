With this assignment below resources are created in Azure using the Azure DevOps pipeline:
1) Resource Group
2) VNet
3) Subnet
4) NIC
5) Windows VM
6) OS disk

Approach used:
1) Created Service Principal in Azure and assigned Contributer access.
2) Configured mandatory params in the Azure DevOps Library (ARM_CLIENT_ID, ARM_TENANT_ID, ARM_CLIENT_SECRETARM_SUBSCRIPTION_ID) [Screenshot shared in the images folder]
3) Azure Storage account has been used as the remote backend. terraform.tfstate is stored in Azure Storage account [screenshot shared in the images folder] 
