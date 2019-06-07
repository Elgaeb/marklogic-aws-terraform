variable "access_key" {
  type    = "string"
  default = ""
}

variable "secret_key" {
  type    = "string"
  default = ""
}

variable "create_vpc" {
  description = "Set to true to create a new VPC, false to use an existing VPC."
  default = false
}

variable "server_groups" {
  type = "list"
  default = [
    {
      subnet_index = 0
      node_count = 1
      instance_type = "t3.small"
      volume_size = 10
      volume_type = "gp2"
      volume_iops = null
      volume_count = 1
    }
  ]
}