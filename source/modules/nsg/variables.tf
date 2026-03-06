variable "nsg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "nsg_type" {
  type = string 
} 

variable "jumpbox_subnet_prefix" {
  description = "The CIDR range of the jumpbox subnet"
  type        = string
  default     = "10.0.10.0/24"
}