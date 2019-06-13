# REQUIRED: Add your AWS access key and secret key
access_key         = ""
secret_key         = ""
key_name           = ""
bastion_key_name   = ""
ingestion_key_name = ""

# REQUIRED: Name your clusted and create a random id for it.
# The id should be unique within the VPC, a UUID make a good id, e.g. `uuidgen`
cluster_name   = "your-cluster-name"
cluster_id     = "random-string"

# The marklogic version to use and license information. If both licensee and license_key are set to "none" this cluster
# will use a developer license. If the are both set to "" (the empty string) it will use MarkLogic Enterprise Edition.
marklogic_version = "9.0-9.3"
licensee     = "none"
licensee_key = "none"
marklogic_admin_password = "admin"

# Create a new VPC for the cluster.
# When set to false, you need to specify vpc_cidr, vpc_id, public_subnet_ids, and public_subnet_ids.
create_vpc = false

# The region and availability zones your VPC resides in. When using an existing VPC, the availability zones must
# correspond to the private_subnet_ids and public_subnet_ids.
# You should have the same number of availability zones as number_of_zones.
aws_region      = "us-east-1"
azs             = [ "us-east-1a", "us-east-1b", "us-east-1c" ]
number_of_zones = 3

# The next 4 variables are only used if you are placing the MarkLogic cluster in an existing VPC
# i.e. create_vpc is set to false
vpc_cidr = "10.0.0.0/16"
vpc_id = "vpc-12345"

# The public subnets. These should be in the availability zones specified in azs. Only when using an existing VPC.
public_subnet_ids = [
  "subnet-11111",
  "subnet-22222",
  "subnet-33333",
]
# The private subnets. These should be in the availability zones specified in azs. Only when using an existing VPC.
private_subnet_ids = [
  "subnet-44444",
  "subnet-55555",
  "subnet-66666",
]

# 6 server groups are supported (server_group_[0...5]_...) which can be configured independantly.

# The index of the subnet that the server group will reside in. This is either an index into the private_subnet_ids
# array (when using an existing VPC) or will be a subnet in the availability zone defined by the index into azs when
# creating a new VPC.
server_group_0_subnet_index = 0
# The number of nodes in this server group
server_group_0_node_count = 1
# The instance type of the server group. All servers in the group will share the same instance type.
server_group_0_instance_type = "t3.small"
# The size of the EBS volume to attach to the instance. This can be a single number or an array. If the value is an
# array and server_group_n_volume_count is greater than 1, then EBS volumes with the corresponding sizes will be
# created. If this is a single number and server_group_n_volume_count is greater than 1 all volumes will be the same
# size.
server_group_0_volume_size = 600
# The type of EBS volume, e.g. "gp2" or "io1"
server_group_0_volume_type = "gp2"
# The provisioned IOPS, only used when the volume type is "io1"
# server_group_0_volume_iops = 100
# The number of EBS volumes to attach to the instances.
//server_group_0_volume_count = 1
# Whether to use EBS encryption for the provisioned volumes.
server_group_0_volume_encrypted = false

# Expose the administration console through the external load balancer. The administration console will always be
# exposed through the internal load balancer.
expose_administration_console = false
# Open the ports for MarkLogic Ops Director and expose it on the load balancers.
enable_ops_director = false
# Open the ports for MarkLogic Data Explorer and expose it on the load balancers.
enable_data_explorer = false
# Open the ports for MarkLogic Data Hub and expose it on the load balancers.
enable_data_hub = true
# Open the ports for MarkLogic Grove and expose it on the load balancers.
enable_grove = false
# Open the ports for an ODBC server and expose it on the load balancers.
enable_odbc = true

# For internal use, this should never be set to false, doing so will destroy all your data.
enable_marklogic = true

# Whether to create an external, internet-facing load balancer
enable_external_load_balancer = true

# Define the parameters for a bastion server. This server will reside on a public subnet and be accessible.
bastion_enable = true
bastion_instance_type = "t3.nano"
bastion_tenancy = "default"
bastion_remote_access_cidr_blocks = [
  "0.0.0.0/0",
]
bastion_egress_cidr_blocks = [
  "0.0.0.0/0",
]

# Define the parameters for an ingestion server. This server will reside on a private subnet.
ingestion_enable = false
ingestion_instance_type = "t3.nano"
ingestion_tenancy = "default"
ingestion_root_block_device_size = 8
ingestion_root_block_device_type = "gp2"
ingestion_volume_size = 100
ingestion_volume_type = "gp2"
ingestion_ebs_encrypted = false
