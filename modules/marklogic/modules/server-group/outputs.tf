
output "eni_private_dns" {
  value = [ for eni in aws_network_interface.managed_eni: eni.private_dns_name ]
}

output "eni_private_ips" {
  value = [ for eni in aws_network_interface.managed_eni: eni.private_ip ]
}