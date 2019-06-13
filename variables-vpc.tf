variable "vpc_cidr" {
  type    = "string"
  default = "10.0.0.0/16"
}

# Only used with existing VPCs
variable "vpc_id" {
  type = "string"
  default = null
}

# Only used with existing VPCs
variable "public_subnet_ids" {
  type = "list"
  default = []
}

# Only used with existing VPCs
variable "private_subnet_ids" {
  type = "list"
  default = []
}

# Only used with new VPCs
variable "newbits_per_subnet" {
  default = 7
}
