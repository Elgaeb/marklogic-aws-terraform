module "server_group_2" {
  source = "./modules/server-group"

  group_number = 2
  enable = var.server_group_2_node_count > 0

  availability_zone = var.availability_zones[var.server_group_2_subnet_index % length(var.availability_zones)]
  subnet_id = var.private_subnet_ids[var.server_group_2_subnet_index % length(var.private_subnet_ids)]

  node_count = var.server_group_2_node_count
  volume_size = var.server_group_2_volume_size
  volume_type = var.server_group_2_volume_type
  volume_iops = var.server_group_2_volume_iops
  volume_encrypted = var.server_group_2_volume_encrypted
  volume_count = var.server_group_2_volume_count
  instance_type = var.server_group_2_instance_type

  // <editor-fold desc="Do not modify these values">
  marklogic_admin_password = var.marklogic_admin_password

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
  // </editor-fold>
}

