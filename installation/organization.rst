Organization
============

The ecosystem of Distributed CI (DCI) relies on several components, some are
developped by the DCI team while other are well known softwares. DCI relies only
on packaged softwares for the platform we support.


Components
----------

The 'core' components provided by the DCI teams itself are :

  * **dci-api**: The API (a.k.a the Control-Server), this is where all the logic happens.

  * **dci-ui**: The DCI web interface code

  * **python-dciclient**: This code hosts the client library and CLI to interact with the dci-api

  * **dci-agents**: Various agents that answers different problematics

  * **dci-feeders**: Various feeders that will create component on the server


**Note**: For the packages dci-agents and dci-feeders the code itself is stored in the python-dciclient repository


Release Cycle
-------------

DCI follows a Continuous Deployment (CD) pattern for its own production needs.
This translate by the fact that as soon as a patch is merged on our code base,
a package is built, tested and shipped in our repositories. This way our users
can always benefit from the shiniest and brightest features the last contribution
brought to the code.

For those of who prefer not to live on the edge, the DCI team also provides
regularly tagged released version.


Repositories
------------

To provide the aforementioned packages, the DCI team provide a set of repository.

They are three repositories:

  * **Current**: This repository contains the tagged released version. They might be behind the master branch but those versions are stable and receive bug-fix and security backport.


  * **Development**: This repository contains the version of the package built after each commit upstream have been merged and tested. As said earlier the shiniest and brightest of DCI


  * **Extras**: Some version of components we would like to ship are not packaged yet upstream, we do provide the version necessary in this repository.  **Note**: Please verify the content of this repository before pulling any package from it as it can update your local version.


Those packages are available at http://dci.enovance.com/repos/

The DCI team provides the dci-release package that will create the repository
file locally for you.

This package is located at http://dci.enovance.com/dci-release.el7.noarch.rpm
Please update el7 according to your needs.


Upstream
--------

To see the code itself - or contribute - the code is hosted on `Software Factory`_

  * dci-api: http://softwarefactory-project.io/r/dci-control-server

  * dci-ui: http://softwarefactory-project.io/r/dci-ui

  * python-dciclient: http://softwarefactory-project.io/r/python-dciclient

  * dci-infra: http://softwarefactory-project.io/r/dci-infra

  * dci-infra-data-quickstart: http://softwarefactory-project.io/r/dci-infra-data-quickstart

  * dci-doc; http://softwarefactory-project.io/r/dci-doc

Each of those git repository are also mirrored in Github. Under the `redhat-cip`_ namespace.


.. _Software Factory: http://softwarefactory-project.io/
.. _redhat-cip: https://github.com/redhat-cip
