variable "resource_group_name" {
  description = "Azure resource group name."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "vm_name" {
  description = "Linux virtual machine name."
  type        = string
}

variable "vm_size" {
  description = "Azure virtual machine size."
  type        = string
}

variable "ssh_key_public" {
  description = "OpenSSH RSA public key for the VM administrator."
  type        = string
}

variable "subnet_id" {
  description = "ID of the application subnet."
  type        = string
}

variable "public_ip_address_id" {
  description = "ID of the VM public IP."
  type        = string
}

variable "artifact_account_name" {
  description = "Azure Storage account containing the deployment files."
  type        = string
}

variable "artifact_account_key" {
  description = "Storage credential for the Custom Script extension."
  type        = string
  sensitive   = true
}

variable "artifact_urls" {
  description = "Private blob URLs for the installer and app archive."
  type        = list(string)
}

variable "artifact_version" {
  description = "Numeric content version of the deployment files."
  type        = number
}
