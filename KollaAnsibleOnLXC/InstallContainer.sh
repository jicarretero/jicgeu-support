# Destroy every previos LXC Container here
ansible-playbook  -i inventory playbooks/CreateLxcContainers.yaml -e state=absent

# Create the containers again.
ansible-playbook  -i inventory playbooks/CreateLxcContainers.yaml

# Start the containers
ansible-playbook  -i containers_inventory playbooks/PrepareContainers.yaml

# To simply stop the containers use: 
# ansible-playbook  -i inventory playbooks/CreateLxcContainers.yaml -e state=stopped
