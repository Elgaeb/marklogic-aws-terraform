#!/bin/bash

rpm -i /home/ec2-user/MarkLogicConverters-${marklogic_version}.x86_64.rpm

MARKLOGIC_ADMIN_USERNAME=admin
MARKLOGIC_ADMIN_PASSWORD=m@rk^.^logic
MARKLOGIC_CLUSTER_NAME=${cluster_name}
MARKLOGIC_EBS_VOLUME=:${volume_size}::${volume_type}::,*
%{ if volume_count > 1 }MARKLOGIC_EBS_VOLUME1=:${volume_size}::${volume_type}::,*%{ endif }
%{ if volume_count > 2 }MARKLOGIC_EBS_VOLUME2=:${volume_size}::${volume_type}::,*%{ endif }
%{ if volume_count > 3 }MARKLOGIC_EBS_VOLUME3=:${volume_size}::${volume_type}::,*%{ endif }
%{ if volume_count > 4 }MARKLOGIC_EBS_VOLUME4=:${volume_size}::${volume_type}::,*%{ endif }
%{ if volume_count > 5 }MARKLOGIC_EBS_VOLUME5=:${volume_size}::${volume_type}::,*%{ endif }
%{ if volume_count > 6 }MARKLOGIC_EBS_VOLUME6=:${volume_size}::${volume_type}::,*%{ endif }
%{ if volume_count > 7 }MARKLOGIC_EBS_VOLUME7=:${volume_size}::${volume_type}::,*%{ endif }
%{ if volume_count > 8 }MARKLOGIC_EBS_VOLUME8=:${volume_size}::${volume_type}::,*%{ endif }
%{ if volume_count > 9 }MARKLOGIC_EBS_VOLUME9=:${volume_size}::${volume_type}::,*%{ endif }
MARKLOGIC_NODE_NAME=${node}
MARKLOGIC_CLUSTER_MASTER=${master}
MARKLOGIC_LICENSEE=${licensee}
MARKLOGIC_LICENSE_KEY=${licensee_key}
MARKLOGIC_LOG_SNS=
MARKLOGIC_MDB_TYPE=ddb
MDB_NODE_NAME=${node}
MDB_NAME=${cluster_name}