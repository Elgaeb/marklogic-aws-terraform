data "aws_caller_identity" "current" {}

resource "aws_cloudwatch_log_group" "bastion_main_log_group" {
  name = "${var.vpc_name}-bastion_main_log_group"
}

resource "aws_cloudwatch_log_metric_filter" "ssh_metric_filter" {
  log_group_name = "${aws_cloudwatch_log_group.bastion_main_log_group.name}"

  metric_transformation {
    name      = "SSHCommandCount"
    namespace = "${var.vpc_name}"
    value     = "1"
  }

  name    = "SSH Access Count"
  pattern = "ON FROM USER PWD"
}

data "aws_iam_policy_document" "bastion_host_role_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = [
        "ec2.amazonaws.com",
      ]

      type = "Service"
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "bastion_policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:GetLogEvents",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutRetentionPolicy",
      "logs:PutMetricFilter",
      "logs:CreateLogGroup",
    ]

    resources = [
      "arn:${var.aws_region == "us-gov-west-1" ? "aws-us-gov" : "aws"}:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:${aws_cloudwatch_log_group.bastion_main_log_group.id}:*",
    ]

    effect = "Allow"
  }
}

resource "aws_iam_policy" "bastion_host_policy" {
  name   = "${var.vpc_name}-bastion_host_policy"
  policy = "${data.aws_iam_policy_document.bastion_policy.json}"
}

resource "aws_iam_role" "bastion_host_role" {
  assume_role_policy = "${data.aws_iam_policy_document.bastion_host_role_assume_role_policy.json}"
}

resource "aws_iam_role_policy_attachment" "bastion_host_policy_attachment" {
  role       = "${aws_iam_role.bastion_host_role.name}"
  policy_arn = "${aws_iam_policy.bastion_host_policy.arn}"
}

resource "aws_iam_instance_profile" "bastion_host_profile" {
  role = "${aws_iam_role.bastion_host_role.name}"
  path = "/"
}

resource "aws_security_group" "bastion_security_group" {
  description = "Enable SSH access on the inbound port"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "bastion_security_group_ssh_ingress" {
  security_group_id = "${aws_security_group.bastion_security_group.id}"
  type      = "ingress"
  protocol  = "tcp"
  from_port = 22
  to_port   = 22

  cidr_blocks = [
    "${var.remote_access_cidr}",
  ]
}

resource "aws_security_group_rule" "bastion_security_group_icmp_ingress" {
  security_group_id = "${aws_security_group.bastion_security_group.id}"
  type      = "ingress"
  protocol  = "icmp"
  from_port = -1
  to_port   = -1

  cidr_blocks = [
    "${var.remote_access_cidr}"
  ]
}

resource "aws_security_group_rule" "bastion_security_group_egress" {
  security_group_id = "${aws_security_group.bastion_security_group.id}"
  type      = "egress"
  protocol  = "tcp"
  from_port = 0
  to_port   = 65535

  cidr_blocks = [
    "0.0.0.0/0"
  ]
}

resource "aws_launch_configuration" "bastion_launch_configuration" {
  name = "${var.vpc_name}-bastion_launch_configuration"

  associate_public_ip_address = true
  placement_tenancy           = "${var.bastion_tenancy}"
  key_name                    = "${var.bastion_key_name}"
  iam_instance_profile        = "${aws_iam_instance_profile.bastion_host_profile.name}"
  image_id                    = "${lookup(var.bastion_amis, "${var.aws_region}.${var.bastion_instance_os}")}"
  security_groups             = ["${aws_security_group.bastion_security_group.id}"]
  instance_type               = "${var.bastion_instance_type}"
}

resource "aws_autoscaling_group" "bastion_server_group" {
  name = "${var.vpc_name}-bastion_server_group"
  launch_configuration = "${aws_launch_configuration.bastion_launch_configuration.name}"

  vpc_zone_identifier       = "${var.subnet_ids}"
  min_size                  = "${var.num_bastion_hosts}"
  max_size                  = "${var.num_bastion_hosts}"
  desired_capacity          = "${var.num_bastion_hosts}"
  default_cooldown          = 300
  health_check_type         = "EC2"

  tag {
    key                 = "Name"
    value               = "${var.vpc_name}-bastion_host"
    propagate_at_launch = true
  }
}
