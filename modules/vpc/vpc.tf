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
