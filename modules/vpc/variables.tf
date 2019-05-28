variable "access_key" {
  type    = "string"
  default = ""
}

variable "secret_key" {
  type    = "string"
  default = ""
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

variable "vpc_name" {
  type    = "string"
}

variable "vpc_cidr" {
  type    = "string"
  default = "10.0.0.0/16"
}

variable "number_of_zones" {
  default = 3
}

variable "private_subnet_cidrs" {
  type = "list"

  default = [
    "10.0.0.0/23",
    "10.0.32.0/23",
    "10.0.64.0/23",
  ]
}

variable "public_subnet_cidrs" {
  type = "list"

  default = [
    "10.0.96.0/23",
    "10.0.128.0/23",
    "10.0.160.0/23",
  ]
}