# Kubernetes On Lxc Using Ansible to Deploy

## Caveat
THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

You can use this Software unless Apache Licence 2.0 : https://www.apache.org/licenses/LICENSE-2.0

## Introduction
Basically, this is to install Kubernetes in LXC. It is good to know that THIS IS NOT INTENDED FOR PRODUCTION ENVIRONMENTS. LXC CONTAINERS ARE TOO INSECURE USED THIS WAY.

However, despite of being unsecure, I can easily deploy several LXC containers in my Laptop. Every container is simulating a Virtual Machine and in costs of (specially) RAM and CPU, the costs are much lower than having several Virtual machines in my own laptop. I can simulate a 10 hosts Kubernetes Cluster with little problems in my laptop. But, I can't imagine deploying 10 VMs in my Laptop. This is the advantage.

## Installation

There is a number or prerequisites:

1. This is thought to run in Linux. This was thought to run in my Laptop running Ubuntu 20.04
2. Swap must be disabled:

        swap off -a
    
3. You need a few packages installed before doing anything:

        sudo apt install lxc-dev python3-lxc virtualenv sshpass lxc lxc-templates lxc-utils
        
4. You must have Ansible installed (Python3 is supposed to be there). I installed it using Virtualenv, but you can install it the way you like it.

        virtualenv -p python3 .venv/ansible
        source .venv/ansible/bin/activate

5. And for commodity reasons, I've added my user (jicg) to sudoers without passwords.

        jicg ALL=(ALL:ALL) NOPASSWD: ALL

## The fast way
In order to deploy the Kubernetes cluster you can use the script:

       ./InstallKubernetes.sh
       
This will run everything to make your cluster be up and running.

There is a number of variables you can tweak in the file playbook/vars/containers.yaml:
        controller_container:
          - kcontroller
        worker_containers:
          - kworker1
          - kworker2
          - kworker3
          - kworker4

In the example shown, there will be 1 Kubernetes controller, which will be a container named kcontroller and 4 worker nodes with names kworker1, kworker2, ....

Another file with configuration options is playbook/vars/variables.yaml. The variables are explained in the file itserf.