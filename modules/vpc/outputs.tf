output "nat_ip" {
  value = aws_eip.nat_eip.public_ip
}

output "vpc_id" {
  value = aws_vpc.marklogic_vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.marklogic_vpc.cidr_block
}

output "public_subnets" {
  value = {
    for subnet in aws_subnet.public_subnet:
    subnet.id => [ subnet.cidr_block, subnet.availability_zone ]
  }
}

output "private_subnets" {
  value = {
    for subnet in aws_subnet.private_subnet:
    subnet.id => [ subnet.cidr_block, subnet.availability_zone ]
  }
}

output "default_security_group_id" {
  value = aws_vpc.marklogic_vpc.default_security_group_id
}