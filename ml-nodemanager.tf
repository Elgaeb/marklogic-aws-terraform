locals {
  eni_tag_prefix = "${var.cluster_name}-${md5(var.cluster_id)}_"
}

resource "aws_network_interface" "managed_eni" {
  count = "${var.number_of_zones * var.nodes_per_zone}"

  subnet_id = "${element(module.vpc.private_subnet_ids, count.index % var.number_of_zones)}"
  security_groups = [ "${aws_security_group.instance_security_group.id}" ]

  tags = {
    "cluster-eni-id" = "${local.eni_tag_prefix}${count.index}"
  }
}

output "managed_eni_private_ips" {
  value = "${aws_network_interface.managed_eni.*.private_ip}"
}

output "managed_eni_private_dns" {
  value = "${aws_network_interface.managed_eni.*.private_dns_name}"
}

data "aws_iam_policy_document" "node_manager_exec_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = [
        "lambda.amazonaws.com",
        "autoscaling.amazonaws.com",
      ]

      type = "Service"
    }

    effect = "Allow"
  }
}

resource "aws_iam_role" "node_manager_exec_role" {
  count = "${var.enable_marklogic ? 1 : 0}"

  name               = "${var.cluster_name}-node_manager_exec_role"
  assume_role_policy = "${data.aws_iam_policy_document.node_manager_exec_assume_role_policy.json}"
}

data "aws_iam_policy_document" "node_manager_role_policy" {
  statement {
    effect    = "Allow"
    actions   = ["sns:Publish"]
    resources = ["arn:aws:sns:*:*:*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:DescribeNetworkInterfaces",
      "ec2:AttachNetworkInterface",
      "ec2:DescribeInstances",
      "autoscaling:CompleteLifecycleAction",
    ]

    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["ec2:CreateTags"]
    resources = ["arn:aws:ec2:*:*:network-interface/*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }
}

resource "aws_iam_policy" "node_manager_policy" {
  count = "${var.enable_marklogic ? 1 : 0}"

  name   = "${var.cluster_name}-node_manager_policy"
  policy = "${data.aws_iam_policy_document.node_manager_role_policy.json}"
}

resource "aws_iam_role_policy_attachment" "node_manager_policy_attachment" {
  count = "${var.enable_marklogic ? 1 : 0}"

  role       = "${aws_iam_role.node_manager_exec_role.0.name}"
  policy_arn = "${aws_iam_policy.node_manager_policy.0.arn}"
}

resource "aws_lambda_function" "node_manager_function" {
  count = "${var.enable_marklogic ? 1 : 0}"

  depends_on = [
    "aws_network_interface.managed_eni"
  ]

  function_name = "${var.cluster_name}-node_manager_function"

//  s3_bucket = "${var.lambda_package_bucket_base}${var.aws_region}"
//  s3_key    = "${var.s3_directory_base}/node_manager.zip"
  filename  = "./files/node_manager_${var.marklogic_version}-SNAPSHOT.zip"

  handler = "nodemanager.handler"
  role    = "${aws_iam_role.node_manager_exec_role.0.arn}"
  runtime = "python3.6"
  timeout = 180
}

resource "aws_sns_topic" "node_manager_sns_topic" {
  count = "${var.enable_marklogic ? 1 : 0}"

  name = "${var.cluster_name}-node_manager_sns_topic"
}

resource "aws_sns_topic_subscription" "node_manager_sns_topic_subscription" {
  count = "${var.enable_marklogic ? 1 : 0}"

  endpoint  = "${aws_lambda_function.node_manager_function.0.arn}"
  protocol  = "lambda"
  topic_arn = "${aws_sns_topic.node_manager_sns_topic.0.arn}"
}

resource "aws_lambda_permission" "node_manager_invoke_permission" {
  count = "${var.enable_marklogic ? 1 : 0}"

  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.node_manager_function.0.function_name}"
  principal     = "sns.amazonaws.com"
  source_arn    = "${aws_sns_topic.node_manager_sns_topic.0.arn}"
}

output "node_manager_iam_arn" {
  value = "${aws_iam_role.node_manager_exec_role.*.arn}"
}

output "node_manager_sns_arn" {
  value = "${aws_sns_topic.node_manager_sns_topic.*.arn}"
}
