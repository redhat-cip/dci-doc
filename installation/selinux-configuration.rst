SELinux Configuration
=====================

DCI Control-Server works well with SELinux in enforcing mode.

An administrator has two boolean to enable permanently for the Control-Server to work 

* **httpd_can_network_connect_db**: Allow httpd to connect to a database through the network

::

    #> setsebool -P httpd_can_network_connect_db 1

* **httpd_can_network_connect**: Allow httpd to connect to other resources that are not local

::

  #> setsebool -P httpd_can_network_connect 1
