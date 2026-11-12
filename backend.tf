terraform {
  backend "azurerm" {
    # Pass storage_account_name for the existing backend during terraform init.
    resource_group_name = "mate-azure-task-12"
    container_name      = "tfstate"
    key                 = "terraform.tfstate"
    use_azuread_auth    = true
  }
}
