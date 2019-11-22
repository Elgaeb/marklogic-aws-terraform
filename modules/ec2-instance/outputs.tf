output "public_ip_address" {
  value = var.enable ? element(aws_instance.ec2_instance, 0).public_ip : ""
}

output "public_dns" {
  value = var.enable ? element(aws_instance.ec2_instance, 0).public_dns : ""
}

output "private_ip_address" {
  value = var.enable ? element(aws_instance.ec2_instance, 0).private_ip : ""
}

output "private_dns" {
  value = var.enable ? element(aws_instance.ec2_instance, 0).private_dns : ""
}
