provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_security_group" "met-default" {
  name        = "MET_default"
  description = "Allow inbound ssh and all outbound traffic"
  vpc_id      = "vpc-0076fc811da456d76"

  #vpc_id      = "${aws_vpc.main.id}"

  # Allow inbound ssh from everywhere
  ingress {
    from_port   = 0
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "MET_default"
  }
}

resource "aws_security_group" "met-master" {
  name        = "MET_master"
  description = "Allow inbound traffic to Puppet master required ports"
  vpc_id      = "vpc-0076fc811da456d76"

  #vpc_id      = "${aws_vpc.main.id}"

  # Allow inbound traffic to the puppet server from everywhere
  ingress {
    from_port   = 0
    to_port     = 8140
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow inbound https traffic from everywhere
  ingress {
    from_port   = 0
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow inbound orchestrator traffic from everywhere
  ingress {
    from_port   = 0
    to_port     = 8142
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound MCO traffic from everywhere
  # NOTE: Putting this here but commenting it out because MCO is deprecated.
  # ingress {
  #   from_port   = 0
  #   to_port     = 8142
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  tags {
    Name = "MET_master"
  }
}

resource "aws_instance" "master" {
  ami                         = "ami-9887c6e7"
  instance_type               = "m5.large"
  subnet_id                   = "subnet-0a93e76029daf16bf"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = true

  vpc_security_group_ids = [
    "${aws_security_group.met-default.id}",
    "${aws_security_group.met-master.id}",
  ]

  # vpc_security_group_ids = [
  #   "sg-0c51c7afc3e5d89c0",
  #   "sg-0b20d19871015dca1",
  # ]

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
    "${aws_security_group.met-default.id}",
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
    "${aws_security_group.met-default.id}",
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
    "${aws_security_group.met-default.id}",
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
    "${aws_security_group.met-default.id}",
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
    "${aws_security_group.met-default.id}",
  ]

  tags = {
    Name       = "MET ubuntu agent 2"
    Consultant = "Joe Consultant"
    Partner    = "PartnerCorp"
  }
}
