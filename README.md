# MarkLogic Cluster

These Terraform scripts will create a managed MarkLogic cluster inside of an existing
VPC. The cluster is configured so that the instances are inside of an autoscaling group.
Additional functionality is provided that will rejoin a server to the cluster when
the autoscaling group detects a terminated instance and creates a new instance.

The cluster is configurable to span multiple availability zones, with a configurable number
of instances per availability zone.

Licensing, either Essential Enterprise or BYOL is also configurable.

## Variables

### Required Variables

| Variable | Description | Default |
|----------|-------------|---------|
| access_key | The AWS access key | |
| secret_key | The AWS secret key. | |
| key_name | The key to use for ssh access to the MarkLogic instances | |
| cluster_name | The name of the cluster, this will be used to tag the managed ENI resources | |
| cluster_id | The ID of the cluster. This will be used to tag the managed ENI resources and should be unique. It is recommended to use a UUID. | |
| bastion_key_name | The key to use for ssh access to the bastion instances | |
| ingestion_key_name | The key to use for ssh access to the ingestion instance | |

### Optional Variables

*NEVER SET enable_marklogic TO false, it will destroy the MarkLogic instance and ALL data*


| Variable | Description | Default |
|----------|-------------|---------|
| marklogic_version | The version of MarkLogic to use | 9.0-9.1 |
| licensee_key | The MarkLogic license key, leave blank for Essential Enterprise or "none" for developer. | "none" |
| licensee | The MarkLogic licensee, leave blank for Essential Enterprise or "none" for developer. | "none" |
| aws_region | The AWS region of the VPC. | "us-east-1" |
| instance_type | The type of instance to use for MarkLogic nodes. | "r3.4xlarge" |
| volume_size | The size of the EBS volumes to use for MarkLogic data, in GiB | 10 |
| volume_type | The EBS volume type: standard, gp2, or io1. | "gp2" |
| volume_iops | For io1 volumes only, the provisioned IOP (PIOP) | |
| number_of_zones | The number of availability zones to use for MarkLogic nodes. | 3 |
| nodes_per_zone | The number of MarkLogic nodes to create per availability zone. | 1 |
| azs | A list of availability zones to use. This must be the same length as number_of_zones. | [ "us-east-1a", "us-east-1b", "us-east-1c" ] |
| enable_ops_director | If true, create the required security rules for ops director. | false |
| enable_data_hub | If true, create the required security rules for MarkLogic Data Hub. | true |
| expose_administration_console | If true, expose the administration, query console, ops director (if enabled), and management servers through the load balancer. | false |
| enable_external_access | Whether to enable external access to the cluster through the ELB. You should set this to false during an upgrade. | true |
| enable_marklogic | Whether to create the MarkLogic components. Setting this to false will destroy all of the MarkLogic security groups, instances, and volumes. It will not destroy the ELBs. | true |
| bastion_instance_type | The type of instance to use for the bastion instance | t3.nano |
| ingestion_instance_type | The type of instance to use for the ingestion instance | c5.4xlarge |

```bash
$ terraform init
$ terraform plan
```
