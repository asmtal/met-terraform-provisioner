provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

module "aws" {
  source            = "./aws"
  aws_key_name      = "${var.aws_key_name}"
  centos_ami_name   = "${var.centos_ami_name}"
  ubuntu_ami_name   = "${var.ubuntu_ami_name}"
  met_instance_name = "${var.met_instance_name}"
  met_user_name     = "${var.met_user_name}"
  met_company_name  = "${var.met_company_name}"
}
