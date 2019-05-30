output "url" {
  value = "http://${aws_elb.elastic_load_balancer.dns_name}:8001"
}

output "internal_url" {
  value = "http://${aws_elb.internal_elastic_load_balancer.dns_name}:8001"
}

output "managed_eni_private_ips" {
  value = "${aws_network_interface.managed_eni.*.private_ip}"
}

output "managed_eni_private_dns" {
  value = "${aws_network_interface.managed_eni.*.private_dns_name}"
}

output "node_manager_iam_arn" {
  value = "${aws_iam_role.node_manager_exec_role.*.arn}"
}

output "node_manager_sns_arn" {
  value = "${aws_sns_topic.node_manager_sns_topic.*.arn}"
}

output "instance_security_group_id" {
  value = "${aws_security_group.instance_security_group.id}"
}
