output "marklogic_administration_url" {
  value = [ for elb in aws_elb.external_elb: format("http://%s:8001", elb.dns_name) ]
}

output "marklogic_administration_internal_url" {
  value = "http://${aws_elb.internal_elb.dns_name}:8001"
}

output "managed_eni_private_ips" {
  value = [ for value in [
    module.server_group_0.eni_private_ips,
    module.server_group_1.eni_private_ips,
    module.server_group_2.eni_private_ips,
    module.server_group_3.eni_private_ips,
    module.server_group_4.eni_private_ips,
    module.server_group_5.eni_private_ips,
  ]: value if length(value) > 0 ]
}

output "managed_eni_private_dns" {
  value = [ for value in [
    module.server_group_0.eni_private_dns,
    module.server_group_1.eni_private_dns,
    module.server_group_2.eni_private_dns,
    module.server_group_3.eni_private_dns,
    module.server_group_4.eni_private_dns,
    module.server_group_5.eni_private_dns,
  ]: value if length(value) > 0 ]
}

output "instance_security_group_id" {
  value = aws_security_group.instance_security_group.id
}
