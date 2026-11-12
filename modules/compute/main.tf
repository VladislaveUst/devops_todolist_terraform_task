terraform {
  required_providers {
    azurerm = { source = "hashicorp/azurerm" }
  }
}

resource "azurerm_network_interface" "main" {
  name                = "${var.vm_name}-nic"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "primary"
    subnet_id                     = var.subnet_id
    public_ip_address_id          = var.public_ip_address_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_ssh_public_key" "main" {
  name                = "linuxboxsshkey"
  resource_group_name = var.resource_group_name
  location            = var.location
  public_key          = trimspace(var.ssh_key_public)
}

resource "azurerm_linux_virtual_machine" "main" {
  name                              = var.vm_name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  size                              = var.vm_size
  admin_username                    = "azureuser"
  disable_password_authentication   = true
  vm_agent_platform_updates_enabled = true
  network_interface_ids             = [azurerm_network_interface.main.id]

  admin_ssh_key {
    username   = "azureuser"
    public_key = azurerm_ssh_public_key.main.public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

resource "azurerm_virtual_machine_extension" "todo" {
  name                       = "todo-install"
  virtual_machine_id         = azurerm_linux_virtual_machine.main.id
  publisher                  = "Microsoft.Azure.Extensions"
  type                       = "CustomScript"
  type_handler_version       = "2.1"
  auto_upgrade_minor_version = true

  settings = jsonencode({
    timestamp = var.artifact_version
  })

  protected_settings = jsonencode({
    fileUris           = var.artifact_urls
    commandToExecute   = "bash install-app.sh"
    storageAccountName = var.artifact_account_name
    storageAccountKey  = var.artifact_account_key
  })
}
