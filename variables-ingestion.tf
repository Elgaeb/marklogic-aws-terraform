variable "ingestion_instance_type" {
  description = "Amazon EC2 instance type for the ingestion instances"
  default = "c5.4xlarge"
}

variable "ingestion_key_name" {
  description = "name of the key used to access the ingestion EC2 instances"
  type        = "string"
  default     = ""
}

variable "ingestion_volume_size" {
  type = "list"
  default = []
}

variable "ingestion_volume_type" {
  type = "string"
  default = "gp2"
}

variable "ingestion_tenancy" {
  description = "The tenancy of the ingestion instance: default, dedicated, host."
  type = "string"
  default = "default"
}

variable "ingestion_ebs_encrypted" {
  default = true
}

variable "ingestion_root_block_device_size" {
  default = 8
}

variable "ingestion_root_block_device_type" {
  default = "gp2"
}

variable "ingestion_enable" {
  description = "Whether or not to create this instance"
  default = true
}

