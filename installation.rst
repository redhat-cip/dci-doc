Installation
============

Supported Operating Systems
---------------------------

List of current supported operating systems :

  * CentOS 7

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

  #> yum -y install postgresql-server postgesql python-psycopg2


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

  #> systemctl start postgresql
  #> systemctl enable postgresql
  #> firewall-cmd --add-service postgresql --permanent
  #> firewall-cmd --reload


ElasticSearch
~~~~~~~~~~~~~

System packages are *not* yet available for ElasticSearch in CentOS 7. Hence we will rely on Elastic RPM repos.

First import their PGP key used to sign their packages and create the `/etc/yum.repos.d/elasticsearch.repo` with the following content :

.. code-block:: bash

  #> rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch

.. code-block:: bash

  [elasticsearch-2.x]
  name=Elasticsearch repository for 2.x packages
  baseurl=http://packages.elastic.co/elasticsearch/2.x/centos
  gpgcheck=1
  gpgkey=http://packages.elastic.co/GPG-KEY-elasticsearch
  enabled=1

Finally install elasticsearch and its dependency - that is not automatically pulled - the Java opendjk

.. code-block:: bash

  #> yum -y install java-1.8.0-openjdk elasticsearch


To configure on which IP the elasticsearch server will be listening on, one needs to edit the `/etc/elasticsearch/elasticsearch.yml` file and update the `network.host` directive

.. code-block:: bash

  network.host: 0.0.0.0

The above example will make elasticsearch listening on all IPv4 addresses.

Last action, start the service and configure the firewall so connections can reach the elasticsearch server

.. code-block:: bash

  #> systemctl start elasticsearch
  #> systemctl enable elasticsearch
  #> firewall-cmd --add-port 9200/tcp --add-port 9300/tcp --permanent
  #> firewall-cmd --reload


DCI-API
~~~~~~~

As of this version, the dci-api is not packaged yet in any rpm form.

To install DCI, pull the source code from where it is hosted :

.. code-block:: bash

  #> git clone http://softwarefactory-project.io/r/dci-control-server /srv/www/dci-control-server

*Note*: The source code has been voluntarily cloned into /srv/www so that all files delivered by httpd will have the proper SELinux context out of the box.

Then install its dependencies and dci-control-server itself :

.. code-block:: bash

  (/srv/www/dci-control-server)#> pip install -r requirements.txt
  (/srv/www/dci-control-server)#> pip install -e .

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


  3. Run the init_db script

.. code-block:: bash

  #> export OPENSHIFT_POSTGRESQL_DB_URL=postgresql://dci:password@127.0.0.1/dci
  #> export DCI_LOGIN=admin
  #> export DCI_PASSWORD=admin
  (/srv/www/dci-control-server)#> python dci/cmd/init_openshift_db.py


DCI-UI
~~~~~~~

As of this version, the dci-ui is not packaged yet in any rpm form.

In order to proceed with the installation of the dci-ui several packages needs to be present on the system.

.. code-block:: bash

  #> yum -y install epel-release
  #> yum -y install nodejs npm git tar bzip2
  #> npm install -g gulp npm-cache

To install DCI, pull the source code from where it is hosted :

.. code-block:: bash

  #> git clone http://softwarefactory-project.io/r/dci-control-server /srv/www/dci-control-server

*Note*: The source code has been voluntarily cloned into /srv/www so that all files delivered by httpd will have the proper SELinux context out of the box.

Then install its dependencies and dci-control-server itself :

.. code-block:: bash

  (/srv/www/dci-control-server)#> pip install -r requirements.txt
  (/srv/www/dci-control-server)#> pip install -e .

Run npm install in `/srv/www/dci-control-server/dci/dci_data_browser`, to pull the dependencies and then `gulp build` after which the static files will be ready to be served.

.. code-block:: bash

  (/srv/www/dci-control-server/dci/dci_databrowser)#> npm install
  (/srv/www/dci-control-server/dci/dci_databrowser)#> gulp build


In order to serve those files and have it work seemlessly with httpd we recommend users to use httpd + mod_wsgi with a vhost that looks like the following


.. code-block:: bash

  <VirtualHost *:80>
      ServerName my-dci.com
      ServerAdmin contact@my-dci.com

      CustomLog logs/my_dci_com combined
      ErrorLog logs/my_dci_com_errors
      DocumentRoot /srv/www/dci-control-server

      WSGIScriptAlias / /srv/www/dci-control-server/wsgi.py
      WSGIPassAuthorization On

      <Directory /srv/www/dci-control-server>
          AllowOverride None
          Require all granted
      </Directory>
  </VirtualHost>


SELinux
~~~~~~~

If - as recommended - you are using httpd to serve the content of DCI, some actions needs to be taken to make it work seemlessly with SELinux

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

All those steps mentionned above have been automatized with Ansible through the use of playbooks.

Those playbooks are available at http://softwarefactory-project.io/r/dci-infra
