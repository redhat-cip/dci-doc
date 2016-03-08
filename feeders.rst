Feeders
=======

A `Feeder` is a script in charge of uploading newer versions of `Components`
to the `Control-Server`. They are run either event-based (new release) or
schedule-based (e.g. once a day). `Components` are referenced via a
`Jobdefinition` as created by the `Feeder`.

Various Feeders can be configured to monitor for the creation of new artifacts.
When a new artifact is available, the feeder can then upload the artifact as a
Component to the DCI Control-Server and make a Jobdefinition available to the
Agents so that they can create and execute a new job.

DCI doesn't have a bias towards where the artifact comes from, so scripts can
be easily created using the ``dciclient`` library.

Configuring a Feeder
--------------------

A few differnet feeders exist in the ``python-dciclient`` repository. We're
going to look at the Github feeder as it's a simple implementation to look for
new commits on a Github repository and create new `Jobdefinitions` within the
DCI Control-Server.


