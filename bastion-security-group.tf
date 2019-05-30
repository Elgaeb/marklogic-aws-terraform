
resource "aws_security_group" "bastion_security_group" {
  description = "Enable SSH access on the inbound port"
  vpc_id      = "${module.vpc.vpc_id}"
}

resource "aws_security_group_rule" "bastion_security_group_ssh_ingress" {
  security_group_id = "${aws_security_group.bastion_security_group.id}"
  type      = "ingress"
  protocol  = "tcp"
  from_port = 22
  to_port   = 22

  cidr_blocks = "${var.bastion_remote_access_cidr_blocks}"
}

resource "aws_security_group_rule" "bastion_security_group_icmp_ingress" {
  security_group_id = "${aws_security_group.bastion_security_group.id}"
  type      = "ingress"
  protocol  = "icmp"
  from_port = -1
  to_port   = -1

  cidr_blocks = "${var.bastion_remote_access_cidr_blocks}"
}

resource "aws_security_group_rule" "bastion_security_group_egress" {
  security_group_id = "${aws_security_group.bastion_security_group.id}"
  type      = "egress"
  protocol  = "tcp"
  from_port = 0
  to_port   = 65535

  cidr_blocks = "${var.bastion_egress_cidr_blocks}"
}