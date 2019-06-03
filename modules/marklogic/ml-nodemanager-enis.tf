resource "aws_network_interface" "managed_eni_group_1" {
  count = "${(var.enable_marklogic ? 1 : 0) * tonumber(element(local.node_counts, 0 % length(local.node_counts)))}"

  subnet_id = "${element(var.private_subnet_ids, 0 % length(var.private_subnet_ids))}"
  security_groups = [ "${aws_security_group.instance_security_group.id}" ]

  tags = {
    "cluster-eni-id" = "${var.cluster_name}-0-${md5(var.cluster_id)}_${count.index}"
  }
}

resource "aws_network_interface" "managed_eni_group_2" {
  count = "${(var.enable_marklogic && var.number_of_zones > 1 ? 1 : 0) * tonumber(element(local.node_counts, 1 % length(local.node_counts)))}"

  subnet_id = "${element(var.private_subnet_ids, 1 % length(var.private_subnet_ids))}"
  security_groups = [ "${aws_security_group.instance_security_group.id}" ]

  tags = {
    "cluster-eni-id" = "${var.cluster_name}-1-${md5(var.cluster_id)}_${count.index}"
  }
}

resource "aws_network_interface" "managed_eni_group_3" {
  count = "${(var.enable_marklogic && var.number_of_zones > 2 ? 1 : 0) * tonumber(element(local.node_counts, 2 % length(local.node_counts)))}"

  subnet_id = "${element(var.private_subnet_ids, 2 % length(var.private_subnet_ids))}"
  security_groups = [ "${aws_security_group.instance_security_group.id}" ]

  tags = {
    "cluster-eni-id" = "${var.cluster_name}-2-${md5(var.cluster_id)}_${count.index}"
  }
}

resource "aws_network_interface" "managed_eni_group_4" {
  count = "${(var.enable_marklogic && var.number_of_zones > 3 ? 1 : 0) * tonumber(element(local.node_counts, 3 % length(local.node_counts)))}"

  subnet_id = "${element(var.private_subnet_ids, 3 % length(var.private_subnet_ids))}"
  security_groups = [ "${aws_security_group.instance_security_group.id}" ]

  tags = {
    "cluster-eni-id" = "${var.cluster_name}-3-${md5(var.cluster_id)}_${count.index}"
  }
}

resource "aws_network_interface" "managed_eni_group_5" {
  count = "${(var.enable_marklogic && var.number_of_zones > 4 ? 1 : 0) * tonumber(element(local.node_counts, 4 % length(local.node_counts)))}"

  subnet_id = "${element(var.private_subnet_ids, 4 % length(var.private_subnet_ids))}"
  security_groups = [ "${aws_security_group.instance_security_group.id}" ]

  tags = {
    "cluster-eni-id" = "${var.cluster_name}-4-${md5(var.cluster_id)}_${count.index}"
  }
}

resource "aws_network_interface" "managed_eni_group_6" {
  count = "${(var.enable_marklogic && var.number_of_zones > 5 ? 1 : 0) * tonumber(element(local.node_counts, 5 % length(local.node_counts)))}"

  subnet_id = "${element(var.private_subnet_ids, 5 % length(var.private_subnet_ids))}"
  security_groups = [ "${aws_security_group.instance_security_group.id}" ]

  tags = {
    "cluster-eni-id" = "${var.cluster_name}-5-${md5(var.cluster_id)}_${count.index}"
  }
}
