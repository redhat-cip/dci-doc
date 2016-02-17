Preferred Installation
======================

There are many ways one may install the DCI Control-Server.
There is however just one recommended way by the DCI team, recommended in the way
that this is how we proceed to deploy our platforms and hence guarantee its working.

dci-infra
---------

The DCI team provides a set of `ansible playbook`_ to automate the install of the DCI Control-Server
in a repository call `dci-infra`_.

Ideally this repository should be left intact, no change should apply there. If one sees the need for some
change please feel free to submit a ticket/pull request on the `Github`_ tracker

Every change should be specific to one's own infrastructure and should happen in dci-infra-data-quickstasrt explained below.

dci-infra-data-quickstart
-------------------------

`dci-infra-data-quickstart`_ is where all ones custom modifications should happen.

This is the ideal worfklow

  1. Fork `dci-infra-data-quickstart`_ apply the changes required by your infrastructure commit them
  2. Clone `dci-infra`_
  3. Clone your fork of `dci-infra-data-quickstart`_ into a `data/` directory in your `dci-infra`_ clone
  4. Run `ansible-playbook -i data/hosts playbook.yml`

At the end you should have a succesful deployment of a DCI Control-Server.

If you DNS setup is correct, you can log in the value of the `ui_servername` variable, with the admin login being admin,
and the admin password being the value of the `admin_password` variable.

Test suite
----------

To ensure the deployed platform is actually working fine, the DCI team provides a functionnal test suite to be run.

Those tests are run with the use of the `dcictl` command to interact with the server, hence you will need `python-dciclient`
to be installed on your machine.

To run the test, from within the the `dci-infra/` directory run `rake -T`, a list of available test will appear.
Feel free to run all of them, as all of them should pass to have a valid deployment.

The parameters used for the functionnal test suite are located in `dci-infra-data-quickstart/properties.yml`

**Note**: To be able to run those tests you need a specific set of packages, here the list

  * **From yum**: python-dciclient, rubygems, ruby-devel
  * **From gem**: rake, ansible_spec

.. _ansible playbook: https://www.ansible.com
.. _dci-infra: https://github.com/redhat-cip/dci-infra
.. _Github: https://github.com/redhat-cip/dci-infra/issues
.. _dci-infra-data-quickstart: https://github.com/redhat-cip/dci-infra-data-quickstart
