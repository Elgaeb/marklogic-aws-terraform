output "nat_ip" {
  value = var.enable ? element(aws_eip.nat_eip, 0).public_ip : ""
}

output "vpc_id" {
  value = var.enable ? element(aws_vpc.marklogic_vpc, 0).id : ""
}

output "vpc_cidr_block" {
  value = var.enable ? element(aws_vpc.marklogic_vpc, 0).cidr_block : ""
}
output "public_subnet_cidrs" {
  value = [ for subnet in aws_subnet.public_subnet: subnet.cidr_block ]
}

output "public_subnet_ids" {
  value = [ for subnet in aws_subnet.public_subnet: subnet.id ]
}

output "private_subnet_cidrs" {
  value = [ for subnet in aws_subnet.private_subnet: subnet.cidr_block ]
}

output "private_subnet_ids" {
  value = [ for subnet in aws_subnet.private_subnet: subnet.id ]
}

output "default_security_group_id" {
  value = var.enable ? element(aws_vpc.marklogic_vpc, 0).default_security_group_id : ""
}