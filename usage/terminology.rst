Terminology
===========

Like every project, Distributed CI has its own terms with specific meanings. As
understaning those terms is key to grasp how DCI works, here is an exhaustive
list with their meanings.

Agent
-----

The very core purpose of DCI is that given a set of Components uploaded by an
admin, a user subscribed to those components can pull them and do **anything**
with them. The **anything** aforementioned is where the business-logic takes
place. An Agent is a script where users specify what to do with the retrieved
set of Components.


Control-Server
--------------

Distributed CI is a client/server application. Control-Server is the server
part. This is where the Components, the Jobs and all the logs related are
stored and browsable. It is the central point of supervision to know the health
of a given set of Components (a Jobdefinition) across all users. It provides
also a modern web interface for user to browse the outputs of their Jobs.


Component
---------

A Component is an object, an artifact (file, package, url, nearly anything)
that an agent will take as input in its workflow. Those components are
regurlaly updated with newer version of the object through Feeders.


Feeder
------

Scripts in charge of uploading newer versions of Components to the
Control-Server are called Feeders. They are traditionnaly run either
event-based (new release) or on a timely basis (ie. once a day)


Job
---

A Job is the run of a Jobdefinition by a specific Remote CI. A single
Jobdefinition can be run by N Remote CI, thus creating N jobs. The job will
hold all the informations related to the run of the Agent with this
Jobdefinition, the logs output, the result of test suite, Job context file,
etc...


Jobdefinition
-------------

A Jobdefinition is a set of Components.


Jobstate
--------

During its run, an Agent will go through different Jobstate.

The valid Jobstate list is :

  * new
  * pre-run
  * running
  * post-run
  * failure
  * success

During each Jobstate the agent will perform different tasks.


Remote CI
---------

A server (physical or virtual) on which the Agent run. It belongs to a team.


Team
----

A Team is a set of User and Remote CI.


User
----

A User, no special meaning here. It belongs to a team, and can be admin or not.
