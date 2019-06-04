resource "aws_dynamodb_table" "marklogic_ddb_table" {
  count = "${var.enable_marklogic ? 1 : 0}"

  name = "${var.cluster_name}"

  attribute {
    name = "node"
    type = "S"
  }

  hash_key       = "node"
  read_capacity  = 10
  write_capacity = 10
}

// <editor-fold desc="Instance Autoscaling Groups">

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

