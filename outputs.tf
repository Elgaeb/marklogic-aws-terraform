output "ingestion" {
  value = "${module.ingestion.*}"
}

output "vpc" {
  value = "${module.vpc.*}"
}

output "bastion" {
  value = "${module.bastion.*}"
}

output "marklogic" {
  value = "${module.marklogic.*}"
}

output "vpc_id" {
  value = local.vpc_id
}

output "vpc_cidr" {
  value = local.vpc_cidr
}

output "public_subnet_ids" {
  value = local.public_subnet_ids
}

output "private_subnet_ids" {
  value = local.private_subnet_ids
}