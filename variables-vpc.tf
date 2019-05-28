variable "bastion_instance_type" {
  description = "Amazon EC2 instance type for the bastion instances"
  default = "t3.nano"
}

variable "bastion_key_name" {
  description = "name of the key used to access the bastion EC2 instances"
  type        = "string"
  default     = ""
}

