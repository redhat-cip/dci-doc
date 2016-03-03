Organization
============

The ecosystem of Distributed CI (DCI) relies on several components. Some are
developed by the DCI team while others are well known software. DCI relies
only on packaged softwares for the platform we support.


Components
----------

The 'core' components provided by the DCI team itself are:

  * **dci-control-server**: The API (a.k.a the Control-Server). This is where all the
    logic happens.

  * **dci-ui**: The DCI web interface code.

  * **python-dciclient**: This code hosts the client library and CLI to
    interact with the dci-api.

  * **dci-agents**: Various agents to provide integration functionality.

  * **dci-feeders**: Various feeders that will create components on the server.


**Note**: For the packages ``dci-agents`` and ``dci-feeders`` the code itself
is stored in the ``python-dciclient`` repository.


Release Cycle
-------------

DCI follows a Continuous Deployment (CD) pattern for its own production needs.

What this means is that as soon as a patch is merged on our code base, a
package is built, tested, and shipped to our repositories. Through the
continous deployment methodology, our users can always benefit from the
shiniest and brightest features the last contribution brought to the code.

For those of who prefer not to live on the edge, the DCI team also provides
regularly tagged release versions.


Repositories
------------

To provide the aforementioned packages, the DCI team provide a set of
repositories.

There are three repositories:

  * **Current**: This repository contains the tagged release versions. They
    might be behind the master branch but those versions are stable and receive
    bug-fixes and security backports.


  * **Development**: This repository contains the version of the package built
    after each commit upstream has been tested and merged. As stated earlier,
    this repository always contains the latest changes to the system.


  * **Extras**: For components that we would like to ship, but are not yet
    packaged upstream, we provide the packages necessary in the Extras
    repository.
    **Note**: Please verify the content of this repository before pulling any
    packages since it can potentially update your locally installed  version.


Packages are available at http://dci.enovance.com/repos/

The DCI team provides the ``dci-release`` package that will create the
repository file locally for you.

The ``dci-release`` package is located at
http://dci.enovance.com/dci-release.el7.noarch.rpm. Please update `el7` 
according to the system you're deploying to.


Upstream
--------

The source code for various DCI components is hosted on `Software Factory`_,
and mirrors are provided on GitHub at the following locations. To contribute to
DCI, you'll need to clone from Gerrit on the `Software Factory`_ site.

Each of those git repositories are also mirrored in GitHub, under the
`redhat-cip`_ namespace.

  * dci-api: https://github.com/redhat-cip/dci-control-server

  * dci-ui: https://github.com/redhat-cip/dci-ui

  * python-dciclient: https://github.com/redhat-cip/python-dciclient

  * dci-infra: https://github.com/redhat-cip/dci-infra

  * dci-infra-data-quickstart:
    https://github.com/redhat-cip/dci-infra-data-quickstart

  * dci-doc: http://softwarefactory-project.io/r/dci-doc


.. _Software Factory: http://softwarefactory-project.io/
.. _redhat-cip: https://github.com/redhat-cip
