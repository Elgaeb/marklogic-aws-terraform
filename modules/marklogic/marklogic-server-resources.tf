

module "server_group_0" {
  source = "./modules/server-resources"

  enable = true
  group_number = 0

  marklogic_admin_password = var.marklogic_admin_password

  availability_zone = var.availability_zones[0 % length(var.availability_zones)]
  subnet_id = var.private_subnet_ids[0 % length(var.private_subnet_ids)]

  node_count = lookup(var.server_groups[0], "node_count", 1)
  volume_size = lookup(var.server_groups[0], "volume_size", 10)
  volume_type = lookup(var.server_groups[0], "volume_type", "gp2")
  volume_iops = lookup(var.server_groups[0], "volume_iops", 100)
  volume_encrypted = lookup(var.server_groups[0], "volume_encrypted", false)
  volume_count = lookup(var.server_groups[0], "volume_count", 1)
  instance_type = lookup(var.server_groups[0], "instance_type", "t3.small")

  instance_security_group_id = aws_security_group.instance_security_group.id
  instance_host_profile_name = aws_iam_instance_profile.instance_host_profile.name
  aws_region = var.aws_region

  cluster_name = var.cluster_name
  cluster_id = var.cluster_id

  licensee = var.licensee
  licensee_key = var.licensee_key
  marklogic_version = var.marklogic_version

  key_name = var.key_name
  load_balancer_names = [ aws_elb.external_elb.name, aws_elb.internal_elb.name ]

  node_manager_exec_role_arn = aws_iam_role.node_manager_exec_role[0].arn
  node_manager_sns_topic_arn = aws_sns_topic.node_manager_sns_topic[0].arn

  create_after = [
    aws_lambda_function.node_manager_function.*.arn,
    aws_lambda_permission.node_manager_invoke_permission.*.id,
  ]
}
