output "vpc_id" {
  value = "${var.vpc_id}"
}

output "vpc_cidr_block" {
  value = "${var.vpc_cidr}"
}

output "public_subnet_ids" {
  value = "${var.public_subnet_ids}"
}

output "private_subnet_ids" {
  value = "${var.private_subnet_ids}"
}
