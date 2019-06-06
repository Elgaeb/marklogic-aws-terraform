resource "aws_subnet" "private_subnet" {
  count  = local.enable * var.number_of_zones
  vpc_id = aws_vpc.marklogic_vpc[0].id

  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "Private Subnet ${count.index}"
    Tier = "Private"
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_route_table" "private_subnet_route_table" {
  count  = local.enable

  vpc_id = aws_vpc.marklogic_vpc[0].id

  tags = {
    Name = "Private Subnet Route Table"
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_route_table_association" "private_route_association" {
  count          = local.enable * var.number_of_zones
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_subnet_route_table[0].id
}

resource "aws_route" "route_private" {
  count                  = local.enable
  route_table_id         = aws_route_table.private_subnet_route_table[0].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway[0].id
}
