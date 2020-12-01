# Gluster Cluster On Lxc Using Ansible to Deploy

## Caveat
THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

You can use this Software unless Apache Licence 2.0 : https://www.apache.org/licenses/LICENSE-2.0

## Introduction
This is basically a test environment which install glusterd in a small cluster running LXC. THIS IS NOT INTENDED FOR PRODUCTION ENVIRONMENTS. This is only for testing and learning how to work with GlusterFS. However, I can easily simulate a Gluster Cluster in my laptop wasting little resources thanks to LXC.

## Installation
The installation is done in Ubuntu 20.04. Despite of having Ansible and LXC installed in your system, to deploy this cluster it is enough to run the provided script:
        ./InstallGluster.sh
        
The names gluster1, gluster2 and gluster3 will be added to your /etc/hosts file in order to access the nodes easily. The peer probe commands will have been done, so no worries about connecting the nodes between them.

