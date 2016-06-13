Preferred Installation
======================

There are a few ways to install the DCI Control-Server, but the preferred and
documented method is to utilize the DevOps tools available.

dci-infra
---------

The DCI team provides an `ansible playbook`_ to automate the install of the 
DCI Control-Server in a repository called `dci-infra`_.

It should not be necessary to change anything in the ``dci-infra`` repository. A
complementary repository where your local override data should live is
contained within the `dci-infra-data-quickstart`_ repository.

If you find an area that can be made more dynamic in the ``dci-infra``
repository, or you find a bug, please feel free to submit a ticket or pull
request on the `Github`_ tracker.

dci-infra-data-quickstart
-------------------------

`dci-infra-data-quickstart`_ is where all your custom modifications should
live.

The `dci-infra`_ repository provides all the installation logic and
orchestration. It installs packages, edits configuration files, and starts
services. The values necessary for the configuration files are read from the
`dci-infra-data-quickstart`_ project.


The `dci-infra-data-quickstart`_ can be seen as a deployed environment, with
each clone/branch of this project being a different environment.

To get started, simply clone the `dci-infra-data-quickstart`_ repository, amend
the ``group_vars/all`` file (and create a ``vhost_vars/X`` file if necessary)
to match your infrastructure.

After modifying the configuration, the workflow continues as follows:

  1. Clone `dci-infra`_
  2. Clone ``dci-infra-data-quickstart`` into a ``data/`` directory in your 
     ``dci-infra`` directory
  3. Install the necessary ansibles modules by running
     ``ansible-galaxy install -r installed_roles -p roles/``
  4. Run the installer
     ``ansible-playbook -i data/hosts playbook.yml --tags dci-core``

In summary it should look like:

.. code::

  #> git clone https://github.com/redhat-cip/dci-infra
  #> cd dci-infra
  #> git clone https://github.com/redhat-cip/dci-infra-data-quickstart data
  #> ansible-galaxy install -r installed_roles -p roles/
  #> ansible-playbook -i data/hosts playbook.yml --tags dci-core

At the end you should have a succesful deployment of a DCI Control-Server.

.. note:: If you are provisioning a Fedora 23 server make sure the ``python2``,
  ``yum`` and ``gnupg`` packages are installed, otherwise Ansible won't work.

If your DNS setup is correct, you can log in the value of the ``ui_servername``
variable, with the Login field value being ``admin``, and the Password field
value being the contents of the ``admin_password`` variable.

The full list of configuration variables is available in the 
`configuration variables`_ section.

Test suite
----------

To ensure the deployed platform is actually working fine, the DCI team provides
a functional test suite to be run.

Those tests are run with the use of the ``dcictl`` command to interact with the
server, hence you will need ``python-dciclient`` to be installed on your
machine.

To run the test, from within the the ``dci-infra/`` directory run ``rake -T``,
a list of available tests will appear. Feel free to run all of them, as all
tests should pass to have a valid deployment.

The parameters used for the functional test suite are located in
``dci-infra-data-quickstart/properties.yml``

.. note:: To be able to run those tests you need a specific set of packages:

  * **From yum**: ``python2-dciclient``, ``dci-agents``, ``dci-feeders``, 
    ``python-tox`` (found in EPEL for CentOS 7), ``rubygems``, ``ruby-devel`` 
    (on Fedora 23 ``python3-dciclient`` and ``redhat-rpm-config``)
  * **From gem**: rake, ansible_spec

.. warning:: The test suite should not be run as root

.. _ansible playbook: https://www.ansible.com
.. _dci-infra: https://github.com/redhat-cip/dci-infra
.. _Github: https://github.com/redhat-cip/dci-infra/issues
.. _dci-infra-data-quickstart: https://github.com/redhat-cip/dci-infra-data-quickstart
.. _configuration variables: http://doc.dci.enovance.com/installation/configuration-variables.html
