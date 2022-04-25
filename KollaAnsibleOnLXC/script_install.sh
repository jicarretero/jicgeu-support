#!/bin/bash

KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDav74floCqNH69aWyyiSyNZy14szoUfQeOyVzNeYNiobyjH5ssRqxyQU3v5demphI6qx8AKV0sKEFrg7SH2Pfta4NHqRm2cgKHNGNkpr+vVrkVv/ZEwvZP7+JagtbyUWhjX/MGKx2+4YWdeaWQJ5NZ13RHJ6FpNSxpUqwbTwsd8gJJZhUyXPzzyeGMfnOdr7lEEQSTxkdBVQxjaKxeP8xTfnFpHKwSIp68XD2FQn+qv6UQJPEvosr5t1wOohLgQERTu4/e9rRo4iOeX71dPoXiFm52ce1A/oyyaSsYPBNZpEYUXgPsBmjZwzccWUuN+CHCGYNZOnOVBnsgm7ZPF4oh"

export PATH=$PATH:/bin:/usr/bin:/sbin:/usr/sbin

sudo apt -y install docker.io openssh-server

systemctl enable ssh
systemctl start ssh

cd /home/ubuntu
mkdir .ssh/


echo $KEY > .ssh/authorized_keys

chown -R ubuntu.ubuntu .ssh

sed -i '/^ExecStart=/ {s/$/ -s overlay/}' /lib/systemd/system/docker.service
systemctl daemon-reload

systemctl enable docker
systemctl start docker
