provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "master" {
  ami                         = "ami-9887c6e7"
  instance_type               = "m5.large"
  subnet_id                   = "subnet-0a93e76029daf16bf"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = true

  vpc_security_group_ids = [
    "sg-0c51c7afc3e5d89c0",
    "sg-0b20d19871015dca1",
  ]

  tags = {
    Name       = "MET master"
    Consultant = "Joe Consultant"
    Partner    = "PartnerCorp"
  }
}

resource "aws_instance" "gitlab" {
  ami                         = "ami-9887c6e7"
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-0a93e76029daf16bf"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = true

  vpc_security_group_ids = [
    "sg-0c51c7afc3e5d89c0",
  ]

  tags = {
    Name       = "MET gitlab"
    Consultant = "Joe Consultant"
    Partner    = "PartnerCorp"
  }
}

resource "aws_instance" "centos-agent-1" {
  ami                         = "ami-9887c6e7"
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-0a93e76029daf16bf"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = true

  vpc_security_group_ids = [
    "sg-0c51c7afc3e5d89c0",
  ]

  tags = {
    Name       = "MET centos agent 1"
    Consultant = "Joe Consultant"
    Partner    = "PartnerCorp"
  }
}

resource "aws_instance" "centos-agent-2" {
  ami                         = "ami-9887c6e7"
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-0a93e76029daf16bf"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = true

  vpc_security_group_ids = [
    "sg-0c51c7afc3e5d89c0",
  ]

  tags = {
    Name       = "MET centos agent 2"
    Consultant = "Joe Consultant"
    Partner    = "PartnerCorp"
  }
}

resource "aws_instance" "ubuntu-agent-1" {
  ami                         = "ami-6061141f"
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-0a93e76029daf16bf"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = true

  vpc_security_group_ids = [
    "sg-0c51c7afc3e5d89c0",
  ]

  tags = {
    Name       = "MET ubuntu agent 1"
    Consultant = "Joe Consultant"
    Partner    = "PartnerCorp"
  }
}

resource "aws_instance" "ubuntu-agent-2" {
  ami                         = "ami-6061141f"
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-0a93e76029daf16bf"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = true

  vpc_security_group_ids = [
    "sg-0c51c7afc3e5d89c0",
  ]

  tags = {
    Name       = "MET ubuntu agent 2"
    Consultant = "Joe Consultant"
    Partner    = "PartnerCorp"
  }
}
