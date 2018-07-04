# Variables below have no defaults.
# They must be specified in a tfvars file or otherwise defined.
variable "met_instance_name" {}

variable "met_user_name" {}
variable "met_company_name" {}

variable "key_name" {}

variable "centos_ami_name" {}

variable "ubuntu_ami_name" {}

#variable "windows_ami_name" {}
# Variables below have default values.
# If no other value is specified elsewhere, they will
# be set to the defaults shown below.
variable "region" {
  default = "us-east-1"
}

variable "availability_zone" {
  default = "us-east-1a"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/24"
}

variable "master_instance_type" {
  default = "m5.large"
}

variable "gitlab_instance_type" {
  default = "t2.medium"
}

variable "linux_agent_instance_type" {
  default = "t2.small"
}

variable "windows_agent_instance_type" {
  default = "m5.large"
}
