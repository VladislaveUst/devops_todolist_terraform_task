terraform {
  required_providers {
    azurerm = { source = "hashicorp/azurerm" }
    random  = { source = "hashicorp/random" }
    archive = { source = "hashicorp/archive" }
  }
}

resource "random_string" "account_suffix" {
  length  = 16
  upper   = false
  special = false
}

resource "azurerm_storage_account" "main" {
  name                            = "matetask${random_string.account_suffix.result}"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
}

resource "azurerm_storage_container" "artifacts" {
  name                  = "task-artifacts"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

data "archive_file" "app" {
  type             = "zip"
  output_path      = abspath("${path.root}/todolist-app.zip")
  output_file_mode = "0644"

  source_dir = var.app_directory
  excludes = [
    ".git/**",
    ".venv/**",
    "venv/**",
    "**/__pycache__/**",
    "**/*.pyc",
    "**/*.sqlite3*",
    "**/.env*",
    "**/*.pem",
    "**/*.key",
  ]
}

resource "azurerm_storage_blob" "app" {
  name                   = "todolist-app.zip"
  storage_account_name   = azurerm_storage_account.main.name
  storage_container_name = azurerm_storage_container.artifacts.name
  type                   = "Block"
  source                 = data.archive_file.app.output_path
  content_md5            = data.archive_file.app.output_md5
}

resource "azurerm_storage_blob" "installer" {
  name                   = "install-app.sh"
  storage_account_name   = azurerm_storage_account.main.name
  storage_container_name = azurerm_storage_container.artifacts.name
  type                   = "Block"
  source_content         = var.install_script
  content_md5            = md5(var.install_script)
}
