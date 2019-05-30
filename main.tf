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
  aws_region            = "${var.aws_region}"
  azs                   = "${var.azs}"
  number_of_zones       = "${var.number_of_zones}"
}

//module "bastion" {
//  source = "./modules/bastion"
//
//  aws_region = "${var.aws_region}"
//
//  bastion_instance_type = "${var.bastion_instance_type}"
//  bastion_key_name      = "${var.bastion_key_name}"
//
//  subnet_ids            = "${module.vpc.public_subnet_ids}"
//  vpc_name              = "${var.cluster_name}-vpc"
//  vpc_id                = "${module.vpc.vpc_id}"
//}

module "bastion" {
  source = "./modules/ec2-instance"

  aws_region = "${var.aws_region}"

  vpc_security_group_ids = [ "${aws_security_group.bastion_security_group.id}" ]
  associate_public_ip_address = true
  subnet_id = "${element(module.vpc.public_subnet_ids, 0)}"
  instance_name = "${var.cluster_name}-bastion"
  instance_type = "${var.bastion_instance_type}"
  iam_instance_profile = ""

  root_block_device_size = "${var.bastion_root_block_device_size}"
  root_block_device_type = "${var.bastion_root_block_device_type}"

  tenancy = "${var.bastion_tenancy}"
  key_name = "${var.bastion_key_name}"
}

module "ingestion" {
  source = "./modules/ec2-instance"

  aws_region = "${var.aws_region}"

  vpc_security_group_ids = [ "${module.marklogic.instance_security_group_id}" ]
  associate_public_ip_address = false
  subnet_id = "${element(module.vpc.private_subnet_ids, 0)}"
  instance_name = "${var.cluster_name}-ingestion"
  instance_type = "${var.ingestion_instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.ingestion_host_profile.name}"

  ebs_volume_size = "${var.ingestion_volume_size}"
  ebs_volume_type = "${var.ingestion_volume_type}"
  ebs_encrypted = "${var.ingestion_ebs_encrypted}"

  tenancy = "${var.ingestion_tenancy}"
  key_name = "${var.ingestion_key_name}"
}

module "marklogic" {
  source = "./modules/marklogic"

  marklogic_version = "${var.marklogic_version}"
  licensee = "${var.licensee}"
  licensee_key = "${var.licensee_key}"

  key_name = "${var.key_name}"
  cluster_name = "${var.cluster_name}"
  cluster_id = "${var.cluster_id}"
  aws_region = "${var.aws_region}"
  azs = "${var.azs}"
  number_of_zones = "${var.number_of_zones}"
  nodes_per_zone = "${var.nodes_per_zone}"

  instance_type = "${var.instance_type}"
  volume_size = "${var.volume_size}"
  volume_type = "${var.volume_type}"

  expose_administration_console = "${var.expose_administration_console}"

  enable_data_explorer = "${var.enable_data_explorer}"
  enable_data_hub = "${var.enable_data_hub}"
  enable_grove = "${var.enable_grove}"
  enable_marklogic = "${var.enable_marklogic}"
  enable_ops_director = "${var.enable_ops_director}"

  vpc_cidr           = "${module.vpc.vpc_cidr_block}"
  vpc_id             = "${module.vpc.vpc_id}"
  public_subnet_ids  = "${module.vpc.public_subnet_ids}"
  private_subnet_ids = "${module.vpc.private_subnet_ids}"
}

