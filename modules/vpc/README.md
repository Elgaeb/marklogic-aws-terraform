MarkLogic Cluster and VPC
-------------------------
These scripts will configure VPC that can be used with a MarkLogic cluster.

Configuration
-------------
* access_key
    * The AWS access key
* secret_key
    * The matching AWS secret key.
* vpc_name
    * The name of the vpc, this will be used to tag resources
* region
    * The desired AWS region
* number_of_zones
    * The number of availability zones to create subnets for
* azs
    * A list of availability zones to use. This must be the same length as number_of_zones
* vpc_cidr
    * The CIDR block to use for the VPC
* private_subnet_cidrs
    * The CIDR blocks to use for the private subnet(s). This must be the same length as
      number_of_zones
* public_subnet_cidrs
    * The CIDR blocks to use for the public subnet(s). This must be the same length as
      number_of_zones

Example terraform.tfvars
------------------------
```
access_key = "..."
secret_key = "..."
key_name = "aha_marklogic_consolidation"

vpc_name = "marklogic-edw-dev"

region          = "us-east-1"
azs             = [ "us-east-1a", "us-east-1b", "us-east-1c" ]
number_of_zones = 3
```