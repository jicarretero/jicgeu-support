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

Once the containers are deployed and running, the Openstack infrastructure will be deployed with the next 3 commands:

The first one will install some software required in the containers:

        kolla-ansible -i multinode bootstrap-servers
        
This command is optional and will check if Openstack can be installed there. It is optional, but it is good to know if there might be any problem:

        kolla-ansible -i multinode prechecks

The last one is the deployment itself:

        kolla-ansible -i multinode deploy
        
