variable "licensee" {
  type    = "string"
  default = "none"
}

variable "licensee_key" {
  type    = "string"
  default = "none"
}

variable "marklogic_admin_password" {
  type = "string"
}

variable "marklogic_version" {
  type    = "string"
  default = "9.0-9.1"
}

variable "aws_region" {
  description = "EC2 Region for the VPC"
  default     = "us-east-1"
}

variable "availability_zones" {
  type = "list"

  default = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"
  ]
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

variable "volume_size" {
  description = "The size of the EBS volumes in GB"
  type    = "string"
  default = 10
}

variable "volume_count" {
  description = "The number of volumes per node to use for MarkLogic data"
  type = "string"
  default = 1
}

variable "volume_type" {
  description = "The EBS volume type: standard, gp2, or io1"
  type    = "string"
  default = "gp2"
}

variable "volume_iops" {
  description = "For io1 volumes only, the provisioned IOP (PIOP)"
  type = "string"
  default = "100"
}

variable "volume_encrypted" {
  type = "string"
  default = "false"
}

variable "cluster_name" {
  type    = "string"
}

variable "cluster_id" {
  type    = "string"
}

variable "number_of_zones" {
  default = 3
}

variable "nodes_per_zone" {
  default = 1
}

variable "log_sns_arn" {
  description = "ARN of SNS Topic for logging - optional/advanced"
  type = "string"
  default = ""
}

variable "lambda_package_bucket_base" {
  type    = "string"
  default = "marklogic-lambda-"
}

variable "template_url_base" {
  type    = "string"
  default = "https://s3.amazonaws.com/marklogic-releases"
}

variable "s3_directory_base" {
  type    = "string"
  default = "9.0-9.1"
}

variable "enable_ops_director" {
  description = "If true, create the required security rules for ops director."
  default = false
}

variable "enable_data_hub" {
  description = "If true, create the required security rules for MarkLogic Data Hub."
  default = true
}

variable "enable_grove" {
  description = "If true, create the required security rules for MarkLogic Grove."
  default = true
}

variable "enable_data_explorer" {
  description = "If true, create the required security rules for MarkLogic Data Explorer."
  default = true
}

variable "expose_administration_console" {
  description = "If true, expose the administration, query console, ops director (if enabled), and management servers through the load balancer."
  default = false
}

variable "enable_external_access" {
  description = "Whether to enable external access to the cluster through the ELB. You should set this to false during an upgrade."
  default = true
}

variable "enable_marklogic" {
  description = "Whether to create the MarkLogic components. Setting this to false will destroy all of the MarkLogic security groups, instances, and volumes. It will not destroy the ELB. Default true."
  default = true
}

variable "vpc_cidr" {
  type    = "string"
}

variable "vpc_id" {
  type = "string"
}

variable "public_subnet_ids" {
  type = "list"
}

variable "private_subnet_ids" {
  type = "list"
}

variable "data_explorer_port" {
  type = "string"
  default = "7777"
}

variable "grove_port" {
  type = "string"
  default = "8063"
}

variable "enable_odbc" {
  default = false
}

variable "odbc_port" {
  default = 5432
}

variable "server_groups" {
  type = "list"
//  default = [
//    {
//      subnet_index = 0
//      node_count = 1
//      instance_type = "t3.small"
//      volume_size = 10
//      volume_type = "gp2"
//      volume_iops = null
//      volume_count = 1
//    }
//  ]
}