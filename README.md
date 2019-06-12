# MarkLogic Cluster

These Terraform scripts will create a managed MarkLogic cluster either inside of an existing VPC or in a new VPC. The cluster is configured so that the instances are inside of an autoscaling group. Additional functionality is provided that will rejoin a server to the cluster when the autoscaling group detects a terminated instance and creates a new instance.

The cluster is configurable to span multiple availability zones, with a configurable number of instances per availability zone.

Licensing, either Essential Enterprise or BYOL is also configurable.

## Requirements

* Terraform 0.12+
* AWS Credentials with an access key and secret key
    * You will need a comprehensive set of permissions to run these scripts, including the ability to create IAM roles
* An SSH key associated with your AWS account.

## TL;DR

1. Copy `sample.tfvars`  to `terraform.tfvars`
2. Follow the guidance in `terraform.tfvars` to set the proper values. Set `expose_administration_console` to `true`.
3. Run the following commands
    ```bash
    terraform init
    terraform apply 
    ```
    
The previous command will create output similar to:

```hcl-terraform
bastion = [
  {
    "private_dns" = "ip-10-0-96-41.ec2.internal"
    "private_ip_address" = "10.0.96.41"
    "public_dns" = "ec2-54-167-34-23.compute-1.amazonaws.com"
    "public_ip_address" = "54.167.34.23"
  },
]
ingestion = [
  {
    "private_dns" = "ip-10-0-0-238.ec2.internal"
    "private_ip_address" = "10.0.0.238"
    "public_dns" = ""
    "public_ip_address" = ""
  },
]
marklogic = [
  {
    "instance_security_group_id" = "sg-0fb1f2349f65a15b6"
    "internal_url" = "http://ml-demo-cluster-internal-elb-121195148.us-east-1.elb.amazonaws.com:8001"
    "managed_eni_private_dns" = [
      [
        "ip-10-0-0-79.ec2.internal",
      ],
    ]
    "managed_eni_private_ips" = [
      [
        "10.0.0.79",
      ],
    ]
    "url" = "http://ml-demo-cluster-external-elb-627899900.us-east-1.elb.amazonaws.com:8001"
  },
]
private_subnet_ids = [
  "subnet-005959f9c031f3788",
]
public_subnet_ids = [
  "subnet-076264cbc0b9c5f2b",
]
vpc = [
  {
    "default_security_group_id" = "sg-05a05d377e8e957ac"
    "nat_ip" = "3.215.48.119"
    "private_subnet_ids" = [
      "subnet-005959f9c031f3788",
    ]
    "public_subnet_ids" = [
      "subnet-076264cbc0b9c5f2b",
    ]
    "vpc_cidr_block" = "10.0.0.0/16"
    "vpc_id" = "vpc-08558c6fad5ce588f"
  },
]
vpc_cidr = 10.0.0.0/16
vpc_id = vpc-08558c6fad5ce588f
```

To access the administration col=nsole, visit the url specified by `marklogic.url`, you can change the port to access the other services (e.g. 8000 for query console.)

If you want to SSH to your marklogic servers, you will need to first SSH to the bastino server using the command `ssh ec2-user@ec2-54-167-34-23.compute-1.amazonaws.com`, replacing the server with the appropriate dns name or ip for you bastion server. You also need to add your SSH key using the `ssh-add` command, e.g. `ssh-add ~/.ssh/my-key.pem`

When you are finished, you can run `terraform destroy` to permanently remove the cluster (and vpc.)    
