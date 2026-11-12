variable "resource_group_name" {
  description = "Azure resource group name."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "virtual_network_name" {
  description = "Virtual network name."
  type        = string
}

variable "vnet_address_prefix" {
  description = "Virtual network IPv4 CIDR."
  type        = string
}

variable "subnet_name" {
  description = "Application subnet name."
  type        = string
}

variable "subnet_address_prefix" {
  description = "Subnet IPv4 CIDR."
  type        = string
}

variable "network_security_group_name" {
  description = "Network security group name."
  type        = string
}

variable "public_ip_address_name" {
  description = "Public IPv4 resource name."
  type        = string
}

variable "dns_label" {
  description = "Prefix for the public DNS label."
  type        = string
}

variable "access_cidr" {
  description = "Public IPv4 CIDR permitted to reach SSH and the application."
  type        = string
}
