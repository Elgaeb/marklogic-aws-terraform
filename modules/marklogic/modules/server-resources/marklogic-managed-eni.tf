resource "aws_network_interface" "managed_eni" {
  count = local.enable * var.node_count

  subnet_id = var.subnet_id
  security_groups = [ var.instance_security_group_id ]

  tags = {
    "cluster-eni-id" = "${var.cluster_name}-${var.group_number}-${md5(var.cluster_id)}_${count.index}"
  }
}

