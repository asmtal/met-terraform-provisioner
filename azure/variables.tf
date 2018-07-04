variable "met_instance_name" {}
variable "met_user_name" {}
variable "met_company_name" {}

variable "address_space" {
  default = "10.0.0.0/24"
}

variable "address_prefix" {
  default = "10.0.0.0/24"
}

variable "master_vm_size" {
  default = "Standard_DS1_v2"
}
