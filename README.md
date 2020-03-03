# What Is It?

These scripts will create and manage a cluster of MarkLogic servers in an AWS VPC.

Some of the features of the scripts include:

* Optionally can create a new VPC in your AWS account, or use an existing VPC.
* Create up to 6 groups of nodes. Each group can contain up to 200 homogeneous nodes on a single VPC subnet. _(TODO: expand this concept so that a single group can span multiple availability zones)_
* Optionally create a [bastion host](https://en.wikipedia.org/wiki/Bastion_host) for the VPC.
* Optionally create an ingestion server, a general purpose instance inside the VPC for performing tasks such as [MLCP](https://developer.marklogic.com/products/mlcp) ingestion.

# Enabling a MarkLogic Server for EC2 AMI

These scripts use a MarkLogic-supplied AMIs that are available in [AWS MarketPlace](https://aws.amazon.com/marketplace). To enable your MarkLogic AMI, do the following:

1. Go to the [AWS MarketPlace](https://aws.amazon.com/marketplace).
2. Search for MarkLogic.
3. In the MarkLogic product page, click the Accept Terms button.

# Pre-requirements

* [Terraform](https://www.terraform.io) v0.12.16+
* AWS Credentials with an access key and secret key
    * You will need a comprehensive set of permissions to run these scripts, including the ability to create IAM roles
* An SSH key associated with your AWS account.
* You need to have enabled a MarkLogic AMI, as described above.

# Configuration

All configuration can be achieved through [input variables](https://learn.hashicorp.com/terraform/getting-started/variables.html), e.g. a `terraform.tfvars` file. A `sample.tfvars` file is include to demonstrate the creation of a small cluster in a new VPC.

## General Variables

| Variable | Description | Default Value |
|----------|-------------|---------------|
| access_key | The access key for the AWS account | |
| secret_key | The secret key for the AWS account |  |
| cluster_name | A name for the cluster. This should be recognizable and unique.  |  |
| cluster_id | An id for the cluster. This should be a unique value, such as a UUID. |  |
| marklogic_version | The version of MarkLogic to use. Currently supports 9.0-9.1 and 9.0-9.3 | 9.0-9.3 |
| licensee | The licensee. If both `licensee` and `license_key` are `""` (the blank string), Enterprise Edition will be used. Set this to `"none"` to use a developer license. | `"none"` |
| licensee_key | The license key. If both `licensee` and `license_key` are `""` (the blank string), Enterprise Edition will be used. Set this to `"none"` to use a developer license.  | `"none"` |

## VPC Variables

| Variable | Description | Default Value |
|----------|-------------|---------------|
| create_vpc | Create a new VPC for the MarkLogic cluster. | false |
| aws_region | The [AWS region](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html) to use for the VPC. If using an existing VPC, this must match the region the VPC resides in. | us-east-1 |
| azs | The [availability zones](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html) to put the MarkLogic server groups into. There must be the same number of availability zones specified as `number_of_zones`. | [ "us-east-1a", "us-east-1b", "us-east-1c" ] |
| number_of_zones | The number subnets to create. This should be the same as the legth of the `azs` array.  | 3 |

### Existing VPC Variables

| Variable | Description | Default Value |
|----------|-------------|---------------|
| vpc_cidr | The CIDR block for the existing VPC. |  |
| vpc_id | The AWS ID of the existing VPC, e.g. vpc-12345. |  |
| public_subnet_ids | An array of AWS IDs for the public subnets of the existing VPC. There should be the same number of subnets as `number_of_zones`. |  |
| private_subnet_ids | An array of AWS IDs for the private subnets of the existing VPC. There should be the same number of subnets as `number_of_zones`. |  |

### New VPC Variables

| Variable | Description | Default Value |
|----------|-------------|---------------|
| vpc_cidr | The CIDR block for the VPC. | 10.0.0.0/16 |
| newbits_per_subnet | The number of additional bits with which to extend the prefix. For example, if given a prefix ending in /16 and a newbits value of 4, the resulting subnet address will have length /20.[^1] | 7 |

## MarkLogic Server Group Variables

| Variable | Description | Default Value |
|----------|-------------|---------------|
| server_group_[0..5]_subnet_index |  | 0 |
| server_group_[0..5]_node_count |  | 0 |
| server_group_[0..5]_instance_type |  | t3.small |
| server_group_[0..5]_volume_size |  | 10 |
| server_group_[0..5]_volume_type |  | gp2 |
| server_group_[0..5]_volume_iops |  | 100 |
| server_group_[0..5]_volume_count |  | false |
| server_group_[0..5]_volume_encrypted |  | false |
| server_group_[0..5]_volume_kms_key_id |  | |
| server_group_[0..5]_volume_count |  | 1 |


## MarkLogic Variables

| Variable | Description | Default Value |
|----------|-------------|---------------|
| marklogic_admin_password | The initial password for the administration account in MarkLogic | `"admin"` |
| expose_administration_console |  | false |
| enable_ops_director |  | false |
| enable_data_explorer |  | false |
| data_explorer_port |  | 7777 |
| enable_data_hub |  | true |
| enable_grove |  | false |
| grove_port |  | 8063 |
| enable_odbc |  | false |
| odbc_port |  | 5432 |
| enable_marklogic |  | true |
| enable_external_load_balancer |  | true |

## Bastion Host Variables

| Variable | Description | Default Value |
|----------|-------------|---------------|
| bastion_instance_type |  | t3.nano |
| bastion_key_name |  |  |
| bastion_remote_access_cidr_blocks |  | 0.0.0.0/0 |
| bastion_egress_cidr_blocks |  | 0.0.0.0/0 |
| bastion_tenancy |  | default |
| bastion_root_block_device_size |  | 8 |
| bastion_root_block_device_type |  | gp2 |
| bastion_enable |  | true |

## Ingestion Host Variables

| Variable | Description | Default Value |
|----------|-------------|---------------|
| ingestion_instance_type |  | c5.4xlarge |
| ingestion_key_name |  |  |
| ingestion_volume_size |  |  |
| ingestion_volume_type |  | gp2 |
| ingestion_tenancy |  | default |
| ingestion_ebs_encrypted |  | false |
| ingestion_root_block_device_size |  | 8 |
| ingestion_root_block_device_type |  | gp2 |
| ingestion_enable |  | true |

# Upgrading MarkLogic

Upgrading marklogic is fairly straightforward:

1. In your Terraform variables, change the version of MarkLogic to the desired, supported version, e.g. `marklogic_version = "10.0-3"`. Currently supported versions include:
    * 9.0-8
    * 9.0-9.1
    * 9.0-9.3
    * 10.0-3
2. Run `terraform apply`
3. For a rolling upgrade (and as a good practice) terminate other nodes one by one starting with the node that has the Security database. They will come up and reconnect without any UI interaction.
4. Go to 8001 port on any new instance where an upgrade prompt should be displayed.
5. Click OK and wait for the upgrade to complete on the instance.

If you have modified the Terraform scripts, upgrading should follow the same process, but you will need to copy the `modules/marklogic/modules/server-group/variables-amis.tf` file to your modified project to get the AMI ids of the new MarkLogic AMIs.

[^1]: See https://www.terraform.io/docs/configuration/functions/cidrsubnet.html