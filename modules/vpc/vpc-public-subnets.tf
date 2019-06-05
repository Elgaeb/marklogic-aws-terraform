resource "aws_subnet" "public_subnet" {
  count  = var.number_of_zones
  vpc_id = aws_vpc.marklogic_vpc.id

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
  vpc_id = aws_vpc.marklogic_vpc.id

  tags = {
    Name = "Public Subnet Route Table"
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_route_table_association" "public_route_association" {
  count          = var.number_of_zones
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_subnet_route_table.id
}

resource "aws_route" "route_public" {
  route_table_id         = aws_route_table.public_subnet_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc_gateway.id
}

resource "aws_eip" "nat_eip" {
  vpc = true

  tags = {
    Name = "NAT Gateway EIP"
    Terraform = true
    VPC = var.vpc_name
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "Public Subnet NAT Gateway"
    Terraform = true
    VPC = var.vpc_name
  }
}
