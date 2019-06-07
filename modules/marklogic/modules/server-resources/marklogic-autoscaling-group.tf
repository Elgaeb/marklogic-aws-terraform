
// <editor-fold desc="Instance Autoscaling Groups">

data "template_file" "user_data" {
  count    = var.enable ? 1 : 0
  template = file("modules/marklogic/modules/server-resources/files/marklogic_userdata.sh")

  vars = {
    node                     = format("Node%d_#", var.group_number + 1)
    master                   = tonumber(var.group_number) == 0 ? 1 : 0
    licensee                 = var.licensee
    licensee_key             = var.licensee_key
    cluster_name             = var.cluster_name
    marklogic_version        = var.marklogic_version
    marklogic_admin_password = var.marklogic_admin_password

    volume_count             = var.volume_count
    marklogic_ebs_volume     = module.volume_0.marklogic_ebs_volume
    marklogic_ebs_volume_1   = module.volume_1.marklogic_ebs_volume
    marklogic_ebs_volume_2   = module.volume_2.marklogic_ebs_volume
    marklogic_ebs_volume_3   = module.volume_3.marklogic_ebs_volume
    marklogic_ebs_volume_4   = module.volume_4.marklogic_ebs_volume
    marklogic_ebs_volume_5   = module.volume_5.marklogic_ebs_volume
    marklogic_ebs_volume_6   = module.volume_6.marklogic_ebs_volume
    marklogic_ebs_volume_7   = module.volume_7.marklogic_ebs_volume
    marklogic_ebs_volume_8   = module.volume_8.marklogic_ebs_volume
    marklogic_ebs_volume_9   = module.volume_9.marklogic_ebs_volume
  }
}

resource "aws_launch_configuration" "launch_configuration" {
  count = var.enable ? 1 : 0

  key_name  = var.key_name
  image_id  = lookup(var.amis, "v${var.marklogic_version}.${var.aws_region}.${var.licensee_key == "" && var.licensee == "" ? "enterprise" : "byol"}")
  user_data = data.template_file.user_data[0].rendered

  security_groups = [
    var.instance_security_group_id
  ]

  instance_type        = var.instance_type
  iam_instance_profile = var.instance_host_profile_name

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "marklogic_server_group" {
  count = var.enable ? 1 : 0

  name = "${var.cluster_name}-marklogic_server_group_${var.group_number}"

  vpc_zone_identifier = [
    var.subnet_id
  ]

  min_size                  = 0
  max_size                  = var.node_count
  desired_capacity          = var.node_count
  default_cooldown          = 300
  health_check_type         = "EC2"
  health_check_grace_period = 300

  load_balancers = var.load_balancer_names

  launch_configuration = aws_launch_configuration.launch_configuration[0].name

  initial_lifecycle_hook {
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
    name = "NodeManager"
    heartbeat_timeout = 4800
    notification_target_arn = var.node_manager_sns_topic_arn
    role_arn = var.node_manager_exec_role_arn
  }

  tag {
    key                 = "marklogic:stack:name"
    value               = "${var.cluster_name}-${var.group_number}"
    propagate_at_launch = true
  }

  tag {
    key                 = "marklogic:stack:id"
    value               = "${var.cluster_id}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "${var.cluster_name}-${var.group_number}_Node${var.group_number + 1}"
    propagate_at_launch = true
  }
}


resource "aws_autoscaling_notification" "marklogic_server_group_notification" {
  count = var.enable ? 1 : 0

  group_names = "${aws_autoscaling_group.marklogic_server_group.*.name}"

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = var.node_manager_sns_topic_arn
}

// </editor-fold>
