Installation
============

Supported Operating Systems
---------------------------

List of current supported operating systems for the Control-Server:

  * CentOS 7

List of current supported operating systems for the python client:

  * CentOS 7
  * Fedora 22
  * Fedora 23


Installation process
--------------------

Repositories
~~~~~~~~~~~~
Packages are available to install the DCI repositories. Packages are available
for CentOS 7, Fedora 22, and Fedora 23.

**CentOS 7**

.. code-block:: bash

  #> yum -y install http://dci.enovance.com/dci-release.el7.noarch.rpm

**Fedora 22**

.. code-block:: bash
  #> dnf -y install http://dci.enovance.com/dci-release.fc22.noarch.rpm

**Fedora 23**

.. code-block:: bash
  #> dnf -y install http://dci.enovance.com/dci-release.fc23.noarch.rpm


PostgreSQL
~~~~~~~~~~

System packages are available for PostgreSQL.

.. code-block:: bash

  #> yum -y install postgresql-server postgesql python-psycopg2


Once the packages installed. The administrator needs to initialized the
database.

.. code-block:: bash

  #> postgresql-setup initdb


Once the database server is initialized, the administrator needs to configure
two things:

  1. The IP the PostgreSQL server will be listening on
  2. Which connection are authorized to query the database server


To configure the IP address on which PostgreSQL will be listening on, edit the
`/var/lib/pgsql/data/postgresql.conf` and edit the `listen_addresses =` line

.. code-block:: bash

  listen_addresses = '*'

'*' means listen an all interfaces. For more informations about the
listen_addresses directive please refers to the official PostgreSQL
documentation.
(http://www.postgresql.org/docs/9.1/static/runtime-config-connection.html)

To configure the authorized connections, edit the
`/var/lib/pgsql/data/pg_hba.conf` and at the bottom of this section specify the
connection parameters one needs

.. code-block:: bash

  host    all             all  10.0.0.0/8            password

The above example will allow any connection from the `10.0.0.0/8` network to
connect as long as a user can authentify correctly.


Finally start the service and configure the firewall so connections can reach
the database server

.. code-block:: bash

  #> systemctl start postgresql
  #> systemctl enable postgresql
  #> firewall-cmd --add-service postgresql --permanent
  #> firewall-cmd --reload


ElasticSearch
~~~~~~~~~~~~~

System packages are *not* yet available for ElasticSearch in CentOS 7. Hence we
will rely on Elastic RPM repos.

First import their PGP key used to sign their packages and create the
`/etc/yum.repos.d/elasticsearch.repo` with the following content :

.. code-block:: bash

  #> rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch

.. code-block:: bash

  [elasticsearch-2.x]
  name=Elasticsearch repository for 2.x packages
  baseurl=http://packages.elastic.co/elasticsearch/2.x/centos
  gpgcheck=1
  gpgkey=http://packages.elastic.co/GPG-KEY-elasticsearch
  enabled=1

Finally install elasticsearch and its dependency - that is not automatically
pulled - the Java opendjk

.. code-block:: bash

  #> yum -y install java-1.8.0-openjdk elasticsearch


To configure on which IP the elasticsearch server will be listening on, one
needs to edit the `/etc/elasticsearch/elasticsearch.yml` file and update the
`network.host` directive

.. code-block:: bash

  network.host: 0.0.0.0

The above example will make elasticsearch listening on all IPv4 addresses.

Last action, start the service and configure the firewall so connections can
reach the elasticsearch server

.. code-block:: bash

  #> systemctl start elasticsearch
  #> systemctl enable elasticsearch
  #> firewall-cmd --add-port 9200/tcp --add-port 9300/tcp --permanent
  #> firewall-cmd --reload


DCI-API
~~~~~~~

System packages are available for the ``dci-api`` in CentOS 7. See
`Repositories`_ for information about getting the DCI repositories.

To install ``dci-api``, simply install the package:

.. code-block:: bash

  #> yum -y install dci-api

Adapt accordingly the configuration file located at ``/etc/dci-api/settings.py``

Critical options are :

  * ``HOST``: the IP of the API host
  * ``ES_HOST``: the IP of the Elasticsearch host
  * ``SQLALCHEMY_DATABASE_URI``: The DB connection URL

Last action to take is to configure the database server

1. Create the DCI database

.. code-block:: bash

  #> su - postgres
  #> psql
  psql (9.2.14)
  Type "help" for help.

  postgres=# CREATE DATABASE dci;


2. Create the DCI user

.. code-block:: bash

  postgres=# CREATE USER dci WITH CREATEDB PASSWORD 'password';


3. Run the dci-dbinit binary that will initialize the database

.. code-block:: bash

  #> export DCI_LOGIN=admin
  #> export DCI_PASSWORD=admin
  #> dci-dbinit

Finally this decision is left up to the administrator, but you can either:

  * Run a server on its own for dci-api (python wsgi.py)
  * Run an httpd proxy server in front and rely on mod_wsgi to run dci-api

If one decide to go with the httpd + mod_wsgi route, this is a working virtual
host configuration:

.. code-block:: bash

  <VirtualHost *:80>
    ServerName api.my.dci.com
    ServerAdmin root@my.dci.com

    CustomLog logs/api.my.dci.com combined
    ErrorLog logs/api.my.dci.com_errors
    DocumentRoot /usr/share/dci-api/

    WSGIScriptAlias / /usr/share/dci-api/wsgi.py
    WSGIPassAuthorization On

    <Directory /usr/lib/python2.7/site-packages/dci>
       AllowOverride None
       Require all granted
    </Directory>

    <Directory /usr/share/dci-api>
       AllowOverride None
       Require all granted
    </Directory>

  </VirtualHost>


DCI-UI
~~~~~~~

System packages are available for ``dci-ui`` in CentOS 7. See `Repositories`_
for information about getting the DCI repositories.

To install dci-ui, simply install the package

.. code-block:: bash

  #> yum -y install dci-ui

In order to serve those files we recommend using httpd with a vhost that looks
like the following:

.. code-block:: bash

  <VirtualHost *:80>
    ServerName my.dci.com
    ServerAdmin root@my.dci.com

    CustomLog logs/my.dci.com combined
    ErrorLog logs/my.dci.com_errors
    DocumentRoot /srv/www/dci-ui

    <Directory /srv/www/dci-ui>
       AllowOverride None
       Require all granted
    </Directory>

  </VirtualHost>


SELinux
~~~~~~~

If - as recommended - you are using httpd to serve the content of DCI, some
actions needs to be taken to make it work seemlessly with SELinux

1. Restorecon on /srv/www

.. code-block:: bash

  #> restorecon -Rv /srv/www

2. Enable the proper selinux booleans

.. code-block:: bash

  #> setsebool -P httpd_can_network_connect_db 1
  #> setsebool -P httpd_can_network_connect 1

3. Restart httpd

.. code-block:: bash

  #> systemctl restart httpd


Configuration Management
------------------------

All those steps mentionned above have been automatized with Ansible through the
use of playbooks.

Those playbooks are available at https://github.com/redhat-cip/dci-infra
