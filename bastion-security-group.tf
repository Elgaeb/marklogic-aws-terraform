resource "aws_security_group" "bastion_security_group" {
  count = var.bastion_enable ? 1 : 0

  description = "Security Group for the Bastion instance"
  vpc_id      = local.vpc_id

  tags = {
    Name = "Bastion"
    Terraform = true
  }
}

resource "aws_security_group_rule" "bastion_security_group_ssh_ingress" {
  count = var.bastion_enable ? 1 : 0

  security_group_id = aws_security_group.bastion_security_group[0].id
  type      = "ingress"
  protocol  = "tcp"
  from_port = 22
  to_port   = 22

  cidr_blocks = var.bastion_remote_access_cidr_blocks
}

resource "aws_security_group_rule" "bastion_security_group_icmp_ingress" {
  count = var.bastion_enable ? 1 : 0

  security_group_id = aws_security_group.bastion_security_group[0].id
  type      = "ingress"
  protocol  = "icmp"
  from_port = -1
  to_port   = -1

  cidr_blocks = var.bastion_remote_access_cidr_blocks
}

resource "aws_security_group_rule" "bastion_security_group_egress" {
  count = var.bastion_enable ? 1 : 0

  security_group_id = aws_security_group.bastion_security_group[0].id
  type      = "egress"
  protocol  = "tcp"
  from_port = 0
  to_port   = 65535

  cidr_blocks = var.bastion_egress_cidr_blocks
}