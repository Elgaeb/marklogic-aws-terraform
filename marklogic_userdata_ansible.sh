#!/bin/bash

# install git and ansible (to run an ansible playbook using ansible-pull)
yum install -y git python3
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user

~/.local/bin/pip install ansible

# Copy the git keys from S3
aws s3 cp ${ansible_git_ssh_key} /root/.ssh/ansible_git
chmod 400 /root/.ssh/ansible_git

# Run the ansible playbook using ansible-pull
/usr/local/bin/ansible-pull \
    -d /root/playbooks \
    -i /root/playbooks/${ansible_inventory_file} \
    -U ${ansible_pull_url} \
    -C ${ansible_pull_branch} \
    --accept-host-key \
    --private-key=/root/.ssh/ansible_git \
    ${ansible_playbook_file}

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