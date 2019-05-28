#!/bin/bash

rpm -i /home/ec2-user/MarkLogicConverters-${marklogic_version}.x86_64.rpm

MARKLOGIC_ADMIN_USERNAME=admin
MARKLOGIC_ADMIN_PASSWORD=m@rk^.^logic
MARKLOGIC_CLUSTER_NAME=${cluster_name}
MARKLOGIC_EBS_VOLUME=${ebs_volume},:${volume_size}::${volume_type}::,*
MARKLOGIC_NODE_NAME=${node}
MARKLOGIC_CLUSTER_MASTER=${master}
MARKLOGIC_LICENSEE=${licensee}
MARKLOGIC_LICENSE_KEY=${licensee_key}
MARKLOGIC_LOG_SNS=
MARKLOGIC_MDB_TYPE=ddb
MDB_NODE_NAME=${node}
MDB_NAME=${cluster_name}