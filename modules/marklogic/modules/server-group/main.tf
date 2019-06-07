terraform {
  required_version = ">= 0.12.0"
}

locals {
  enable = var.enable ? 1 : 0
  volume_size = flatten([ var.volume_size ])
  volume_type = flatten([ var.volume_type ])
  volume_iops = flatten([ var.volume_iops ])
  volume_encrypted = flatten([ var.volume_encrypted ])
}

module "volume_0" {
  source = "./modules/volume"

  volume_number = 0

  enable = var.enable
  group_number = var.group_number
  availability_zone = var.availability_zone
  node_count = var.node_count
  cluster_name = var.cluster_name
  cluster_id = var.cluster_id
  volume_size = var.volume_size
  volume_type = var.volume_type
  volume_iops = var.volume_iops
  volume_encrypted = var.volume_encrypted
  volume_kms_key_id = var.volume_kms_key_id
  volume_count = var.volume_count
}

module "volume_1" {
  source = "./modules/volume"

  volume_number = 1

  enable = var.enable
  group_number = var.group_number
  availability_zone = var.availability_zone
  node_count = var.node_count
  cluster_name = var.cluster_name
  cluster_id = var.cluster_id
  volume_size = var.volume_size
  volume_type = var.volume_type
  volume_iops = var.volume_iops
  volume_encrypted = var.volume_encrypted
  volume_kms_key_id = var.volume_kms_key_id
  volume_count = var.volume_count
}

module "volume_2" {
  source = "./modules/volume"

  volume_number = 2

  enable = var.enable
  group_number = var.group_number
  availability_zone = var.availability_zone
  node_count = var.node_count
  cluster_name = var.cluster_name
  cluster_id = var.cluster_id
  volume_size = var.volume_size
  volume_type = var.volume_type
  volume_iops = var.volume_iops
  volume_encrypted = var.volume_encrypted
  volume_kms_key_id = var.volume_kms_key_id
  volume_count = var.volume_count
}

module "volume_3" {
  source = "./modules/volume"

  volume_number = 3

  enable = var.enable
  group_number = var.group_number
  availability_zone = var.availability_zone
  node_count = var.node_count
  cluster_name = var.cluster_name
  cluster_id = var.cluster_id
  volume_size = var.volume_size
  volume_type = var.volume_type
  volume_iops = var.volume_iops
  volume_encrypted = var.volume_encrypted
  volume_kms_key_id = var.volume_kms_key_id
  volume_count = var.volume_count
}

module "volume_4" {
  source = "./modules/volume"

  volume_number = 4

  enable = var.enable
  group_number = var.group_number
  availability_zone = var.availability_zone
  node_count = var.node_count
  cluster_name = var.cluster_name
  cluster_id = var.cluster_id
  volume_size = var.volume_size
  volume_type = var.volume_type
  volume_iops = var.volume_iops
  volume_encrypted = var.volume_encrypted
  volume_kms_key_id = var.volume_kms_key_id
  volume_count = var.volume_count
}

module "volume_5" {
  source = "./modules/volume"

  volume_number = 5

  enable = var.enable
  group_number = var.group_number
  availability_zone = var.availability_zone
  node_count = var.node_count
  cluster_name = var.cluster_name
  cluster_id = var.cluster_id
  volume_size = var.volume_size
  volume_type = var.volume_type
  volume_iops = var.volume_iops
  volume_encrypted = var.volume_encrypted
  volume_kms_key_id = var.volume_kms_key_id
  volume_count = var.volume_count
}

module "volume_6" {
  source = "./modules/volume"

  volume_number = 6

  enable = var.enable
  group_number = var.group_number
  availability_zone = var.availability_zone
  node_count = var.node_count
  cluster_name = var.cluster_name
  cluster_id = var.cluster_id
  volume_size = var.volume_size
  volume_type = var.volume_type
  volume_iops = var.volume_iops
  volume_encrypted = var.volume_encrypted
  volume_kms_key_id = var.volume_kms_key_id
  volume_count = var.volume_count
}

module "volume_7" {
  source = "./modules/volume"

  volume_number = 7

  enable = var.enable
  group_number = var.group_number
  availability_zone = var.availability_zone
  node_count = var.node_count
  cluster_name = var.cluster_name
  cluster_id = var.cluster_id
  volume_size = var.volume_size
  volume_type = var.volume_type
  volume_iops = var.volume_iops
  volume_encrypted = var.volume_encrypted
  volume_kms_key_id = var.volume_kms_key_id
  volume_count = var.volume_count
}

module "volume_8" {
  source = "./modules/volume"

  volume_number = 8

  enable = var.enable
  group_number = var.group_number
  availability_zone = var.availability_zone
  node_count = var.node_count
  cluster_name = var.cluster_name
  cluster_id = var.cluster_id
  volume_size = var.volume_size
  volume_type = var.volume_type
  volume_iops = var.volume_iops
  volume_encrypted = var.volume_encrypted
  volume_kms_key_id = var.volume_kms_key_id
  volume_count = var.volume_count
}

module "volume_9" {
  source = "./modules/volume"

  volume_number = 9

  enable = var.enable
  group_number = var.group_number
  availability_zone = var.availability_zone
  node_count = var.node_count
  cluster_name = var.cluster_name
  cluster_id = var.cluster_id
  volume_size = var.volume_size
  volume_type = var.volume_type
  volume_iops = var.volume_iops
  volume_encrypted = var.volume_encrypted
  volume_kms_key_id = var.volume_kms_key_id
  volume_count = var.volume_count
}

