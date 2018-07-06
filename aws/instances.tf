resource "aws_instance" "met-pe-master" {
  ami                         = "${var.centos_ami_name}"
  instance_type               = "${var.master_instance_type}"
  subnet_id                   = "${aws_subnet.met-subnet.id}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = true

  vpc_security_group_ids = [
    "${aws_security_group.met-sg-linux-default.id}",
    "${aws_security_group.met-sg-inbound-pe-master.id}",
  ]

  root_block_device = {
    delete_on_termination = true
  }

  tags {
    Name              = "met-pe-master-${var.met_instance_name}"
    MET_instance_name = "${var.met_instance_name}"
    MET_user_name     = "${var.met_user_name}"
    MET_company_name  = "${var.met_company_name}"
  }
}

# Need to fix the security group here
resource "aws_instance" "met-compile-master" {
  ami                         = "${var.centos_ami_name}"
  instance_type               = "${var.compile_master_instance_type}"
  subnet_id                   = "${aws_subnet.met-subnet.id}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = true
  count                       = "${var.compile_master_count}"

  vpc_security_group_ids = [
    "${aws_security_group.met-sg-linux-default.id}",
    "${aws_security_group.met-sg-inbound-pe-master.id}",
  ]

  root_block_device = {
    delete_on_termination = true
  }

  tags {
    Name              = "met-compile-master-${var.met_instance_name}-${count.index}"
    MET_instance_name = "${var.met_instance_name}"
    MET_user_name     = "${var.met_user_name}"
    MET_company_name  = "${var.met_company_name}"
  }
}

resource "aws_instance" "met-gitlab" {
  ami                         = "${var.centos_ami_name}"
  instance_type               = "${var.gitlab_instance_type}"
  subnet_id                   = "${aws_subnet.met-subnet.id}"
  key_name                    = "${var.key_name}"
  availability_zone           = "${var.availability_zone}"
  associate_public_ip_address = true

  vpc_security_group_ids = [
    "${aws_security_group.met-sg-linux-default.id}",
  ]

  root_block_device = {
    delete_on_termination = true
  }

  tags {
    Name              = "met-gitlab-${var.met_instance_name}"
    MET_instance_name = "${var.met_instance_name}"
    MET_user_name     = "${var.met_user_name}"
    MET_company_name  = "${var.met_company_name}"
  }
}

resource "aws_instance" "met-centos-agent" {
  ami                         = "${var.centos_ami_name}"
  instance_type               = "${var.linux_agent_instance_type}"
  subnet_id                   = "${aws_subnet.met-subnet.id}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = true
  count                       = "${var.centos_agent_count}"

  vpc_security_group_ids = [
    "${aws_security_group.met-sg-linux-default.id}",
  ]

  root_block_device = {
    delete_on_termination = true
  }

  tags {
    Name              = "met-centos-agent-${var.met_instance_name}-${count.index}"
    MET_instance_name = "${var.met_instance_name}"
    MET_user_name     = "${var.met_user_name}"
    MET_company_name  = "${var.met_company_name}"
  }
}

resource "aws_instance" "met-ubuntu-agent" {
  ami                         = "${var.ubuntu_ami_name}"
  instance_type               = "${var.linux_agent_instance_type}"
  subnet_id                   = "${aws_subnet.met-subnet.id}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = true
  count                       = "${var.ubuntu_agent_count}"

  vpc_security_group_ids = [
    "${aws_security_group.met-sg-linux-default.id}",
  ]

  root_block_device = {
    delete_on_termination = true
  }

  tags {
    Name              = "met-ubuntu-agent-${var.met_instance_name}-${count.index}"
    MET_instance_name = "${var.met_instance_name}"
    MET_user_name     = "${var.met_user_name}"
    MET_company_name  = "${var.met_company_name}"
  }
}

resource "aws_instance" "met-windows-agent" {
  ami                         = "${var.windows_ami_name}"
  instance_type               = "${var.windows_agent_instance_type}"
  subnet_id                   = "${aws_subnet.met-subnet.id}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = true
  count                       = "${var.windows_agent_count}"

  vpc_security_group_ids = [
    "${aws_security_group.met-sg-windows-default.id}",
  ]

  root_block_device = {
    delete_on_termination = true
  }

  tags {
    Name              = "met-windows-agent-${var.met_instance_name}-${count.index}"
    MET_instance_name = "${var.met_instance_name}"
    MET_user_name     = "${var.met_user_name}"
    MET_company_name  = "${var.met_company_name}"
  }
}
