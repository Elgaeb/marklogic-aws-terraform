resource "aws_subnet" "private_subnet" {
  count  = var.number_of_zones
  vpc_id = aws_vpc.marklogic_vpc.id

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
  vpc_id = aws_vpc.marklogic_vpc.id

  tags = {
    Name = "Private Subnet Route Table"
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_route_table_association" "private_route_association" {
  count          = var.number_of_zones
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_subnet_route_table.id
}

resource "aws_route" "route_private" {
  route_table_id         = aws_route_table.private_subnet_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}
