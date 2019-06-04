resource "aws_vpc" "marklogic_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_internet_gateway" "vpc_gateway" {
  vpc_id = aws_vpc.marklogic_vpc.id

  tags = {
    Terraform = true
    VPC = var.vpc_name
  }
}

// <editor-fold desc="Public Subnets">
resource "aws_subnet" "public_subnet" {
  count  = var.number_of_zones
  vpc_id = aws_vpc.marklogic_vpc.id

  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${var.vpc_name}-public_subnet_${count.index}"
    Tier = "Public"
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = aws_vpc.marklogic_vpc.id
  
  tags = {
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_route_table_association" "public_route_association" {
  count          = var.number_of_zones
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_subnet_route_table.id

  tags = {
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_route" "route_public" {
  route_table_id         = aws_route_table.public_subnet_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc_gateway.id

  tags = {
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_eip" "nat_eip" {
  vpc = true

  tags = {
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Terraform = true
    VPC = var.vpc_name
  }
}

// </editor-fold>

// <editor-fold desc="Private Subnets">

resource "aws_subnet" "private_subnet" {
  count  = var.number_of_zones
  vpc_id = aws_vpc.marklogic_vpc.id

  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${var.vpc_name}-private_subnet_${count.index}"
    Tier = "Private"
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_route_table" "private_subnet_route_table" {
  vpc_id = aws_vpc.marklogic_vpc.id

  tags = {
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_route_table_association" "private_route_association" {
  count          = var.number_of_zones
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_subnet_route_table.id

  tags = {
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_route" "route_private" {
  route_table_id         = aws_route_table.private_subnet_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id

  tags = {
    Terraform = true
    VPC = var.vpc_name
  }
}

// </editor-fold>

// <editor-fold desc="Endpoints">
resource "aws_security_group" "endpoint_security_group" {
  description = "Enable SSH access and HTTP access on the inbound port"
  vpc_id      = aws_vpc.marklogic_vpc.id

  tags = {
    Name = "Endpoint Security Group"
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_security_group_rule" "endpoint_security_group_local_ingress" {
  type                     = "ingress"
  security_group_id        = aws_security_group.endpoint_security_group.id
  source_security_group_id = aws_security_group.endpoint_security_group.id
  protocol                 = "tcp"
  from_port                = 0
  to_port                  = 65355

  tags = {
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_security_group_rule" "endpoint_security_group_https_ingress" {
  security_group_id = aws_security_group.endpoint_security_group.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  tags = {
    Terraform = true
    VPC = var.vpc_name
  }
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
  route_table_ids = [ aws_route_table.private_subnet_route_table.id ]
  service_name    = "com.amazonaws.${var.aws_region}.dynamodb"
  vpc_id          = aws_vpc.marklogic_vpc.id

  policy = data.aws_iam_policy_document.endpoint_policy.json

  tags = {
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_vpc_endpoint" "s3_endpoint" {
  route_table_ids = [ aws_route_table.private_subnet_route_table.id ]
  service_name    = "com.amazonaws.${var.aws_region}.s3"
  vpc_id          = aws_vpc.marklogic_vpc.id

  policy = data.aws_iam_policy_document.endpoint_policy.json

  tags = {
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_vpc_endpoint" "ec2_endpoint" {
  service_name        = "com.amazonaws.${var.aws_region}.ec2"
  vpc_id              = aws_vpc.marklogic_vpc.id
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [
    for subnet in aws_subnet.private_subnet:
    subnet.id
  ]
  security_group_ids  = [ aws_security_group.endpoint_security_group.id ]

  tags = {
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_vpc_endpoint" "elb_endpoint" {
  service_name        = "com.amazonaws.${var.aws_region}.elasticloadbalancing"
  vpc_id              = aws_vpc.marklogic_vpc.id
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [
    for subnet in aws_subnet.private_subnet:
    subnet.id
  ]
  security_group_ids  = [ aws_security_group.endpoint_security_group.id ]

  tags = {
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_vpc_endpoint" "kms_endpoint" {
  service_name        = "com.amazonaws.${var.aws_region}.kms"
  vpc_id              = aws_vpc.marklogic_vpc.id
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [
    for subnet in aws_subnet.private_subnet:
    subnet.id
  ]
  security_group_ids  = [ aws_security_group.endpoint_security_group.id ]

  tags = {
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_vpc_endpoint" "sns_endpoint" {
  service_name        = "com.amazonaws.${var.aws_region}.sns"
  vpc_id              = aws_vpc.marklogic_vpc.id
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [
    for subnet in aws_subnet.private_subnet:
    subnet.id
  ]
  security_group_ids  = [ aws_security_group.endpoint_security_group.id ]

  tags = {
    Terraform = true
    VPC = var.vpc_name
  }
}

// </editor-fold>
