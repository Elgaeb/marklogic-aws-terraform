resource "aws_subnet" "public_subnet" {
  count  = local.enable * var.number_of_zones
  vpc_id = aws_vpc.marklogic_vpc[0].id

  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "Public Subnet ${count.index}"
    Tier = "Public"
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_route_table" "public_subnet_route_table" {
  count = local.enable
  vpc_id = aws_vpc.marklogic_vpc[0].id

  tags = {
    Name = "Public Subnet Route Table"
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_route_table_association" "public_route_association" {
  count          = local.enable * var.number_of_zones
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_subnet_route_table[0].id
}

resource "aws_route" "route_public" {
  count = local.enable
  route_table_id         = aws_route_table.public_subnet_route_table[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc_gateway[0].id
}

resource "aws_eip" "nat_eip" {
  count = local.enable
  vpc = true

  tags = {
    Name = "NAT Gateway EIP"
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  count = local.enable
  allocation_id = aws_eip.nat_eip[0].id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "Public Subnet NAT Gateway"
    Terraform = true
    VPC = var.vpc_name
  }
}
