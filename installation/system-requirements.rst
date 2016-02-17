System Requirements
===================

Storage
-------

The DCI Control-Server applications aims to store logs of various agents running a given job.
The computational part does not happen in the Control-Server itself but on those agents running somewhere else.
Hence, when one plans to deploy a DCI Control-Server one should plan storage capabilities carefully, as data stored will continually grows.


Supported Platforms
-------------------

  * Server: CentOS 7, RHEL 7, Fedora 23
  * Client: CentOS 7, RHEL 7, Fedora 23
  * Web browser: Chrome, Firefox

.. note:: **For RHEL7 the following channels need to be enabled:**

  * rhel-7-server-extras-htb-rpms (python-erkzeug)
  * rhel-7-server-openstack-5.0-rpms (python-flask, python-passlib)
  * rhel-7-server-openstack-7.0-rpms (python-elasticsearch)
  * rhel-7-server-ose-3.1-rpms (ansible, Elasticsearch)
  * rhel-7-server-optional-rpms (epel dependendcies)
  * rhel-7-server-extras-rpms (epel dependencies)

.. warning:: If you are running ansible < 2.0, you need to apply a specific patch so that one can provision RHEL 7 servers.

  In 1.9.4 subscribing to Red Hat entitlement doesn't work.

  Please run the following commands to fix that behavior

  `#> curl -o /tmp/ansible_fix_poolid_capitalization.patch http://dci.enovance.com/patches/ansible_fix_poolid_capitalization.patch`

  `#> patch /usr/lib/python2.7/site-packages/ansible/modules/core/packaging/os/redhat_subscription.py -i ~/fix_poolid_capitalization.patch`

.. warning:: If you are running ansible < 2.0, you need to install gnupg on Fedora 23 (gnupg2 is installed by default) as Ansible only look for the gpg binary to do rpm_key


Components Involved
-------------------

  * PostgreSQL
  * ElasticSearch
  * Python
  * Apache
