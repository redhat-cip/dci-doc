Deployment Recommendations
==========================

DCI has no single bias towards how it should be installed, making it a flexible
continous integration system. As every DCI user has their own particular needs
and IT infrastructure, DCI relies on proven and widely used technologies to
allow the installation to be highly customizable.

Following are three possible scenarios on how one could deploy a DCI
Control-Server.

Monolithic Deployment
---------------------

The monolithic deployment also frequently referred as the all-in-one (AIO)
deployment is a good staring point for poking around. It will let you
understand how everything works together.

For production usage the DCI team would not recommend this setup. The
all-in-one setup prevents having a highly available architecture. It also
prevents scale-out from a horizontal perspective, with the only solution left
to scale vertically.

However, from a development perspective this setup is well suited. It allows
one to see changes quickly. It also allows the administrator to fire-and-forget
a platform install and focus specifically on the agent/feeder/UI development.


Cloud Based Deployment
----------------------

When possible, a cloud based deploy is the recommended one.

The DCI team has built the various servers to be distributed. By doing so, one
can see how easy it becomes to scale-out a platform and implement a highly
available topology.

By leveraging IaaS providers orchestration software (Heat for OpenStack and
CloudFormation for Amazon), one can deploy a full stack in a single command.


Container Based Deployment
--------------------------

For those with container based infrastructures, the DCI Control-Server can be
deployed into these environments. A container based infrastructure is not
currently strongly supported, and will not be heavily discussed in the
documentation at this time.
