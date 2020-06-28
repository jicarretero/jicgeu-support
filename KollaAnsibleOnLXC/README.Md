# Openstack On Lxc Using Ansible and ansible-kolla to Deploy

## Caveat
THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

You can use this Software unless Apache Licence 2.0 : https://www.apache.org/licenses/LICENSE-2.0

## Introduction
Basically, this is an introduction to install Openstack in LXC. It is good to know that THIS IS NOT INTENDED FOR PRODUCTION ENVIRONMENTS. LXC CONTAINERS ARE TOO INSECURE USED THIS WAY.

However, despite of being unsecure, I can easily deploy several LXC containers in my Laptop. Every container is simulating a Virtual Machine and in costs of (specially) RAM and CPU, the costs are much lower than having several Virtual machines in my own laptop. Yes, Openstack will deploy several containers in every LXC node and this installation shown here will use about 6Gb of RAM, however it is useful to deploy a first Openstack and learn the way it goes.

There is a number or prerequisites:

1. This is thought to run in Linux. This was thought to run in my Laptop running Ubuntu 20.04

2. You need a few packages installed before doing anything:

        sudo apt install lxc-dev python3-lxc virtualenv sshpass lxc lxc-templates lxc-utils qemu-kvm

3. You must have Ansible and ansible-kolla installed (Python3 is supposed to be there). I installed it using Virtualenv, but you can install it the way you like it. I've also installed python-openstackclient to be able to manage Openstack infrastructure when it is running

        virtualenv -p python3 .venv/ansible
        source .venv/ansible/bin/activate
        pip install ansible
        pip install kolla-ansible==8.1.1
        pip install python-openstackclient
        
4. And for commodity reasons, I've added my user (jicg) to sudoers without passwords.

        jicg ALL=(ALL:ALL) NOPASSWD: ALL
        
        
## The fast way

In order to deploy the Openstackc cluster, you can use the script:

        ./InstallContainer.sh
        
This will remove all the previous infrastructure you might have created previously and will build a new one deploying the containers needed. There is no script this time to deploy the Openstack infrastructure over the containes. You must do it manually using the command _kolla-ansible_.

_kolla-ansible_ expects at least 2 configuration files in /etc/kolla. I've provided here example files for this (./etc/kolla). The simplest way to set this up is using a symbolic link:

        ln -s ./etc/kolla /etc/kolla
        
In ./etc/kolla/passwords.yml you'll find many passwords. These passwords can be overwritten (in fact they should) with new passwords using the command

        kolla-genpwd

One more thing: to let kolla access using ssh to the containers, in the file _playbooks/vars/containers.yaml_ you must set the value of the variable __public_key__ with your Public Key. Some more tweaks must be done if you want to work without that.

Once the containers are deployed and running and /etc/kolla is properly set, ans your public ssh-key is in the variables file, the Openstack infrastructure will be deployed with the next 3 commands:

The first one will install some software required in the containers:

        kolla-ansible -i multinode bootstrap-servers
        
This command is optional and will check if Openstack can be installed there. It is optional, but it is good to know if there might be any problem:

        kolla-ansible -i multinode prechecks

The last one is the deployment itself:

        kolla-ansible -i multinode deploy
        
After this, the cluster should be up and running. You might want to start and stop it instead of creating a new cluster every time:

        ansible-playbook  -i inventory playbooks/CreateLxcContainers.yaml -e state=started
        
        ansible-playbook -i inventory playbooks/CreateLxcContainers.yaml -e state=stopped
        
That's it. I would also recommend to add a few lines to your /etc/hosts to make ssh easier:

        172.23.32.254	  controller
        172.23.32.5     compute-01
        172.23.32.6     compute-02
        172.23.32.7     compute-03


## The Files here:
* _ansible.cfg_ - Configurations for ansible and kolla-ansible
* _inventory_ - Inventory (just localhost) for Ansible
* _containers_inventory_  - Inventory for the containers installation.
* _multinode_  - Kolla-ansible inventory file. This is a bit more complex than the previous ones
* _keystoneIdmLocal_  - Configuration for Openstack CLI according to my configurations.
* _GenerateEnvironment.py_ - A naive script that writes to stdout what should be your containers_inventory file with your configurations.
* _InstallContainers.sh_ - This script destroys your previous Openstack Installation and creates and configures the Containers where to install a new Openstack Installation.

## Starting with Openstack

The Admin user is __admin__ and the admin password is in _/etc/globals/passwords.yml_ set in the variable __keystone_admin_password__. You can find it this way:

        grep keystone_admin_password /etc/kolla/passwords.yml
        
There is a file named _keystoneIdmLocal_ which sets the variables to properly work with Openstack CLI.

        source ./keystoneIdmLocal
        
Now you can use Openstack CLI. Here are some useful examples to use in your new Openstack Installation: [examples]()