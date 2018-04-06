# Manual Installation

## Supported Operating Systems

List of current supported operating systems for the Control-Server:

 * CentOS 7

List of current supported operating systems for the python client:

 * CentOS 7
 * Fedora 23

## Installation process

### Repositories

Packages are available to install the DCI repositories. Packages are available for CentOS 7 and Fedora 23.

**CentOS 7**

``` sourceCode
#> yum -y install https://packages.distributed-ci.io/dci-release.el7.noarch.rpm
```

**Fedora 23**

``` sourceCode
#> dnf -y install http://packages.distributed-ci.io/dci-release.fc23.noarch.rpm
```

### PostgreSQL

System packages are available for PostgreSQL.

``` sourceCode
#> yum -y install postgresql-server postgesql python-psycopg2
```

Once the packages installed. The administrator needs to initialized the database.

``` sourceCode
#> postgresql-setup initdb
```

Once the database server is initialized, the administrator needs to configure two things:

> 1.  The IP the PostgreSQL server will be listening on
> 2.  Which connection are authorized to query the database server

To configure the IP address on which PostgreSQL will be listening on, edit the /var/lib/pgsql/data/postgresql.conf and edit the listen\_addresses = line

``` sourceCode
listen_addresses = '*'
```

'\*' means listen an all interfaces. For more informations about the listen\_addresses directive please refers to the official PostgreSQL documentation. (<http://www.postgresql.org/docs/9.1/static/runtime-config-connection.html>)

To configure the authorized connections, edit the /var/lib/pgsql/data/pg\_hba.conf and at the bottom of this section specify the connection parameters one needs

``` sourceCode
host    all             all  10.0.0.0/8            password
```

The above example will allow any connection from the 10.0.0.0/8 network to connect as long as a user can authentify correctly.

Finally start the service and configure the firewall so connections can reach the database server

``` sourceCode
#> systemctl start postgresql
#> systemctl enable postgresql
#> firewall-cmd --add-service postgresql --permanent
#> firewall-cmd --reload
```

### DCI-API

System packages are available for the `dci-api` in CentOS 7. See [Repositories]() for information about getting the DCI repositories.

To install `dci-api`, simply install the package:

``` sourceCode
#> yum -y install dci-api
```

Adapt accordingly the configuration file located at `/etc/dci-api/settings.py`

Critical options are :

 * `HOST`: the IP of the API host
 * `SQLALCHEMY_DATABASE_URI`: The DB connection URL

Last action to take is to configure the database server

1.  Create the DCI database

``` sourceCode
#> su - postgres
#> psql
psql (9.2.14)
Type "help" for help.

postgres=# CREATE DATABASE dci;
```

1.  Create the DCI user

``` sourceCode
postgres=# CREATE USER dci WITH CREATEDB PASSWORD 'password';
```

1.  Run the dci-dbinit binary that will initialize the database

``` sourceCode
#> export DCI_LOGIN=admin
#> export DCI_PASSWORD=admin
#> dci-dbinit
```

Finally this decision is left up to the administrator, but you can either:

 * Run a server on its own for dci-api (python wsgi.py)
 * Run an httpd proxy server in front and rely on mod\_wsgi to run dci-api

If one decide to go with the httpd + mod\_wsgi route, this is a working virtual host configuration:

``` sourceCode
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
```

### DCI-UI

System packages are available for `dci-ui` in CentOS 7. See [Repositories]() for information about getting the DCI repositories.

To install dci-ui, simply install the package

``` sourceCode
#> yum -y install dci-ui
```

In order to serve those files we recommend using httpd with a vhost that looks like the following:

``` sourceCode
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
```

### SELinux

If - as recommended - you are using httpd to serve the content of DCI, some actions needs to be taken to make it work seemlessly with SELinux

1.  Restorecon on /srv/www

``` sourceCode
#> restorecon -Rv /srv/www
```

1.  Enable the proper selinux booleans

``` sourceCode
#> setsebool -P httpd_can_network_connect_db 1
#> setsebool -P httpd_can_network_connect 1
```

1.  Restart httpd

``` sourceCode
#> systemctl restart httpd
```

## Configuration Management

All those steps mentionned above have been automatized with Ansible through the use of playbooks.

Those playbooks are available at <https://github.com/redhat-cip/dci-infra>
