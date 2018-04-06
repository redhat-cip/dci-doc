# Administration

## Monitoring

DCI is composed of four different parts :

 * The database (PostgreSQL)
 * The DCI api
 * The DCI ui

The following are our recommendations about what to monitor for each and every component.

Note: The plugin column contain the name of the plugin used with the Sensu monitoring system - that is the one we use internally, please adapt accordingly based on your monitoring platform.

### Base

This applies for all nodes, independently of their roles.

+--------+-----------+-------+-------+--------------------------------+
| Servic | Plugin    | Warni | Criti | Check                          |
| e      | name      | ng    | cal   |                                |
+========+===========+=======+=======+================================+
| Disk   | disk-chec | 85%   | 95%   | check-disk-usage.rb -w 85 -c   |
|        | ks        |       |       | 95                             |
+--------+-----------+-------+-------+--------------------------------+
| DNS    | dns       | N/A   | N/A   | check-dns.rb -d example.com    |
+--------+-----------+-------+-------+--------------------------------+
| Keepal | N/A       | N/A   | N/A   | N/A                            |
| ive    |           |       |       |                                |
+--------+-----------+-------+-------+--------------------------------+
| Load   | load-chec | 5,5,5 | 10,10 | check-load.rb -w 5,5,5 -c      |
|        | ks        |       | ,10   | 10,10,10                       |
+--------+-----------+-------+-------+--------------------------------+
| Memory | memory-ch | 85%   | 95%   | check-memory-percent.rb -w 85  |
|        | ecks      |       |       | -c 95                          |
+--------+-----------+-------+-------+--------------------------------+
| NTP    | ntp       | 10    | 60    | check-ntp.rb -w 10 -c 60       |
+--------+-----------+-------+-------+--------------------------------+
| SSH    | network-c | N/A   | N/A   | check-ports.rb -h 127.0.0.1 -p |
|        | hecks     |       |       | 22 -t 30                       |
+--------+-----------+-------+-------+--------------------------------+

### PostgreSQL

+--------+-----------+-------+-------+--------------------------------+
| Servic | Plugin    | Warni | Criti | Check                          |
| e      | name      | ng    | cal   |                                |
+========+===========+=======+=======+================================+
| Postgr | network-c | N/A   | N/A   | check-ports.rb -h 127.0.0.1 -p |
| eSQL   | hecks     |       |       | 5432 -t 30                     |
+--------+-----------+-------+-------+--------------------------------+


### DCI-API

+---------+----------+------+------+---------------------------------+
| Service | Plugin   | Warn | Crit | Check                           |
|         | name     | ing  | ical |                                 |
+=========+==========+======+======+=================================+
| DCI-API | http     | N/A  | N/A  | check-http-json.rb -u           |
|         |          |      |      | <http://example.com/api/v1>     |
+---------+----------+------+------+---------------------------------+

### DCI-UI

+-----------+------------+-------+-------+----------------------------+
| Service   | Plugin     | Warni | Criti | Check                      |
|           | name       | ng    | cal   |                            |
+===========+============+=======+=======+============================+
| DCI-UI    | http       | N/A   | N/A   | check-http.rb -u           |
|           |            |       |       | <http://example.com>       |
+-----------+------------+-------+-------+----------------------------+


