// <editor-fold desc="Instance Security Group">

resource "aws_security_group" "instance_security_group" {

  description = "Enable SSH access and HTTP access on the inbound port"
  name        = "${var.cluster_name}-instance_security_group"
  vpc_id      = "${var.vpc_id}"

  tags = {
    Name = "Instance Security Group"
  }
}

// <editor-fold desc="Security Group Rules">

resource "aws_security_group_rule" "instance_security_group_ssh_ingress_rule" {
  type      = "ingress"
  protocol  = "tcp"
  from_port = 22
  to_port   = 22

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = "${aws_security_group.instance_security_group.id}"
}

resource "aws_security_group_rule" "instance_security_group_ml_system_ingress_rule" {
  type      = "ingress"
  protocol  = "tcp"
  from_port = 7997
  to_port   = 7998

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = "${aws_security_group.instance_security_group.id}"
}

resource "aws_security_group_rule" "instance_security_group_ml_administration_ingress_rule" {
  type      = "ingress"
  protocol  = "tcp"
  from_port = 8000
  to_port   = 8002

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = "${aws_security_group.instance_security_group.id}"
}

resource "aws_security_group_rule" "instance_security_group_ops_director_ingress_rule" {
  count = "${var.enable_ops_director ? 1 : 0}"

  type      = "ingress"
  protocol  = "tcp"
  from_port = 8008
  to_port   = 8009

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = "${aws_security_group.instance_security_group.id}"
}

resource "aws_security_group_rule" "instance_security_group_data_explorer_ingress_rule" {
  count = "${var.enable_data_explorer ? 1 : 0}"

  type      = "ingress"
  protocol  = "tcp"
  from_port = 7777
  to_port   = 7777

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = "${aws_security_group.instance_security_group.id}"
}

resource "aws_security_group_rule" "instance_security_group_grove_ingress_rule" {
  count = "${var.enable_grove ? 1 : 0}"

  type      = "ingress"
  protocol  = "tcp"
  from_port = 7778
  to_port   = 7778

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = "${aws_security_group.instance_security_group.id}"
}

resource "aws_security_group_rule" "instance_security_group_data_hub_ingress_rule" {
  count = "${var.enable_data_hub ? 1 : 0}"

  type      = "ingress"
  protocol  = "tcp"
  from_port = 8010
  to_port   = 8013

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = "${aws_security_group.instance_security_group.id}"
}

resource "aws_security_group_rule" "instance_security_group_https_egress_rule" {
  type      = "egress"
  protocol  = "tcp"
  from_port = 443
  to_port   = 443

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = "${aws_security_group.instance_security_group.id}"
}

resource "aws_security_group_rule" "instance_security_group_http_egress_rule" {
  type      = "egress"
  protocol  = "tcp"
  from_port = 80
  to_port   = 80

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = "${aws_security_group.instance_security_group.id}"
}

resource "aws_security_group_rule" "instance_security_group_internal_ingress_rule" {
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 0
  to_port                  = 65535
  source_security_group_id = "${aws_security_group.instance_security_group.id}"
  security_group_id        = "${aws_security_group.instance_security_group.id}"
}

resource "aws_security_group_rule" "instance_security_group_internal_egress_rule" {
  type      = "egress"
  protocol  = "tcp"
  from_port = 0
  to_port   = 65535

  cidr_blocks = [
    "${var.vpc_cidr}",
  ]

  security_group_id = "${aws_security_group.instance_security_group.id}"
}

// </editor-fold>

// </editor-fold>
