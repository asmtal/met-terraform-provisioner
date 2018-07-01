resource "aws_vpc" "met-vpc" {
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_hostnames = true

  tags {
    Name              = "MET-vpc"
    MET_instance_name = "${var.met_instance_name}"
    MET_user_name     = "${var.met_user_name}"
    MET_company_name  = "${var.met_company_name}"
  }
}

resource "aws_subnet" "met-subnet" {
  vpc_id            = "${aws_vpc.met-vpc.id}"
  cidr_block        = "${var.vpc_cidr_block}"
  availability_zone = "${var.availability_zone}"

  tags {
    Name              = "MET-subnet"
    MET_instance_name = "${var.met_instance_name}"
    MET_user_name     = "${var.met_user_name}"
    MET_company_name  = "${var.met_company_name}"
  }
}

resource "aws_security_group" "met-default-security-group" {
  name        = "MET_default"
  description = "Allow inbound ssh and all outbound traffic"
  vpc_id      = "${aws_vpc.met-vpc.id}"

  # Allow inbound ssh from everywhere
  ingress {
    from_port   = 22
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
    Name              = "MET default security group"
    MET_instance_name = "${var.met_instance_name}"
    MET_user_name     = "${var.met_user_name}"
    MET_company_name  = "${var.met_company_name}"
  }
}

resource "aws_security_group" "met-master-security-group" {
  name        = "MET_master"
  description = "Allow inbound traffic to Puppet master required ports"
  vpc_id      = "${aws_vpc.met-vpc.id}"

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
    Name              = "MET master security group"
    MET_instance_name = "${var.met_instance_name}"
    MET_user_name     = "${var.met_user_name}"
    MET_company_name  = "${var.met_company_name}"
  }
}

resource "aws_instance" "met-pe-master" {
  ami                         = "${var.centos_ami_name}"
  instance_type               = "${var.master_instance_type}"
  subnet_id                   = "${aws_subnet.met-subnet.id}"
  key_name                    = "${var.aws_key_name}"
  associate_public_ip_address = true

  vpc_security_group_ids = [
    "${aws_security_group.met-default-security-group.id}",
    "${aws_security_group.met-master-security-group.id}",
  ]

  root_block_device = {
    delete_on_termination = true
  }

  tags {
    Name              = "MET PE master"
    MET_instance_name = "${var.met_instance_name}"
    MET_user_name     = "${var.met_user_name}"
    MET_company_name  = "${var.met_company_name}"
  }
}

resource "aws_instance" "met-gitlab" {
  ami                         = "${var.centos_ami_name}"
  instance_type               = "${var.gitlab_instance_type}"
  subnet_id                   = "${aws_subnet.met-subnet.id}"
  key_name                    = "${var.aws_key_name}"
  availability_zone           = "${var.availability_zone}"
  associate_public_ip_address = true

  vpc_security_group_ids = [
    "${aws_security_group.met-default-security-group.id}",
  ]

  root_block_device = {
    delete_on_termination = true
  }

  tags {
    Name              = "MET gitlab"
    MET_instance_name = "${var.met_instance_name}"
    MET_user_name     = "${var.met_user_name}"
    MET_company_name  = "${var.met_company_name}"
  }
}

resource "aws_instance" "met-centos-agent" {
  ami                         = "${var.centos_ami_name}"
  instance_type               = "${var.linux_agent_instance_type}"
  subnet_id                   = "${aws_subnet.met-subnet.id}"
  key_name                    = "${var.aws_key_name}"
  associate_public_ip_address = true
  count                       = 2

  vpc_security_group_ids = [
    "${aws_security_group.met-default-security-group.id}",
  ]

  root_block_device = {
    delete_on_termination = true
  }

  tags {
    Name              = "MET centos agent ${count.index}"
    MET_instance_name = "${var.met_instance_name}"
    MET_user_name     = "${var.met_user_name}"
    MET_company_name  = "${var.met_company_name}"
  }
}

resource "aws_instance" "ubuntu-agent" {
  ami                         = "${var.ubuntu_ami_name}"
  instance_type               = "${var.linux_agent_instance_type}"
  subnet_id                   = "${aws_subnet.met-subnet.id}"
  key_name                    = "${var.aws_key_name}"
  associate_public_ip_address = true
  count                       = 2

  vpc_security_group_ids = [
    "${aws_security_group.met-default-security-group.id}",
  ]

  root_block_device = {
    delete_on_termination = true
  }

  tags {
    Name              = "MET ubuntu agent ${count.index}"
    MET_instance_name = "${var.met_instance_name}"
    MET_user_name     = "${var.met_user_name}"
    MET_company_name  = "${var.met_company_name}"
  }
}
