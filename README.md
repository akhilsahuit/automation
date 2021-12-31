With this assignment below resources are created in Azure using the Azure DevOps pipeline:
1) Resource Group
2) VNet
3) Subnet
4) NIC
5) Windows VM
6) OS disk

Approach used:
a) Created Service Principal in Azure and assigned Contributer access.
b) Configured mandatory params in the Azure DevOps Library (ARM_CLIENT_ID, ARM_TENANT_ID, ARM_CLIENT_SECRETARM_SUBSCRIPTION_ID) [Screenshot shared]
c) Azure Storage account has been used as the remote backend. terraform.tfstate is stored in Azure Storage account [screenshot attached] 
