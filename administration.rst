Adminitsration
==============

Monitoring
----------

DCI is composed of four different parts :

  * The database (PostgreSQL)
  * The log storage backend (ElasticSearch)
  * The DCI api
  * The DCI ui

The following are our recommendations about what to monitor for each and every component.

Note: The plugin column contain the name of the plugin used with the Sensu monitoring system - that is the one we use internally, please adapt accordingly based on your monitoring platform.


Base
^^^^

This applies for all nodes, independently of their roles.

+-----------+----------------+----------+----------+
| Service   | Plugin name    | Warning  | Critical |
+===========+================+==========+==========+
| Disk      | disk-checks    | 85%      | 95%      |
+-----------+----------------+----------+----------+
| DNS       | dns            | N/A      | N/A      |
+-----------+----------------+----------+----------+
| Keepalive | N/A            | N/A      | N/A      |
+-----------+----------------+----------+----------+
| Load      | load-checks    | 5,5,5    | 10,10,10 |
+-----------+----------------+----------+----------+
| Memory    | memory-checks  | 85%      | 95%      |
+-----------+----------------+----------+----------+
| NTP       | ntp            | 10       | 60       |
+-----------+----------------+----------+----------+
| SSH       | network-checks | N/A      | N/A      |
+-----------+----------------+----------+----------+

PostgreSQL
^^^^^^^^^^

+------------+----------------+----------+----------+
| Service    | Plugin name    | Warning  | Critical |
+============+================+==========+==========+
| PostgreSQL | network-checks | N/A      | N/A      |
+------------+----------------+----------+----------+


ElasticSearch
^^^^^^^^^^^^^

+---------------+----------------+----------+----------+
| Service       | Plugin name    | Warning  | Critical |
+===============+================+==========+==========+
| ElasticSearch | elasticsearch  | N/A      | N/A      |
+---------------+----------------+----------+----------+


DCI-API
^^^^^^^

+---------------+----------------+----------+----------+
| Service       | Plugin name    | Warning  | Critical |
+===============+================+==========+==========+
| DCI-API       | http           | N/A      | N/A      |
+---------------+----------------+----------+----------+


DCI-UI
^^^^^^

+---------------+----------------+----------+----------+
| Service       | Plugin name    | Warning  | Critical |
+===============+================+==========+==========+
| DCI-UI        | http           | N/A      | N/A      |
+---------------+----------------+----------+----------+
