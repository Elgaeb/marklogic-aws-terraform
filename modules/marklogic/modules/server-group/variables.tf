variable "marklogic_admin_password" {
  type = "string"
}

variable "enable" {
  type    = "string"
  default = true
}

variable "group_number" {
  type    = "string"
  default = 1
}

variable "availability_zone" {
}

variable "node_count" {
  type    = "string"
  default = 1
}

variable "subnet_id" {
  type    = "string"
}

variable "cluster_name" {
  type    = "string"
}

variable "cluster_id" {
  type    = "string"
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

variable "licensee" {
  type    = "string"
  default = "none"
}

variable "licensee_key" {
  type    = "string"
  default = "none"
}

variable "marklogic_version" {
  type    = "string"
  default = "9.0-9.1"
}

variable "instance_type" {
  type    = "string"
  default = "r5.4xlarge"
}

variable "key_name" {
  description = "name of the key used to access the EC2 instances"
  type        = "string"
  default     = ""
}

variable "instance_security_group_id" {

}

variable "instance_host_profile_name" {

}

variable "aws_region" {
  description = "EC2 Region for the VPC"
  default     = "us-east-1"
}

variable "load_balancer_names" {
  type = "list"
}

variable "node_manager_sns_topic_arn" {
  type = "string"
}

variable "node_manager_exec_role_arn" {
  type = "string"
}

variable "create_after" {
  type = "list"
  default = []
}