output "artifact_urls" {
  description = "Private blob URLs for the installer and app archive."
  value       = [azurerm_storage_blob.installer.url, azurerm_storage_blob.app.url]
}

output "artifact_version" {
  description = "Version derived from the installer and archive content."
  value       = parseint(substr(sha256("${md5(var.install_script)}:${data.archive_file.app.output_sha256}"), 0, 7), 16)
}

output "storage_account_name" {
  description = "Name of the artifact storage account."
  value       = azurerm_storage_account.main.name
}

output "storage_account_key" {
  description = "Storage key used by the VM extension to download the private blobs."
  value       = azurerm_storage_account.main.primary_access_key
  sensitive   = true
}
