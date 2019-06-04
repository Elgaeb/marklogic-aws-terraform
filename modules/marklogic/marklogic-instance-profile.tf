data "aws_iam_policy_document" "instance_assume_role_policy" {
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

data "aws_iam_policy_document" "instance_policy" {
  statement {
    actions = [
      "ec2:*",
      "s3:*",
      "dynamodb:*",
    ]

    resources = ["*"]

    effect = "Allow"
  }
}

resource "aws_iam_policy" "instance_host_policy" {
  name   = "${var.cluster_name}-instance_host_policy"
  policy = data.aws_iam_policy_document.instance_policy.json
}

resource "aws_iam_role" "instance_host_role" {
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "instance_host_policy_attachment" {
  role       = aws_iam_role.instance_host_role.name
  policy_arn = aws_iam_policy.instance_host_policy.arn
}

resource "aws_iam_instance_profile" "instance_host_profile" {
  role = aws_iam_role.instance_host_role.name
  path = "/"
}
