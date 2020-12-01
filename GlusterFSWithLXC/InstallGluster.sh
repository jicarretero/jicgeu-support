#!/bin/bash -e

# Destroy previous containers
ansible-playbook  -i inventory playbooks/CreateLxcContainers.yaml -e state=absent

# Create new containers and build inventory
ansible-playbook  -i inventory playbooks/CreateLxcContainers.yaml  
sudo ./GenerateEnvironment.py | tee gluster_inventory

# Install glusterd in every node
ansible-playbook  -i container_inventory playbooks/nodes.yaml

# Stop the Gluster cluster
# ansible-playbook  -i inventory playbooks/CreateLxcContainers.yaml -e state=stopped

# Restart the Gluster cluster
# ansible-playbook  -i inventory playbooks/CreateLxcContainers.yaml -e state=started

