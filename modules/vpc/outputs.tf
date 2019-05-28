output "nat_ip" {
  value = "${aws_eip.nat_eip.public_ip}"
}

output "vpc_id" {
  value = "${aws_vpc.marklogic_vpc.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.marklogic_vpc.cidr_block}"
}

output "public_subnet_ids" {
  value = "${aws_subnet.public_subnet.*.id}"
}

output "private_subnet_ids" {
  value = "${aws_subnet.private_subnet.*.id}"
}

output "default_security_group_id" {
  value = "${aws_vpc.marklogic_vpc.default_security_group_id}"
}