Development Environment
=======================

This page describes how to use docker compose in order to provide a
development environment.

Getting started
---------------

To run dci in docker compose follow those steps:

* clone the dev repository: https://github.com/redhat-cip/dci-dev-env
* clone all the dci related project into this repository:

  * https://github.com/redhat-cip/dci-control-server
  * https://github.com/redhat-cip/python-dciclient
  * https://github.com/redhat-cip/dci-ui
  * http://softwarefactory-project.io/r/dci-doc

* install docker-compose and git-review if you want to contribute,
  the correct versions are described in `requirements.txt <requirements.txt>`_
  you can install those requirements by simply typing:
  ``pip install -r requirements.txt``
* launch the environment by running docker-compose:
  ``docker-compose -f dci.yml up``

Now the environment is up and running, you can attach containers in order to
run parts of the application. For further information see
`the containers section <#containers>`_.

Containers
----------

There are six containers, the first four are needed to run the application.
The two last are helpers for the project.

* **dci_db**: contains the postgresql database, it is started by default and
  serve the database on localhost port 5432.
* **dci_es**: contains the elasticsearch database, it is started by default and
  serve on localhost port 9200 and 9300.
* **dci_api**: contains the api of the application, it must be started manually
  (see `the following section for details <#api-container>`__). The API is
  served on localhost port 5000.
* **dci_app**: contains the web app of dci, it must be started manually
  (see `the following section for details <#app-container>`__). The web
  application is served on localhost port 8000.
* **dci_tox**: contains all the needed module for testing, it is not needed
  for running the application but is a helper in order to run tests
  on the client and the API
  (see `the following section for details <#tox-container>`__).
* **dci_doc**: helper for building the documentation of the project
  (see `the following section for details <#doc-container>`__).
* **dci_dbwatcher**: helper for interacting with the database.
  (see `the following section for details <#dbwatcher-container>`__).

API container
~~~~~~~~~~~~~

In the following section we will assume that we run the commands in the
dedicated container, just after attaching it with
``docker attach <container-name>``

To initialize this container you need to perform some operations:

* initialize or reinitialize the database by running
  `./scripts/db_provisioning.py <https://github.com/redhat-cip/dci-control-server/blob/master/scripts/db_provisioning.py>`_
* start the development server by running
  `./bin/dci-runtestserver <https://github.com/redhat-cip/dci-control-server/blob/master/bin/dci-runtestserver>`_

APP container
~~~~~~~~~~~~~

In the following section we will assume that we run the commands in the
dedicated container, just after attaching it with
``docker attach <container-name>``

Like the api you need to perform some operations before running the app:

* install npm dependencies for the application: ``npm install``
* run the application: ``gulp serve:dev``

This container also contains some targets for testing the frontend, see the
`gulpfile <https://github.com/redhat-cip/dci-ui/blob/master/gulpfile.js>`_
for more informations.

TOX container
~~~~~~~~~~~~~

In the following section we will assume that we run the commands in the
dedicated container, just after attaching it with
``docker attach <container-name>``

This container is a helper for launching tests on the client and/or the api,
just navigate to the correct project directory and run the tox command in order
to launch the tests.

DOC container
~~~~~~~~~~~~~

This container is particular because it is not started by default.
It only provides an entrypoint for the sphinx documentation generation.

To run it and see the default commands type:
``docker-compose -f dci.yml run doc``

To generate an html output of the doc for a preview type:
``docker-compose -f dci.yml run doc html``

DBwatcher container
~~~~~~~~~~~~~~~~~~~

This container is ran, generates a schema of the db in png format,
then stopped. You will have to run it again and attach it in order to interact
with the database.

To run and attach the container type:
``docker-compose -f dci.yml run dbwatcher bash``

Then you can run ``psql`` it will directly attach to the dci_control_server
database.

If you want to generate the database schema again just run the container
without overriding the entrypoint:
``docker-compose -f dci.yml run dbwatcher``
