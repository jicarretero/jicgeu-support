#!/usr/bin/env python

import sys
import yaml
import lxc

def printf(format, *args):
    sys.stdout.write(format % args)


with open("playbooks/vars/containers.yaml") as f:
   obj=yaml.load(f, Loader=yaml.FullLoader)

nodes={}

print("[local]\nlocalhost ansible_connection=local\n")


print("[gluster_containers]")
for c in obj['gluster_containers']:
   container=lxc.Container(c)
   node_ip = container.get_ips(timeout=5)[0]

   nodes[c]=node_ip

   print("%s ansible_user=ubuntu ansible_ssh_pass=ubuntu ansible_become_pass=ubuntu" %
     (node_ip))

print("\n\n[all:vars]")
printf("nodes=[")

sep=""
for node,ip in nodes.items():
   printf("%s {\"name\": \"%s\", \"ip\": \"%s\"}" % (sep, node, ip))
   sep=","

printf("]\n")
