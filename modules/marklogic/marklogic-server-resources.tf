

module "server_group_0" {
  source = "./modules/server-resources"

  enable = true
  group_number = 0

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


// <editor-fold desc="Instance Autoscaling Groups">

/*
data "template_file" "user_data" {
  count    = "${(var.enable_marklogic ? 1 : 0) * var.number_of_zones}"
  template = "${file("modules/marklogic/files/marklogic_userdata.sh")}"

  vars = {
    node                   = "Node${count.index + 1}_#"
    master                 = "${count.index == 0 ? 1 : 0}"
    licensee               = "${var.licensee}"
    licensee_key           = "${var.licensee_key}"
    cluster_name           = "${var.cluster_name}"
    volume_count           = "${var.volume_count}"
    volume_size            = "${var.volume_size}"
    volume_type            = "${var.volume_type}"
    volume_iops            = "${var.volume_iops}"
    volume_encrypted       = "${var.volume_encrypted}"
    marklogic_version      = "${var.marklogic_version}"
  }
}

resource "aws_launch_configuration" "launch_configuration" {
  count = "${(var.enable_marklogic ? 1 : 0) * var.number_of_zones}"

  //  name      = "${var.cluster_name}-launch_node_${count.index}"
  key_name  = "${var.key_name}"
  image_id  = "${lookup(var.amis, "v${var.marklogic_version}.${var.aws_region}.${var.licensee_key == "" && var.licensee == "" ? "enterprise" : "byol"}")}"
  user_data = "${element(data.template_file.user_data.*.rendered, count.index)}"

  security_groups = [
    "${aws_security_group.instance_security_group.id}",
  ]

  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.instance_host_profile.name}"

  ebs_block_device {
    device_name = "/dev/sdf"
    no_device   = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "marklogic_server_group" {
  count = "${(var.enable_marklogic ? 1 : 0) * var.number_of_zones}"

  depends_on = [
    "aws_dynamodb_table.marklogic_ddb_table",
    "aws_lambda_function.node_manager_function",
    "aws_lambda_permission.node_manager_invoke_permission",
  ]

  name = "${var.cluster_name}-marklogic_server_group_${count.index}"

  vpc_zone_identifier = [
    element(var.private_subnet_ids, count.index % length(var.private_subnet_ids))
  ]

  min_size                  = 0
  max_size                  = "${element(local.node_counts, count.index % length(local.node_counts))}"
  desired_capacity          = "${element(local.node_counts, count.index % length(local.node_counts))}"
  default_cooldown          = 300
  health_check_type         = "EC2"
  health_check_grace_period = 300

  load_balancers = [
    aws_elb.external_elb.name,
    aws_elb.internal_elb.name,
  ]

  launch_configuration = "${element(aws_launch_configuration.launch_configuration.*.name, count.index)}"

  initial_lifecycle_hook {
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
    name = "NodeManager"
    heartbeat_timeout = 4800
    notification_target_arn = "${aws_sns_topic.node_manager_sns_topic.0.arn}"
    role_arn = "${aws_iam_role.node_manager_exec_role.0.arn}"
  }

  tag {
    key                 = "marklogic:stack:name"
    value               = "${var.cluster_name}-${count.index}"
    propagate_at_launch = true
  }

  tag {
    key                 = "marklogic:stack:id"
    value               = "${var.cluster_id}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "${var.cluster_name}-${count.index}_Node${count.index + 1}"
    propagate_at_launch = true
  }
}


resource "aws_autoscaling_notification" "marklogic_server_group_notification" {
  count = "${var.enable_marklogic ? 1 : 0}"

  group_names = "${aws_autoscaling_group.marklogic_server_group.*.name}"

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = "${aws_sns_topic.node_manager_sns_topic.0.arn}"
}

// </editor-fold>

*/