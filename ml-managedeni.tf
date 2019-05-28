
resource "aws_cloudformation_stack" "managed_eni_stack" {
  count = "${var.enable_marklogic ? 1 : 0}"

  name = "${var.cluster_name}-managed-eni-stack"

  depends_on = [
    "aws_security_group.instance_security_group"
  ]

  capabilities = [ "CAPABILITY_IAM" ]

  template_body = "${file("ml-managedeni-${var.marklogic_version}.template")}"
//  template_url = "${var.template_url_base}/${var.s3_directory_base}/ml-managedeni.template"

  parameters = {
    S3Bucket        = "${var.lambda_package_bucket_base}${var.aws_region}"
    S3Directory     = "${var.s3_directory_base}"
    NodesPerZone    = "${var.nodes_per_zone}"
    NumberOfZones   = "${var.number_of_zones}"
//    Subnets         = "${join(",", var.private_subnet_ids)}"
    Subnets         = "${join(",", module.vpc.private_subnet_ids)}"
    ParentStackName = "${var.cluster_name}"
    ParentStackId   = "${var.cluster_id}"
    SecurityGroup   = "${aws_security_group.instance_security_group.id}"
  }
}

output "eni" {
    value = "${aws_cloudformation_stack.managed_eni_stack.*.outputs}"
}

/*
data "aws_iam_policy_document" "managed_eni_assume_role_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = [
        "lambda.amazonaws.com",
      ]

      type = "Service"
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "managed_eni_policy_document" {
  statement {
    effect = "Allow"
    resources = ["*"]
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:DetachNetworkInterface",
      "ec2:DescribeNetworkInterfaces"
    ]
  }

  statement {
    effect = "Allow"
    resources = ["arn:aws:ec2:*:*:network-interface/*"]
    actions = [
      "ec2:CreateTags"
    ]
  }

  statement {
    effect = "Allow"
    resources = ["arn:aws:logs:*:*:*"]
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
  }
}

resource "aws_iam_policy" "managed_eni_policy" {
  name   = "${var.cluster_name}-managed_eni_policy"
  policy = "${data.aws_iam_policy_document.managed_eni_policy_document.json}"
}

resource "aws_iam_role" "managed_eni_role" {
  assume_role_policy = "${data.aws_iam_policy_document.managed_eni_assume_role_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "managed_eni_host_policy_attachment" {
  role       = "${aws_iam_role.managed_eni_role.name}"
  policy_arn = "${aws_iam_policy.managed_eni_policy.arn}"
}

resource "aws_lambda_function" "managed_eni_lambda" {
  function_name = "${var.cluster_name}-managed_eni_lambda"
  handler = "managedeni.handler"
  role = "${aws_iam_role.managed_eni_role.arn}"
  runtime = "python3.6"
  timeout = 180

  s3_bucket = "${var.lambda_package_bucket_base}${var.aws_region}"
  s3_key = "${var.s3_directory_base}/managed_eni.zip"
}

data "aws_lambda_invocation" "example" {
  function_name = "${aws_lambda_function.managed_eni_lambda.function_name}"

  input = <<JSON
{
  "ResourceProperties": "value1",
  "NodesPerZone": "${var.nodes_per_zone}",
  "NumberOfZones": "${var.number_of_zones}",
  "ParentStackName": "${var.cluster_name}",
  "ParentStackId": "${var.cluster_id}",
//  "Subnets": "${join(",", var.private_subnet_ids)}",
  "Subnets": "${join(",", module.vpc.private_subnet_ids)}",
  "SecurityGroup": "${aws_security_group.instance_security_group.id}"
}
JSON
}
*/


