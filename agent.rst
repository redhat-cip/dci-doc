Agents
======

Khaleesi
--------

Requirements
############

Hardware
^^^^^^^^

OpenStack can deployed either on dedicated bare-metal nodes or on an existing hypervisor as a Virtual Platform.

Bare-metal: The minimal configuration for OSP is 4 servers.

* Hypervisor for the Undercloud and DCI-Agent (Or 2 VM With 2CPU and 4Go RAM each)
* Controller / Compute (2 CPU with VT or VMX and 16GB of RAM for each)


Virtual platform : 

* 1 Hypervisor: the machine should come with a registred RHEL 7 and at least 20GB of memory, 4 CPU and 500GB of disk.

We need an additional node for the DCI-agent, this node can be a virtual machine, it should come with 4GB of memory.

Network
^^^^^^^

The DCI-agent node needs:

* Full internet access to download requirements (pip & Khaleesi)
* Access to power management subsystem of the servers (e.g: IPMI) in the case of bare-metal nodes
* full access to all the nodes

An open SSH access for the Red Hat engineers to the DCI-Agent node is also mandatory.

The Openstack platform network should match the RHEL OSP Network Requirement.

Configuration
^^^^^^^^^^^^^

Distributed CI relies on a tool called Khaleesi ( https://github.com/redhat-openstack/khaleesi ) to deploy OpenStack and run the different tests. The partner should provide a working configuration to deploy an OpenStack that make use of its drivers.

Khaleesi documentation: http://khaleesi.readthedocs.org/en/master/
