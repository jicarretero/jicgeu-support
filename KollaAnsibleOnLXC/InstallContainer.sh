ansible-playbook  -i inventory playbooks/CreateLxcContainers.yaml -e state=absent


for a in 172.23.32.2 172.23.32.5 172.23.32.6 172.23.32.7; do ssh-keygen -f /home/jicg/.ssh/known_hosts -R $a ; done
for a in 172.23.16.2 172.23.16.5 172.23.16.6 172.23.16.7; do ssh-keygen -f /home/jicg/.ssh/known_hosts -R $a ; done
ansible-playbook  -i inventory playbooks/CreateLxcContainers.yaml
ansible-playbook  -i containers_inventory playbooks/PrepareContainers.yaml

