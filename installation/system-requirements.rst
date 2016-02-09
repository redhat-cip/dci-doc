System Requirements
===================

Storage
-------

The DCI Control-Server applications aims to store logs of various agents running a given job.
The computational part does not happen in the Control-Server itself but on those agents running somewhere else.
Hence, when one plans to deploy a DCI Control-Server one should plan storage capabilities carefully, as data stored will continually grows.


Supported Platforms
-------------------

  * Server: CentOS 7
  * Client: Fedora 23, CentOS 7
  * Web browser: Chrome, Firefox


Components Involved
-------------------

  * PostgreSQL
  * ElasticSearch
  * Python
  * Apache
