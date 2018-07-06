# test instantiation of resources in the module.
# to be removed after initial module development is complete

module "aws1" {
  source            = "./aws"
  access_key        = "${var.aws_access_key}"
  secret_key        = "${var.aws_secret_key}"
  key_name          = "${var.aws_key_name}"
  centos_ami_name   = "${var.aws_centos_ami_name}"
  ubuntu_ami_name   = "${var.aws_ubuntu_ami_name}"
  windows_ami_name  = "${var.aws_windows_ami_name}"
  met_instance_name = "${var.met_instance_name}"
  met_user_name     = "${var.met_user_name}"
  met_company_name  = "${var.met_company_name}"
}

# module "gce1" {
#   source            = "./gce"
#   met_instance_name = "${var.met_instance_name}"
#   met_user_name     = "${var.met_user_name}"
#   met_company_name  = "${var.met_company_name}"
# }


# module "azure1" {
#   source            = "./azure"
#   met_instance_name = "${var.met_instance_name}"
#   met_user_name     = "${var.met_user_name}"
#   met_company_name  = "${var.met_company_name}"
# }

