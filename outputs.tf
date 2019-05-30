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
