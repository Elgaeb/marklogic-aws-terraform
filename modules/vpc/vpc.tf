locals {
  enable = var.enable ? 1 : 0
}

resource "aws_vpc" "marklogic_vpc" {
  count = local.enable

  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_internet_gateway" "vpc_gateway" {
  count = local.enable

  vpc_id = aws_vpc.marklogic_vpc[0].id

  tags = {
    Terraform = true
    VPC = var.vpc_name
  }
}
