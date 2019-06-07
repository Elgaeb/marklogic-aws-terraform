terraform {
  required_version = ">= 0.12.0"
}

locals {
  enable            = (var.enable ? 1 : 0) * (var.volume_count > var.volume_number ? 1 : 0)
  volume_size       = flatten([ var.volume_size ])
  volume_type       = flatten([ var.volume_type ])
  volume_iops       = flatten([ var.volume_iops ])
  volume_encrypted  = flatten([ var.volume_encrypted ])
  volume_kms_key_id = flatten([ var.volume_kms_key_id ])
}

resource "aws_ebs_volume" "marklogic_volume" {
  count             = local.enable * var.node_count
  availability_zone = var.availability_zone
  size              = local.volume_size[var.volume_number % length(local.volume_size)]
  type              = local.volume_type[var.volume_number % length(local.volume_type)]
  iops              = local.volume_type == "io1" ? local.volume_iops[var.volume_number % length(local.volume_iops)] : null
  encrypted         = local.volume_encrypted[var.volume_number % length(local.volume_encrypted)]
  kms_key_id        = local.volume_kms_key_id[var.volume_number % length(local.volume_kms_key_id)]

  lifecycle {
    ignore_changes = [
      "tags"
    ]
  }

  tags = {
    Name = "MarkLogic EBS G-${var.group_number} S-${count.index} V-${var.volume_number}"
    Terraform = true
    MarkLogicCluster = var.cluster_name
  }
}
