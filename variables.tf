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

variable "aws_region" {
  description = "EC2 Region for the VPC"
  default     = "us-east-1"
}

variable "azs" {
  type = "list"

  default = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
  ]
}

variable "number_of_zones" {
  default = 3
}

