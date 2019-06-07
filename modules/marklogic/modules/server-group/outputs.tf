
output "eni_private_dns" {
  value = var.enable ? [ for eni in aws_network_interface.managed_eni: eni.private_dns_name ] : null
}

output "eni_private_ips" {
  value = var.enable ? [ for eni in aws_network_interface.managed_eni: eni.private_ip ] : null
}