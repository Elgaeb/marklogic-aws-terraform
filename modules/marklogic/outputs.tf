output "url" {
  value = "http://${aws_elb.external_elb.dns_name}:8001"
}

output "internal_url" {
  value = "http://${aws_elb.internal_elb.dns_name}:8001"
}

output "managed_eni_private_ips" {
  value = flatten([
    [ for eni in aws_network_interface.managed_eni_group_1: eni.private_ip ],
    [ for eni in aws_network_interface.managed_eni_group_2: eni.private_ip ],
    [ for eni in aws_network_interface.managed_eni_group_3: eni.private_ip ],
    [ for eni in aws_network_interface.managed_eni_group_4: eni.private_ip ],
    [ for eni in aws_network_interface.managed_eni_group_5: eni.private_ip ],
    [ for eni in aws_network_interface.managed_eni_group_6: eni.private_ip ]
  ])
}

output "managed_eni_private_dns" {
  value = flatten([
    [ for eni in aws_network_interface.managed_eni_group_1: eni.private_dns_name ],
    [ for eni in aws_network_interface.managed_eni_group_2: eni.private_dns_name ],
    [ for eni in aws_network_interface.managed_eni_group_3: eni.private_dns_name ],
    [ for eni in aws_network_interface.managed_eni_group_4: eni.private_dns_name ],
    [ for eni in aws_network_interface.managed_eni_group_5: eni.private_dns_name ],
    [ for eni in aws_network_interface.managed_eni_group_6: eni.private_dns_name ]
  ])
}

output "instance_security_group_id" {
  value = aws_security_group.instance_security_group.id
}
