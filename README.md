# MarkLogic Cluster

These Terraform scripts will create a managed MarkLogic cluster either inside of an existing VPC or in a new VPC. The cluster is configured so that the instances are inside of an autoscaling group. Additional functionality is provided that will rejoin a server to the cluster when the autoscaling group detects a terminated instance and creates a new instance.

The cluster is configurable to span multiple availability zones, with a configurable number of instances per availability zone.

Licensing, either Essential Enterprise or BYOL is also configurable.

## Pre-requirements

* [Terraform](https://www.terraform.io) 0.12+
* AWS Credentials with an access key and secret key
    * You will need a comprehensive set of permissions to run these scripts, including the ability to create IAM roles
* An SSH key associated with your AWS account.
* You need to have subscribed to MarkLogic in the AWS Marketplace. You can do that from [here](https://aws.amazon.com/marketplace/pp/B072Z536VB?ref=cns_srchrow).

# What Is It?

These scripts will create and manage a cluster of MarkLogic servers in an AWS VPC.

Some of the features of the scripts include:

* Optionally can create a new VPC in your AWS account, or use an existing VPC.
* Create up to 6 groups of nodes. Each group can contain up to 200 homogeneous nodes on a single VPC subnet. _(TODO: expand this concept so that a single group can span multiple availability zones)_
* Optionally create a [bastion host](https://en.wikipedia.org/wiki/Bastion_host) for the VPC.
* Optionally create an ingestion server, a general purpose instance inside the VPC for performing tasks such as [MLCP](https://developer.marklogic.com/products/mlcp) ingestion.

# Configuration

All configuration can be achieved through [input variables](https://learn.hashicorp.com/terraform/getting-started/variables.html), e.g. a `terraform.tfvars` file. A `sample.tfvars` file is include to demonstrate the creation of a small cluster in a new VPC.

## General Variables

| Variable | Description | Default Value |
|----------|-------------|---------------|
| access_key | The access key for the AWS account | |
| secret_key |  |  |
| cluster_name |  |  |
| cluster_id |  |  |
| marklogic_version |  |  |
| licensee |  |  |
| licensee_key |  |  |

## VPC Variables

| Variable | Description | Default Value |
|----------|-------------|---------------|
| create_vpc |  |  |
| aws_region |  |  |
| azs |  |  |
| number_of_zones |  |  |

### Existing VPC Variables

| Variable | Description | Default Value |
|----------|-------------|---------------|
| vpc_cidr |  |  |
| vpc_id |  |  |
| public_subnet_ids |  |  |
| private_subnet_ids |  |  |

## MarkLogic Server Group Variables

| Variable | Description | Default Value |
|----------|-------------|---------------|
| server_group_0_subnet_index |  |  |
| server_group_0_node_count |  |  |
| server_group_0_instance_type |  |  |
| server_group_0_volume_size |  |  |
| server_group_0_volume_type |  |  |
| server_group_0_volume_iops |  |  |
| server_group_0_volume_count |  |  |
| server_group_0_volume_encrypted |  |  |


## MarkLogic Variables

| Variable | Description | Default Value |
|----------|-------------|---------------|
| expose_administration_console |  |  |
| enable_ops_director |  |  |
| enable_data_explorer |  |  |
| enable_data_hub |  |  |
| enable_grove |  |  |
| enable_odbc |  |  |
| enable_marklogic |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |

## Bastion Host Variables

| Variable | Description | Default Value |
|----------|-------------|---------------|
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |

## Ingestion Host Variables

| Variable | Description | Default Value |
|----------|-------------|---------------|
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |

# Upgrading MarkLogic

Upgrading marklogic is fairly straightforward:

1. In your Terraform variables, change the version of MarkLogic to de desired, supported version, e.g. `marklogic_version = "9.0-9.3"`. Currently supported versions include:
    * 9.0-8
    * 9.0-9.1
    * 9.0-9.3
2. Run `terraform apply`
3. For a rolling upgrade (and as a good practice) terminate other nodes one by one starting with the node that has the Security database. They will come up and reconnect without any UI interaction.
4. Go to 8001 port on any new instance where an upgrade prompt should be displayed.
5. Click OK and wait for the upgrade to complete on the instance.

If you have modified the Terraform scripts, upgrading should follow the same process, but you will need to copy the `modules/marklogic/modules/server-group/variables-amis.tf` file to your modified project to get the AMI ids of the new MarkLogic AMIs.