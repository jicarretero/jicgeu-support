#!/bin/bash -e

# Destroy previous containers
ansible-playbook  -i inventory playbooks/CreateLxcContainers.yaml -e state=absent

# Create new containers and build inventory
ansible-playbook  -i inventory playbooks/CreateLxcContainers.yaml  
sudo ./GenerateEnvironment.py | tee container_inventory

# Install docker and Kubernetes Dockers in the nodes
ansible-playbook  -i container_inventory playbooks/InstallDockers.yaml
ansible-playbook  -i container_inventory playbooks/SetServiceMKNOD.yaml
ansible-playbook  -i container_inventory playbooks/ConfigureKubernetes.yaml
ansible-playbook  -i container_inventory playbooks/reconfigure_kubectl.yaml

# I can run the last 2 playbooks the param " -e host=10.0.3.7" to add new worker nodes.

# Stop the containers:
# ansible-playbook  -i inventory playbooks/CreateLxcContainers.yaml -e state=stopped

# Restart the containers:
# ansible-playbook  -i inventory playbooks/CreateLxcContainers.yaml -e state=started

