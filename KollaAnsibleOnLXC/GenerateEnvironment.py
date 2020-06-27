#!/usr/bin/env python

import yaml

with open("playbooks/vars/containers.yaml") as f:
   obj=yaml.load(f, Loader=yaml.FullLoader)

print("[controller_container]")
for c in obj['controller_container']:
   print("%s ansible_user=ubuntu ansible_ssh_pass=ubuntu ansible_become_pass=ubuntu type=controller ip1=%s ip2=%s" %
      (c['ip2'].replace("/24",""),c['ip1'],c['ip2']))
print()

print("[compute_containers]")
for c in obj['compute_containers']:
   print("%s ansible_user=ubuntu ansible_ssh_pass=ubuntu ansible_become_pass=ubuntu type=compute ip1=%s ip2=%s" %
      (c['ip2'].replace("/24",""),c['ip1'],c['ip2']))
print()

print("[all:children]")
print('controller_container')
print('compute_containers')
