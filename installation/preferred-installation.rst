Preferred Installation
======================

There are many ways one may install the DCI Control-Server. There is however
just one recommended way by the DCI team, recommended in the way that this is
how we proceed to deploy our platforms and hence guarantee its working.

dci-infra
---------

The DCI team provides a set of `ansible playbook`_ to automate the install of
the DCI Control-Server in a repository call `dci-infra`_.

Ideally this repository should be left intact, no change should apply there. If
one sees the need for some change please feel free to submit a ticket/pull
request on the `Github`_ tracker

Every change should be specific to one's own infrastructure and should happen
in dci-infra-data-quickstasrt explained below.

dci-infra-data-quickstart
-------------------------

`dci-infra-data-quickstart`_ is where all ones custom modifications should
happen.

The `dci-infra`_ repository provides all the installation logic and
orchestration. It installs packages, edit configuration files and start
services. The values necessary for the configuration files are read from the
`dci-infra-data-quickstart`_ project.


The `dci-infra-data-quickstart`_ can be seen as DCI environment. Each
clone/branch of this project being a different environment.

To get started one needs to clone this repository, amend the ``group_vars/all``
file (and create a ``vhost_vars/X`` file if necessary) to match one's
infrastructure and commit it back.

For the rest of the documentation, It is assumed that the user has a repository
``dci-infra-data-production`` (located at
``https://github.com/example/dci-infra-data-production``)


From there the ideal worfklow is:

  1. Clone `dci-infra`_
  2. Clone ``dci-infra-data-production`` into a ``data/`` directory in your ``dci-infra`` directory
  3. Install the necessary ansibles modules by running ``ansible-galaxy install -r installed_roles -p roles/``
  4. Run the installer ``ansible-playbook -i data/hosts playbook.yml --tags dci-core``

In summary it should look like :

.. code::

  #> git clone https://github.com/redhat-cip/dci-infra
  #> cd dci-infra
  #> git clone https://github.com/redhat-cip/dci-infra-data-quickstart data
  #> ansible-galaxy install -r installed_roles -p roles/
  #> ansible-playbook -i data/hosts playbook.yml --tags dci-core

At the end you should have a succesful deployment of a DCI Control-Server.

.. note:: If you are provisioning a Fedora 23 server make sure the ``python2``,
  ``yum`` and ``gnupg`` packages are installed. Else ansible won't work

If your DNS setup is correct, you can log in the value of the ``ui_servername``
variable, with the admin login being admin, and the admin password being the
value of the ``admin_password`` variable.

The full list of configuration variables is avaible in `configuration
variables`_ section.

Test suite
----------

To ensure the deployed platform is actually working fine, the DCI team provides
a functionnal test suite to be run.

Those tests are run with the use of the ``dcictl`` command to interact with the
server, hence you will need ``python-dciclient`` to be installed on your
machine.

To run the test, from within the the ``dci-infra/`` directory run ``rake -T``,
a list of available test will appear. Feel free to run all of them, as all of
them should pass to have a valid deployment.

The parameters used for the functionnal test suite are located in
`dci-infra-data-quickstart/properties.yml`

.. note:: To be able to run those tests you need a specific set of packages,
  here the list

  * **From yum**: python2-dciclient, dci-agents, dci-feeders, python-tox (found
    in EPEL for CentOS 7), rubygems, ruby-devel (on Fedora 23 python3-dciclient
    and redhat-rpm-config)
  * **From gem**: rake, ansible_spec

.. warning:: The test suite should not be run as root

.. _ansible playbook: https://www.ansible.com
.. _dci-infra: https://github.com/redhat-cip/dci-infra
.. _Github: https://github.com/redhat-cip/dci-infra/issues
.. _dci-infra-data-quickstart: https://github.com/redhat-cip/dci-infra-data-quickstart
.. _configuration variables: http://doc.dci.enovance.com/installation/configuration-variables.html
