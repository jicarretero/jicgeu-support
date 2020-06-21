#!/bin/bash -e

# Destroy previous containers
ansible-playbook  -i inventory playbooks/CreateLxcContainers.yaml -e state=absent

# Create new containers and build inventory
ansible-playbook  -i inventory playbooks/CreateLxcContainers.yaml  
sudo ./GenerateEnvironment.py | tee container_inventory

# Install docker and Kubernetes Dockers in the nodes
ansible-playbook  -i container_inventory playbooks/InstallDockers.yaml
ansible-playbook  -i container_inventory playbooks/ConfigureKubernetes.yaml

# Puedo pasar a los 2 últimos playbooks " -e host=10.0.3.7" para añadir
# nuevos Workers.
