# Some useful tips to start using your Openstack Installation

## Networks

There are no networks defined there. So, you'll need to define at least 1 network for your VMs to communicate with each other and another external one, so they can communicate with Internet.

### Internal network.

This network will provide internal communication between virtual machines, access to DHCP internal server and metadata server. It is important to have a network ready. This network will be shared, so all users will be able to use it. You can forget this step and expect every user to create its own network.

        openstack network create  --share internal

        openstack subnet create --network internal \
        --allocation-pool start=10.202.254.3,end=10.202.254.254 \
        --dns-nameserver 8.8.8.8 --gateway 10.202.254.1 \
        --subnet-range 10.202.254.0/24 sub-int-net


### External network

The external network (basically) will provide access to Internet to the VMs. It can be created this way:

        openstack network create --external \
        --provider-network-type flat \
        --provider-physical-network physnet1 ext-net

        openstack subnet create --network ext-net \
        --allocation-pool start=172.23.16.16,end=172.23.16.254 \
        --dns-nameserver 8.8.8.8 --gateway 172.23.16.1 \
        --subnet-range 172.23.16.0/24 sub-ext-net


### Adding a router.

The way to communicate 2 different networks is using a router. We need a (virtual) router to communicate our internal network with the external one. This is done this way:

        # Create a router named rt-ext
        openstack router create rt-ext

        # Set the external gateway (gateway to connect to the internet)
        openstack router set rt-ext --external-gateway  ext-net

        # Add the subnet (the internal one)
        openstack router add subnet rt-ext sub-int-net

After the last step the external network and the internal one are connected with this router.


## Adding Flavors

The flavors (basically) sets how Virtual Machines are created in terms of Virtual CPUs, RAM (in MB) and Hard Disk (in GB). There are no flavors defined by default and we are going need them in order to create the VMs. Here are a couple of examples to define here 2 flavors named small and medium:

        openstack flavor create --public --ram 1024 --disk 10 --vcpus 1 small
        openstack flavor create --public --ram 2048 --disk 10 --vcpus 2 medium


## Adding Disk Images to Glance

We need disk images to create virtual machines. So, here is the typical really small image to download. It is 2 steps: downloading the Image and uploading it to glance:

        wget http://download.cirros-cloud.net/0.3.4/cirros-0.3.4-x86_64-disk.img
        
        openstack image create "cirros" \
        --file cirros-0.3.4-x86_64-disk.img \
        --disk-format qcow2 --container-format bare \
        --public
        
