variable "vpc_cidr" {
  type    = "string"
  default = ""
}

variable "vpc_id" {
  type = "string"
  default = ""
}

variable "public_subnet_ids" {
  type = "list"
  default = []
}

variable "private_subnet_ids" {
  type = "list"
  default = []
}
