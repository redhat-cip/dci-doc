Installation
============

Supported Operating Systems
---------------------------


Components involved
-------------------

DCI requires several components to be installed and configured to work together. It relies on proven technologies to bring the most of each and every tool.

* Python :

* PostgreSQL :

* ElasticSearch :

* Angular :

* Gulp :


Installation process
--------------------

PostgreSQL
~~~~~~~~~~

System packages are available for PostgreSQL.

.. code-block:: bash

  #> yum -y install postgresql-server postgesql


Once the packages installed. The administrator needs to initialized the database.

.. code-block:: bash

  #> postgresql-setup initdb


Once the database server is initialized, the administrator needs to configure two things

  1. The IP the PostgreSQL server will be listening on
  2. Which connection are authorized to query the database server


To configure the IP address on which PostgreSQL will be listening on, edit the `/var/lib/pgsql/data/postgresql.conf` and edit the `listen_addresses =` line

.. code-block:: bash

  listen_addresses = '*'

'*' means listen an all interfaces. For more informations about the listen_addresses directive please refers to the official PostgreSQL documentation. (http://www.postgresql.org/docs/9.1/static/runtime-config-connection.html)

To configure the authorized connections, edit the `/var/lib/pgsql/data/pg_hba.conf` and at the bottom of this section specify the connection parameters one needs

.. code-block:: bash

  host    all             all  10.0.0.0/8            password

The above example will allow any connection from the `10.0.0.0/8` network to connect as long as a user can authentify correctly.


Finally start the service and configure the firewall so connections can reach the database server

.. code-block:: bash

  #> systemctl start postgresql-server
  #> systemctl enable postgresql-server
  #> firewall-cmd --add-service postgresql --permanent
  #> firewall-cmd --reload


ElasticSearch
~~~~~~~~~~~~~


DCI-API
~~~~~~~


DCI-UI
~~~~~~~

Configuration Management
------------------------

