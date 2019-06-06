variable "vpc_cidr" {
  type    = "string"
  default = null
}

variable "vpc_id" {
  type = "string"
  default = null
}

variable "public_subnet_ids" {
  type = "list"
  default = []
}

variable "private_subnet_ids" {
  type = "list"
  default = []
}
