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

  access_key            = "${var.access_key}"
  secret_key            = "${var.secret_key}"

  vpc_name              = "${var.cluster_name}-vpc"
  aws_region            = "${var.aws_region}"
  azs                   = "${var.azs}"
  number_of_zones       = "${var.number_of_zones}"
}

module "bastion" {
  source = "./modules/bastion"

  aws_region = "${var.aws_region}"

  bastion_instance_type = "${var.bastion_instance_type}"
  bastion_key_name      = "${var.bastion_key_name}"

  subnet_ids            = "${module.vpc.public_subnet_ids}"
  vpc_name              = "${var.cluster_name}-vpc"
  vpc_id                = "${module.vpc.vpc_id}"
}

module "ingestion" {
  source = "./modules/ec2-instance"

  aws_region = "${var.aws_region}"

  vpc_security_group_ids = "${[ aws_security_group.instance_security_group.id ]}"
  associate_public_ip_address = false
  subnet_id = "${module.vpc.public_subnet_ids[0]}"
  instance_name = "${var.cluster_name}-ingestion"
  instance_type = "${var.ingestion_instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.ingestion_host_profile.name}"

  ebs_volume_size = "${var.ingestion_volume_size}"
  ebs_volume_type = "${var.ingestion_volume_type}"
  ebs_encrypted = "${var.ingestion_ebs_encrypted}"

  tenancy = "${var.ingestion_tenancy}"
  key_name = "${var.ingestion_key_name}"

}