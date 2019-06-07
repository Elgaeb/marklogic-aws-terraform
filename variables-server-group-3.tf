variable "server_group_3_subnet_index" {
  type = number
  default = 0
}

variable "server_group_3_node_count" {
  type = number
  default = 0
}

variable "server_group_3_instance_type" {
  type = string
  default = "t3.small"
}

variable "server_group_3_volume_size" {
  default = 10
}

variable "server_group_3_volume_type" {
  type = string
  default = "gp2"
}

variable "server_group_3_volume_iops" {
  type = number
  default = 100
}

variable "server_group_3_volume_encrypted" {
  type = bool
  default = false
}

variable "server_group_3_volume_kms_key_id" {
  type = string
  default = null
}

variable "server_group_3_volume_count" {
  type = number
  default = 1
}
