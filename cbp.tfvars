access_key         = ""
secret_key         = ""
key_name           = ""
bastion_key_name   = ""
ingestion_key_name = ""

# These values should be unique across the VPC
cluster_name   = "trade-analytics"
cluster_id     = "vpgdgi7xCFJ4uKxB"

aws_region      = "us-east-1"
azs             = ["us-east-1a", "us-east-1b", "us-east-1c", ]
number_of_zones = 3
nodes_per_zone  = 3

marklogic_version = "9.0-9.1"
licensee     = "none"
licensee_key = "none"

# The next 4 variables are only used if using the existing-vpc module (i.e. if you are placing the MarkLogic cluster in
# an existing VPC)
vpc_cidr = ""
vpc_id = ""
public_subnet_ids = [ "" ]
private_subnet_ids = [ "" ]

instance_type      = "r4.8xlarge"
volume_size        = 3584
volume_count       = 2

expose_administration_console = false
enable_data_explorer = false
enable_data_hub = true
enable_grove = false
enable_marklogic = true
enable_ops_director = false

bastion_enable = false
bastion_instance_type = "t3.nano"
bastion_tenancy = "default"
bastion_remote_access_cidr_blocks = [
  "0.0.0.0/0",
]
bastion_egress_cidr_blocks = [
  "0.0.0.0/0",
]

ingestion_enable = true
ingestion_instance_type = "c4.4xlarge"
ingestion_tenancy = "default"
ingestion_root_block_device_size = 8
ingestion_root_block_device_type = "gp2"
ingestion_volume_size = [ 15360, 15360 ]
ingestion_volume_type = "gp2"
ingestion_ebs_encrypted = false