locals {
  enable_count = var.enable ? 1 : 0
  volume_size = flatten([ var.ebs_volume_size ])
}

resource "aws_instance" "ec2_instance" {
  count = local.enable_count

  ami = lookup(var.amis, "${var.aws_region}.${var.instance_os}")
  instance_type = var.instance_type
  key_name = var.key_name
  iam_instance_profile = var.iam_instance_profile
  tenancy = var.tenancy
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id = var.subnet_id

  tags = {
    Name = var.instance_name
    Terraform = true
  }

  root_block_device {
    volume_type = var.root_block_device_type
    volume_size = var.root_block_device_size
    iops        = var.root_block_device_iops
  }
}

resource "aws_ebs_volume" "ebs_volume" {
  count = local.enable_count * length(local.volume_size)

  availability_zone = aws_instance.ec2_instance[0].availability_zone
  size              = local.volume_size[count.index]
  type              = var.ebs_volume_type
  iops              = var.ebs_volume_iops

  encrypted         = var.ebs_encrypted

  tags = {
    Name = format("%s-ebs-%d",var.instance_name, count.index)
    Terraform = true
  }
}

resource "aws_volume_attachment" "volume_attachment" {
  count = local.enable_count * length(local.volume_size)

  device_name = var.ebs_device_names[count.index]
  instance_id = aws_instance.ec2_instance[0].id
  volume_id   = aws_ebs_volume.ebs_volume[count.index].id
}
