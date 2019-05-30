variable "bastion_instance_type" {
  description = "Amazon EC2 instance type for the bastion instances"
  default = "t3.nano"
}

variable "bastion_key_name" {
  description = "name of the key used to access the bastion EC2 instances"
  type        = "string"
  default     = ""
}

variable "bastion_remote_access_cidr_blocks" {
  description = "Allowed CIDR blocks for external SSH access to the bastions"
  type = "list"
  default = [
    "0.0.0.0/0"
  ]
}

variable "bastion_egress_cidr_blocks" {
  description = "Allowed CIDR blocks for egress from the bastion"
  type = "list"
  default = [
    "0.0.0.0/0"
  ]
}

variable "bastion_tenancy" {
  description = "The tenancy of the ingestion instance: default, dedicated, host."
  type = "string"
  default = "default"
}

variable "bastion_root_block_device_size" {
  default = 8
}

variable "bastion_root_block_device_type" {
  default = "gp2"
}

variable "bastion_enable" {
  description = "Whether or not to create this instance"
  default = true
}

