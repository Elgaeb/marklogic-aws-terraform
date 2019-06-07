output "url" {
  value = "http://${aws_elb.external_elb.dns_name}:8001"
}

output "internal_url" {
  value = "http://${aws_elb.internal_elb.dns_name}:8001"
}



output "managed_eni_private_ips" {
  value = flatten([
    module.server_group_0.eni_private_ips
  ])
}

output "managed_eni_private_dns" {
  value = flatten([
    module.server_group_0.eni_private_dns
  ])
}

output "instance_security_group_id" {
  value = aws_security_group.instance_security_group.id
}
