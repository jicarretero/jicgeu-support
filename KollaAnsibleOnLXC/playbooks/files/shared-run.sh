#!/bin/bash

mount --make-shared /run

[ -d /dev/net ] || mkdir /dev/net
[ -c /dev/net/tun ] || mknod  /dev/net/tun c 10 200
[ -c /dev/kvm ] || mknod  /dev/kvm c 10 232
[ -c /dev/vhost-net ] || mknod  /dev/vhost-net c 10 238
