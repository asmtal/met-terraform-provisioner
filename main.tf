# global variables for the MET
# These aer shared across all providers
# and are generally used for resource IDs, names, and tags
met_instance_name = "gsarjeant"

met_user_name = "Greg Sarjeant"

met_company_name = "Puppet"

# Supported providers
#   You can use this module to provision a MET environment in the following public clouds:
#
# Amazon AWS
# Google Compute Engine
# Microsoft Azure
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

# Create credentials
# Create a project
# Enable compute engine API access for project
#    NOTE: This takes forever
# some shit about quotas
provider "google" {
  credentials = "${file("${var.gce_credentials_file_name}")}"
  project     = "${var.gce_project}"
  region      = "${var.gce_region}"
}

# MS Azure provider
provider "azure" {
  client_id     = "${var.azure_client_id}"
  client_secret = "${var.azure_client_secret}"
  tenant_id     = "${var.azure_client_id}"
}
