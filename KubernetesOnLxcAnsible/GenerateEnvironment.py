#!/usr/bin/env python

import yaml
import lxc

with open("playbooks/vars/containers.yaml") as f:
   obj=yaml.load(f, Loader=yaml.FullLoader)

print("[controller_container]")
for c in obj['controller_container']:
   container=lxc.Container(c)
   controller_ip = container.get_ips(timeout=5)[0]
   print("%s ansible_user=ubuntu ansible_ssh_pass=ubuntu ansible_become_pass=ubuntu type=controller" %
     (controller_ip))
print()

print("[worker_containers]")
for c in obj['worker_containers']:
   container=lxc.Container(c)
   print("%s ansible_user=ubuntu ansible_ssh_pass=ubuntu ansible_become_pass=ubuntu type=worker" %
     (container.get_ips(timeout=5)[0]))
print()

print("[all:children]")
print('controller_container')
print('worker_containers')
print()
print("[all:vars]")
print("controller_ip=%s" % controller_ip)
print("nfs-server=%s" % controller_ip)
