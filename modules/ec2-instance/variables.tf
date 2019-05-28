variable "aws_region" {
  description = "EC2 Region for the VPC"
  default     = "us-east-1"
}

variable "vpc_security_group_ids" {
  type = "list"
}

variable "associate_public_ip_address" {
  default = false
}

variable "subnet_id" {
  type = "string"
}

variable "instance_name" {
  type = "string"
}

variable "instance_type" {
  description = "Amazon EC2 instance type for the bastion instances"
  default = "t3.nano"
}

variable "instance_os" {
  default = "amazon-linux-hvm"
}

variable "iam_instance_profile" {
  type = "string"
}

variable "root_block_device_type" {
  type = "string"
  default = "gp2"
}

variable "root_block_device_size" {
  type = "string"
  default = 8
}

variable "ebs_volume_size" {
  default = 0
}

variable "ebs_volume_type" {
  type = "string"
  default = "gp2"
}

variable "ebs_encrypted" {
  default = true
}

variable "ebs_device_names" {
  type = "list"
  default = [
    "/dev/sdf",
    "/dev/sdg",
    "/dev/sdh",
    "/dev/sdi",
    "/dev/sdj",
    "/dev/sdk",
    "/dev/sdl",
    "/dev/sdm",
    "/dev/sdn",
    "/dev/sdo",
    "/dev/sdp"
  ]
}

variable "tenancy" {
  description = "VPC Tenancy to launch the bastion in. Options: 'dedicated' or 'default'"
  default = "default"
}

variable "key_name" {
  description = "name of the key used to access the bastion EC2 instances"
  type        = "string"
  default     = ""
}

variable "amis" {
  description = "AMIs by region"
  type        = "map"

  default = {
    "us-east-1.amazon-linux-hvm"      = "ami-0ff8a91507f77f867"
    "us-east-2.amazon-linux-hvm"      = "ami-0b59bfac6be064b78"
    "us-west-1.amazon-linux-hvm"      = "ami-0bdb828fd58c52235"
    "us-west-2.amazon-linux-hvm"      = "ami-a0cfeed8"
    "eu-central-1.amazon-linux-hvm"   = "ami-0233214e13e500f77"
    "eu-west-1.amazon-linux-hvm"      = "ami-047bb4163c506cd98"
    "eu-west-2.amazon-linux-hvm"      = "ami-f976839e"
    "eu-west-3.amazon-linux-hvm"      = "ami-0ebc281c20e89ba4b"
    "ap-south-1.amazon-linux-hvm"     = "ami-0912f71e06545ad88"
    "ap-southeast-1.amazon-linux-hvm" = "ami-08569b978cc4dfa10"
    "ap-southeast-2.amazon-linux-hvm" = "ami-09b42976632b27e9b"
    "ap-northeast-1.amazon-linux-hvm" = "ami-06cd52961ce9f0d85"
    "ap-northeast-2.amazon-linux-hvm" = "ami-0a10b2721688ce9d2"
    "sa-east-1.amazon-linux-hvm"      = "ami-07b14488da8ea02a0"
    "ca-central-1.amazon-linux-hvm"   = "ami-0b18956f"
  }
}
