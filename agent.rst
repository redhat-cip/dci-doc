Agents
======

Scheduling Agents
-----------------

As every user might use DCI each on its own way, the DCI team can't maintain every possible agent.
Our focus is made toward making the `python-dciclient` stable, solid and full-featured.

This way every user can create its own agent relying on the common library `python-dciclient`.

Agent is supposed to be run on a regular basis, in an automated fashion.
The DCI team recommends the use of `systemd.timer(5)` to achieve this.

The way it works, an administrator needs to create two files.

First file is a `.service` file, that will run the agent itself.

::

  #> cat /etc/systemd/system/myagent.service
  [Unit]
  Description=My really own DCI agent

  [Service]
  Type=oneshot
  ExecStart=/usr/bin/dci-agent-myagent

Second file is a `.timer` file, that will periodically call the `.service` file.

::

  #> cat /etc/systemd/system/myagent.timer
  [Unit]
  Description=My realy own DCI agent timer

  [Timer]
  OnCalendar=Mon-Fri *-*-* 7-19/3:00:00
  Persistent=true

  [Install]
  WantedBy=timers.target


The most important piece of information here is the OnCalendar parameter. Here it is stated that the agent will be run from Monday to Friday every three hours between 7:00am and 7:00pm. More on that can be found in systemd.time_ documentation.

Finally run the following command so the system takes into account the latest changes and enable the timer.

::

   #> systemctl daemon-reload
   #> systemctl enable myagent.timer


Khaleesi
--------

Requirements
############

Hardware
^^^^^^^^

OpenStack can deployed either on dedicated bare-metal nodes or on an existing
hypervisor as a Virtual Platform.

Bare-metal: The minimal configuration for OSP is 4 servers.

* Hypervisor for the Undercloud and DCI-Agent (Or 2 VM With 2CPU and 4GB RAM each)
* Controller / Compute (2 CPU with VT or VMX and 16GB of RAM for each)


Virtual platform:

* 1 Hypervisor: the machine should come with a registred RHEL 7 and at least 20GB of memory, 4 CPU and 500GB of disk.

We need an additional node for the DCI-agent, this node can be a virtual
machine, it should come with 4GB of memory.

Network
^^^^^^^

The DCI-agent node needs:

* Full internet access to download requirements (pip & Khaleesi)
* Access to power management subsystem of the servers (e.g: IPMI) in the case of bare-metal nodes
* full access to all the nodes

An open SSH access for the Red Hat engineers to the DCI-Agent node is also
mandatory.

The OpenStack platform network should match the RHEL OSP Network Requirement.

Configuration
^^^^^^^^^^^^^

Distributed CI relies on a tool called Khaleesi (
https://github.com/redhat-openstack/khaleesi ) to deploy OpenStack and run the
different tests. The partner should provide a working configuration to deploy an
OpenStack that make use of its drivers.

Khaleesi documentation: http://khaleesi.readthedocs.org/en/master/

:: _systemd.time: https://www.freedesktop.org/software/systemd/man/systemd.time.html#
