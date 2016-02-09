Deployment Recommendations
==========================

The best way to install a DCI Control-Server ? There is none. There is no 'best
way' as every DCI user has their own particular needs and IT infrastructure.
DCI relies on proven and widely used technologies. The installation is highly
cutomizable.

Following are three possible scenarios on how one could deploy a DCI
Control-Server, hopefully everyone should find a starting point for its own
needs.

Monolithic Deployment
---------------------

The monolithic deployment also frequently referred as the all-in-one (AIO)
deployment is a good staring point for poking around. It will let you
understand how everything works together.

For production usage the DCI team would not recommend this setup. This
setup prevent having an highly available architecture, it also prevents
scale-out perspective, with the only solution left to scale vertically.

From a development perspective this setup is well suited. It allows one
to see changes quickly. It also allows one to fire-and-forget a platform
install and focus specifically on the agent/feeder/ui development.


Cloud Based Deployment
----------------------

The DCI team has built the different services so they can be run separately.

By doing so, one can see how easy it becomes to scale-out a platform and
implement an highly available topology.

This deployment when possible is the recommended one by the DCI team.

By leveraging IaaS providers orchestration software (Heat for OpenStack and
CloudFormation for Amazon), one can deploy a full stack in a single command.


Container Based Deployment
--------------------------

You consider all the previous items so '2000s and think everything should be
containerized ? As per DCI design decision, it's easy and this is how some of
our contributors already deploy this stack.

As for our recommendations for production usage, it all depends on you, can
you manage containers in production ? If so then go ahead it will work well.
