Terminology
===========

Like every project, Distributed CI has its own terms with specific meanings. As
understanding those terms is key to grasp how DCI works, here is an exhaustive
list with their meanings.

Agent
-----

The core purpose of DCI is that given a set of `Components`_, an `Agent`
subscribed to those components can pull them and do **anything** with them.

The **anything** aforementioned is where the business-logic takes place. An
`Agent` is a script where administrators specify what to do with the retrieved
set of `Components`.

Context
-------

A context is a namespace holding the connection information to a particular DCI
control server. Both feeders and agents open a connection via the context
module, and communicate with the API over that connection.

Control-Server
--------------

Distributed CI is a client/server application. The `Control-Server` is the
server part. 

The `Control-Server` is where the `Components`_, the `Jobs`_ and all the logs
related to CI runs are stored and browsable. It is the central point of
supervision to know the health of a given set of `Components` (a
`Jobdefinition`_) across all users. It also provides a modern web interface for
users to browse the output of their `Jobs`.


Components
----------

A `Component` is an artifact (file, package, url, etc.) that an `Agent`_ will
take as input in its workflow. Those components are immutable and regularly
updated with newer versions of the artifact through `Feeders`_.


Feeders
-------

A `Feeder` is a script in charge of uploading newer versions of `Components`_
to the `Control-Server`_. They are run either event-based (new release) or
schedule-based (e.g. once a day). `Components` are referenced via a
`Jobdefinition`_ as created by the `Feeder`.


Jobs
----

A Job is the run of a `Jobdefinition`_ by a specific `Remote CI`_. A single
`Jobdefinition` can be run by `N` Remote CI, thus creating `N` jobs. The job
will hold all the information related to the run of the `Agent`_ with this
`Jobdefinition`, the log output, the result of test suite, job context file,
etc.


Jobdefinition
-------------

A `Jobdefinition` is a template describing the `Components` expected for a `Job`.


Topics
-----

A topic is a subset of `Jobdefinition`. For example, OSP8.


Jobstate
--------

During a `Job` run, an `Agent`_ will go through the different `Jobstates`.

Each `Jobstate` has a status from this list:

  * new
  * pre-run
  * running
  * post-run
  * failure
  * success

During each `Jobstate` the `Agent` will perform different tasks. `Files`
can be attach to the `Jobstate`.


Remote CI
---------

A platform and the production configuration. It belongs to a `Team`_. The platform can
be physical, virtual or hybrid.

On of the node is the jumpbox.  It will host the `Agent`, this service is in charge of
the interactions with the `Control-Server` and the platform.
A `Remote CI` is associated to a set of `Topics`.


Team
----

A Team is a set of `Users`_ and `Remote CI`_.


Users
-----

A `User` belongs to a `Team`_, and can be an administrator or standard user.
