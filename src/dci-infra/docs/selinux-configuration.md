# SELinux Configuration

The DCI Control-Server works well with SELinux in enforcing mode.

An administrator has two boolean values to enable permanently for the Control-Server to work:

 * **httpd\_can\_network\_connect\_db**: Allow httpd to connect to a database through the network

<!-- -->

    #> setsebool -P httpd_can_network_connect_db 1

 * **httpd\_can\_network\_connect**: Allow httpd to connect to other resources that are not local

<!-- -->

    #> setsebool -P httpd_can_network_connect 1
