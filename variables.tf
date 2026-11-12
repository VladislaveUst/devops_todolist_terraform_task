variable "resource_group_name" {
  description = "Azure resource group name."
  type        = string
  default     = "mate-azure-task-12"
}

variable "location" {
  description = "Azure region."
  type        = string
  default     = "swedencentral"
}

variable "virtual_network_name" {
  description = "Virtual network name."
  type        = string
  default     = "vnet"
}

variable "vnet_address_prefix" {
  description = "Virtual network IPv4 CIDR."
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_name" {
  description = "Application subnet name."
  type        = string
  default     = "default"
}

variable "subnet_address_prefix" {
  description = "Subnet IPv4 CIDR."
  type        = string
  default     = "10.0.0.0/24"
}

variable "network_security_group_name" {
  description = "Network security group name."
  type        = string
  default     = "defaultnsg"
}

variable "public_ip_address_name" {
  description = "Public IPv4 resource name."
  type        = string
  default     = "linuxboxpip"
}

variable "dns_label" {
  description = "Prefix for the public DNS label."
  type        = string
  default     = "matetask"
}

variable "access_cidr" {
  description = "Public IPv4 CIDR permitted to reach SSH and the application."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.access_cidr)) && endswith(var.access_cidr, "/32")
    error_message = "Enter the client's public IPv4 address with a /32 suffix."
  }
}

variable "vm_name" {
  description = "Linux virtual machine name."
  type        = string
  default     = "matebox"
}

variable "vm_size" {
  description = "Azure virtual machine size."
  type        = string
  default     = "Standard_B1s"
}

variable "ssh_key_public" {
  description = "OpenSSH RSA public key for the VM administrator."
  type        = string
}
