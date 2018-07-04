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

# module "aws1" {
#   source            = "./aws"
#   aws_key_name      = "${var.aws_key_name}"
#   centos_ami_name   = "${var.centos_ami_name}"
#   ubuntu_ami_name   = "${var.ubuntu_ami_name}"
#   met_instance_name = "${var.met_instance_name}"
#   met_user_name     = "${var.met_user_name}"
#   met_company_name  = "${var.met_company_name}"
# }

# module "gce1" {
#   source            = "./gce"
#   met_instance_name = "${var.met_instance_name}"
#   met_user_name     = "${var.met_user_name}"
#   met_company_name  = "${var.met_company_name}"
# }

module "azure1" {
  source            = "./azure"
  met_instance_name = "${var.met_instance_name}"
  met_user_name     = "${var.met_user_name}"
  met_company_name  = "${var.met_company_name}"
}
