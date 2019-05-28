locals {
  ebs_volume_count = "${var.ebs_volume_size > 0 ? 1 : 0}"
}

resource "aws_instance" "ec2_instance" {
  ami = "${lookup(var.amis, "${var.aws_region}.${var.instance_os}")}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  iam_instance_profile = "${var.iam_instance_profile}"
  tenancy = "${var.tenancy}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  vpc_security_group_ids = "${var.vpc_security_group_ids}"
  subnet_id = "${var.subnet_id}"

  tags = {
    Name = "${var.instance_name}"
    Terraform = true
  }

  root_block_device {
    volume_type = "${var.root_block_device_type}"
    volume_size = "${var.root_block_device_size}"
  }
}

resource "aws_ebs_volume" "ebs_volume" {
  count = "${local.ebs_volume_count}"

  availability_zone = "${aws_instance.ec2_instance.availability_zone}"
  size              = "${var.ebs_volume_size}"

  encrypted         = "${var.ebs_encrypted}"
}

resource "aws_volume_attachment" "volume_attachment" {
  count = "${local.ebs_volume_count}"

  device_name = "${element(var.ebs_device_names, count.index)}"
  instance_id = "${aws_instance.ec2_instance.id}"
  volume_id   = "${element(aws_ebs_volume.ebs_volume.*.id, count.index)}"
}