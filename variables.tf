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
