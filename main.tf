terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.aws_region}"

  version = "~> 2.11"
}

provider "template" {
  version = "~> 2.1"
}

module "vpc" {
  source = "./modules/vpc"

  vpc_name              = "${var.cluster_name}-vpc"
  aws_region            = var.aws_region
  azs                   = var.azs
  number_of_zones       = var.number_of_zones

  enable = var.create_vpc
}

locals {
  vpc_cidr = coalesce(module.vpc.vpc_cidr_block, var.vpc_cidr)
  vpc_id = coalesce(module.vpc.vpc_id, var.vpc_id)
  public_subnet_ids = coalescelist(module.vpc.public_subnet_ids, var.public_subnet_ids)
  private_subnet_ids = coalescelist(module.vpc.private_subnet_ids, var.private_subnet_ids)
}

module "bastion" {
  source = "./modules/ec2-instance"

  enable = var.bastion_enable

  aws_region = var.aws_region

  vpc_security_group_ids = [ aws_security_group.bastion_security_group[0].id ]
  associate_public_ip_address = true
  subnet_id = local.public_subnet_ids[0]
  instance_name = "${var.cluster_name}-bastion"
  instance_type = var.bastion_instance_type
  iam_instance_profile = ""

  root_block_device_size = var.bastion_root_block_device_size
  root_block_device_type = var.bastion_root_block_device_type

  tenancy = var.bastion_tenancy
  key_name = var.bastion_key_name
}

module "ingestion" {
  source = "./modules/ec2-instance"

  enable = var.ingestion_enable

  aws_region = var.aws_region

  vpc_security_group_ids = [ module.marklogic.instance_security_group_id ]
  associate_public_ip_address = false
  subnet_id = local.private_subnet_ids[0]
  instance_name = "${var.cluster_name}-ingestion"
  instance_type = var.ingestion_instance_type
  iam_instance_profile = aws_iam_instance_profile.ingestion_host_profile[0].name

  ebs_volume_size = var.ingestion_volume_size
  ebs_volume_type = var.ingestion_volume_type
  ebs_encrypted = var.ingestion_ebs_encrypted

  tenancy = var.ingestion_tenancy
  key_name = var.ingestion_key_name
}

module "marklogic" {
  source = "./modules/marklogic"

  marklogic_version = var.marklogic_version
  licensee = var.licensee
  licensee_key = var.licensee_key

  marklogic_admin_password = var.marklogic_admin_password

  key_name = var.key_name
  cluster_name = var.cluster_name
  cluster_id = var.cluster_id
  aws_region = var.aws_region
  availability_zones = var.azs
  number_of_zones = var.number_of_zones

  expose_administration_console = var.expose_administration_console

  enable_data_explorer = var.enable_data_explorer
  data_explorer_port = var.data_explorer_port
  enable_data_hub = var.enable_data_hub
  enable_grove = var.enable_grove
  grove_port = var.grove_port
  enable_marklogic = var.enable_marklogic
  enable_ops_director = var.enable_ops_director

  vpc_cidr           = local.vpc_cidr
  vpc_id             = local.vpc_id
  public_subnet_ids  = local.public_subnet_ids
  private_subnet_ids = local.private_subnet_ids

  server_group_0_subnet_index = var.server_group_0_subnet_index
  server_group_0_node_count = var.server_group_0_node_count
  server_group_0_instance_type = var.server_group_0_instance_type
  server_group_0_volume_size = var.server_group_0_volume_size
  server_group_0_volume_type = var.server_group_0_volume_type
  server_group_0_volume_iops = var.server_group_0_volume_iops
  server_group_0_volume_encrypted = var.server_group_0_volume_encrypted
  server_group_0_volume_count = var.server_group_0_volume_count

  server_group_1_subnet_index = var.server_group_1_subnet_index
  server_group_1_node_count = var.server_group_1_node_count
  server_group_1_instance_type = var.server_group_1_instance_type
  server_group_1_volume_size = var.server_group_1_volume_size
  server_group_1_volume_type = var.server_group_1_volume_type
  server_group_1_volume_iops = var.server_group_1_volume_iops
  server_group_1_volume_encrypted = var.server_group_1_volume_encrypted
  server_group_1_volume_count = var.server_group_1_volume_count

  server_group_2_subnet_index = var.server_group_2_subnet_index
  server_group_2_node_count = var.server_group_2_node_count
  server_group_2_instance_type = var.server_group_2_instance_type
  server_group_2_volume_size = var.server_group_2_volume_size
  server_group_2_volume_type = var.server_group_2_volume_type
  server_group_2_volume_iops = var.server_group_2_volume_iops
  server_group_2_volume_encrypted = var.server_group_2_volume_encrypted
  server_group_2_volume_count = var.server_group_2_volume_count

  server_group_3_subnet_index = var.server_group_3_subnet_index
  server_group_3_node_count = var.server_group_3_node_count
  server_group_3_instance_type = var.server_group_3_instance_type
  server_group_3_volume_size = var.server_group_3_volume_size
  server_group_3_volume_type = var.server_group_3_volume_type
  server_group_3_volume_iops = var.server_group_3_volume_iops
  server_group_3_volume_encrypted = var.server_group_3_volume_encrypted
  server_group_3_volume_count = var.server_group_3_volume_count

  server_group_4_subnet_index = var.server_group_4_subnet_index
  server_group_4_node_count = var.server_group_4_node_count
  server_group_4_instance_type = var.server_group_4_instance_type
  server_group_4_volume_size = var.server_group_4_volume_size
  server_group_4_volume_type = var.server_group_4_volume_type
  server_group_4_volume_iops = var.server_group_4_volume_iops
  server_group_4_volume_encrypted = var.server_group_4_volume_encrypted
  server_group_4_volume_count = var.server_group_4_volume_count

  server_group_5_subnet_index = var.server_group_5_subnet_index
  server_group_5_node_count = var.server_group_5_node_count
  server_group_5_instance_type = var.server_group_5_instance_type
  server_group_5_volume_size = var.server_group_5_volume_size
  server_group_5_volume_type = var.server_group_5_volume_type
  server_group_5_volume_iops = var.server_group_5_volume_iops
  server_group_5_volume_encrypted = var.server_group_5_volume_encrypted
  server_group_5_volume_count = var.server_group_5_volume_count
}
