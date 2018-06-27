provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "master" {
  ami           = "ami-9887c6e7"
  instance_type = "m5.large"
  subnet_id     = "subnet-0a93e76029daf16bf"

  tags = {
    Name       = "MET master"
    Consultant = "Joe Consultant"
    Partner    = "PartnerCorp"
  }

}
