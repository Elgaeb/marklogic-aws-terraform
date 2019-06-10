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

marklogic_version = "9.0-9.1"
licensee     = "none"
licensee_key = "none"

# The next 4 variables are only used if you are placing the MarkLogic cluster in a new VPC
# i.e. create_vpc is set to false
vpc_cidr = "10.0.0.0/16"
vpc_id = "vpc-224466"
public_subnet_ids = [
  "subnet-12345",
  "subnet-23456",
  "subnet-34567",
]
private_subnet_ids = [
  "subnet-09876",
  "subnet-98765",
  "subnet-87654",
]

# Set create_vpc to true to create a new VPC for the MarkLogic cluster
# When set to false, you need to specify vpc_cidr, vpc_id, public_subnet_ids, and public_subnet_ids.
create_vpc = false

server_group_0_subnet_index = 0
server_group_0_node_count = 3
server_group_0_instance_type = "r4.8xlarge"
server_group_0_volume_size = 3584
server_group_0_volume_count = 2
server_group_0_volume_type = "gp2"

server_group_1_subnet_index = 1
server_group_1_node_count = 3
server_group_1_instance_type = "r4.8xlarge"
server_group_1_volume_size = 3584
server_group_1_volume_count = 2
server_group_1_volume_type = "gp2"

server_group_2_subnet_index = 2
server_group_2_node_count = 3
server_group_2_instance_type = "r4.8xlarge"
server_group_2_volume_size = 3584
server_group_2_volume_count = 2
server_group_2_volume_type = "gp2"

expose_administration_console = false
enable_data_explorer = false
enable_data_hub = true
enable_grove = false
enable_marklogic = true
enable_ops_director = false
enable_odbc = true

bastion_enable = false

ingestion_enable = true
ingestion_instance_type = "c4.4xlarge"
ingestion_tenancy = "default"
ingestion_root_block_device_size = 8
ingestion_root_block_device_type = "gp2"
ingestion_volume_size = [ 15360, 15360 ]
ingestion_volume_type = "gp2"
ingestion_ebs_encrypted = true
