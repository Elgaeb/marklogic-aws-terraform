resource "aws_security_group" "endpoint_security_group" {
  count = local.enable

  description = "Security group for VPC endpoints"
  vpc_id      = aws_vpc.marklogic_vpc[0].id

  tags = {
    Name = "VPC Endpopints Security Group"
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_security_group_rule" "endpoint_security_group_local_ingress" {
  count = local.enable

  type                     = "ingress"
  security_group_id        = aws_security_group.endpoint_security_group[0].id
  source_security_group_id = aws_security_group.endpoint_security_group[0].id
  protocol                 = "tcp"
  from_port                = 0
  to_port                  = 65355
}

resource "aws_security_group_rule" "endpoint_security_group_https_ingress" {
  count = local.enable

  security_group_id = aws_security_group.endpoint_security_group[0].id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

data "aws_iam_policy_document" "endpoint_policy" {
  statement {
    actions   = ["*"]
    resources = ["*"]

    principals {
      identifiers = ["*"]
      type        = "*"
    }

    effect = "Allow"
  }
}

resource "aws_vpc_endpoint" "ddb_endpoint" {
  count = local.enable

  route_table_ids = [ aws_route_table.private_subnet_route_table[0].id ]
  service_name    = "com.amazonaws.${var.aws_region}.dynamodb"
  vpc_id          = aws_vpc.marklogic_vpc[0].id

  policy = data.aws_iam_policy_document.endpoint_policy.json
}

resource "aws_vpc_endpoint" "s3_endpoint" {
  count = local.enable

  route_table_ids = [ aws_route_table.private_subnet_route_table[0].id ]
  service_name    = "com.amazonaws.${var.aws_region}.s3"
  vpc_id          = aws_vpc.marklogic_vpc[0].id

  policy = data.aws_iam_policy_document.endpoint_policy.json
}

resource "aws_vpc_endpoint" "ec2_endpoint" {
  count = local.enable

  service_name        = "com.amazonaws.${var.aws_region}.ec2"
  vpc_id              = aws_vpc.marklogic_vpc[0].id
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [ for subnet in aws_subnet.private_subnet: subnet.id ]
  security_group_ids  = [ for sg in aws_security_group.endpoint_security_group: sg.id ]
}

resource "aws_vpc_endpoint" "elb_endpoint" {
  count = local.enable

  service_name        = "com.amazonaws.${var.aws_region}.elasticloadbalancing"
  vpc_id              = aws_vpc.marklogic_vpc[0].id
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [ for subnet in aws_subnet.private_subnet: subnet.id ]
  security_group_ids  = [ for sg in aws_security_group.endpoint_security_group: sg.id ]
}

resource "aws_vpc_endpoint" "kms_endpoint" {
  count = local.enable

  service_name        = "com.amazonaws.${var.aws_region}.kms"
  vpc_id              = aws_vpc.marklogic_vpc[0].id
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [ for subnet in aws_subnet.private_subnet: subnet.id ]
  security_group_ids  = [ for sg in aws_security_group.endpoint_security_group: sg.id ]
}

resource "aws_vpc_endpoint" "sns_endpoint" {
  count = local.enable

  service_name        = "com.amazonaws.${var.aws_region}.sns"
  vpc_id              = aws_vpc.marklogic_vpc[0].id
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [ for subnet in aws_subnet.private_subnet: subnet.id ]
  security_group_ids  = [ for sg in aws_security_group.endpoint_security_group: sg.id ]
}
