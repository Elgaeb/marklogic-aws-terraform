output "public_ip_address" {
  value = "${aws_instance.ec2_instance.0.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.ec2_instance.0.public_dns}"
}

output "private_ip_address" {
  value = "${aws_instance.ec2_instance.0.private_ip}"
}

output "private_dns" {
  value = "${aws_instance.ec2_instance.0.private_dns}"
}
