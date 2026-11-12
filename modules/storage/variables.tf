variable "resource_group_name" {
  description = "Azure resource group name."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "app_directory" {
  description = "Path to the local ToDo app."
  type        = string
}

variable "install_script" {
  description = "Installer script with LF line endings."
  type        = string
}
