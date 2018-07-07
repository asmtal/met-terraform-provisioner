resource "aws_vpc" "met-vpc" {
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_hostnames = true

  tags {
    Name              = "met-vpc-${var.met_instance_name}"
    MET_instance_name = "${var.met_instance_name}"
    MET_user_name     = "${var.met_user_name}"
    MET_company_name  = "${var.met_company_name}"
  }
}

resource "aws_subnet" "met-subnet" {
  vpc_id            = "${aws_vpc.met-vpc.id}"
  cidr_block        = "${var.public_subnet_cidr_block}"
  availability_zone = "${var.availability_zone}"

  tags {
    Name              = "met-public-subnet-${var.met_instance_name}"
    MET_instance_name = "${var.met_instance_name}"
    MET_user_name     = "${var.met_user_name}"
    MET_company_name  = "${var.met_company_name}"
  }
}

resource "aws_internet_gateway" "met-igw" {
  vpc_id = "${aws_vpc.met-vpc.id}"

  tags {
    Name = "met-internet-gateway-${var.met_instance_name}"
  }
}

resource "aws_route_table" "met-public-rt" {
  vpc_id = "${aws_vpc.met-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.met-igw.id}"
  }

  tags {
    Name = "met-public-routing-table-${var.met_instance_name}"
  }
}

# Assign the route table to the public Subnet
resource "aws_route_table_association" "met-public-rta" {
  subnet_id      = "${aws_subnet.met-subnet.id}"
  route_table_id = "${aws_route_table.met-public-rt.id}"
}

resource "aws_security_group" "met-sg-linux-default" {
  name        = "MET_sg_linux_default"
  description = "Allow inbound ssh and all outbound traffic"
  vpc_id      = "${aws_vpc.met-vpc.id}"

  tags {
    Name              = "met-sg-linux-default-${var.met_instance_name}"
    MET_instance_name = "${var.met_instance_name}"
    MET_user_name     = "${var.met_user_name}"
    MET_company_name  = "${var.met_company_name}"
  }
}

resource "aws_security_group" "met-sg-windows-default" {
  name        = "MET_sg_windows_default"
  description = "Allow inbound rdp andall outbound traffic"
  vpc_id      = "${aws_vpc.met-vpc.id}"

  tags {
    Name              = "met-sg-windows-default-${var.met_instance_name}"
    MET_instance_name = "${var.met_instance_name}"
    MET_user_name     = "${var.met_user_name}"
    MET_company_name  = "${var.met_company_name}"
  }
}

resource "aws_security_group" "met-sg-inbound-pe-master" {
  name        = "MET_master"
  description = "Allow inbound traffic to Puppet Enterprise master required ports"
  vpc_id      = "${aws_vpc.met-vpc.id}"

  tags {
    Name              = "met-sg-inbound-pe-master-${var.met_instance_name}"
    MET_instance_name = "${var.met_instance_name}"
    MET_user_name     = "${var.met_user_name}"
    MET_company_name  = "${var.met_company_name}"
  }
}

resource "aws_security_group_rule" "met-allow-outbound-all-windows" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.met-sg-windows-default.id}"
}

resource "aws_security_group_rule" "met-allow-inbound-rdp" {
  type              = "ingress"
  from_port         = 3389
  to_port           = 3389
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.met-sg-windows-default.id}"
}

resource "aws_security_group_rule" "met-allow-outbound-all-linux" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.met-sg-linux-default.id}"
}

resource "aws_security_group_rule" "met-allow-inbound-ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.met-sg-linux-default.id}"
}

resource "aws_security_group_rule" "met-allow-inbound-https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.met-sg-inbound-pe-master.id}"
}

resource "aws_security_group_rule" "met-allow-inbound-puppet-server" {
  type              = "ingress"
  from_port         = 8140
  to_port           = 8140
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.met-sg-inbound-pe-master.id}"
}

resource "aws_security_group_rule" "met-allow-inbound-puppet-orchestrator" {
  type              = "ingress"
  from_port         = 8142
  to_port           = 8142
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.met-sg-inbound-pe-master.id}"
}
