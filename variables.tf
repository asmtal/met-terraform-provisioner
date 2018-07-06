# Variables below have no defaults.
# They must be specified in a tfvars file or otherwise defined.

# global variables - these apply to all providers
variable "met_instance_name" {}

variable "met_user_name" {}
variable "met_company_name" {}

# aws provider variables 
variable "aws_access_key" {}

variable "aws_secret_key" {}
variable "aws_region" {}
variable "aws_availability_zone" {}

variable "aws_key_name" {}
variable "aws_centos_ami_name" {}
variable "aws_ubuntu_ami_name" {}

variable "aws_windows_ami_name" {}

# gce provider variables
variable "gce_credentials_file_name" {}

variable "gce_project" {}
variable "gce_region" {}

# MS Azure provider variables

variable "azure_client_id" {}
variable "azure_client_secret" {}
variable "azure_tenant_id" {}
