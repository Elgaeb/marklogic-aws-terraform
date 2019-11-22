variable "enable" {
  type    = string
  default = true
}

variable "group_number" {
  type    = string
  default = 1
}

variable "availability_zone" {
}

variable "node_count" {
  type    = string
  default = 1
}
variable "cluster_name" {
  type    = string
}

variable "cluster_id" {
  type    = string
}

variable "volume_size" {
  default = 10
}

variable "volume_type" {
  default = "gp2"
}

variable "volume_iops" {
  default = null
}

variable "volume_encrypted" {
  default = false
}

variable "volume_kms_key_id" {
  default = null
}

variable "volume_count" {
  default = 1
}

variable "volume_number" {
  default = 0
}