data "aws_iam_policy_document" "ingestion_assume_role_policy" {
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

data "aws_iam_policy_document" "ingestion_policy" {
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

resource "aws_iam_policy" "ingestion_host_policy" {
  count = var.ingestion_enable ? 1 : 0
  name   = "${var.cluster_name}-ingestion_host_policy"
  policy = data.aws_iam_policy_document.ingestion_policy.json
}

resource "aws_iam_role" "ingestion_host_role" {
  count = var.ingestion_enable ? 1 : 0
  assume_role_policy = data.aws_iam_policy_document.ingestion_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ingestion_host_policy_attachment" {
  count = var.ingestion_enable ? 1 : 0
  role       = aws_iam_role.ingestion_host_role[0].name
  policy_arn = aws_iam_policy.ingestion_host_policy[0].arn
}

resource "aws_iam_instance_profile" "ingestion_host_profile" {
  count = var.ingestion_enable ? 1 : 0
  role = aws_iam_role.ingestion_host_role[0].name
  path = "/"
}