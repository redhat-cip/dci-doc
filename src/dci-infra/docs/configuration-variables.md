# Configuration Variables

Below is an exhaustive list of the variables the ansible-playbook installer understands. They are specified in [dci-infra-data-quickstart/group\_vars/all](https://github.com/redhat-cip/dci-infra-data-quickstart/blob/master/group_vars/all)

+---------------+-------------+----------------------------------------+
| Variable      | Default     | Description                            |
|               | Value       |                                        |
+===============+=============+========================================+
| hostname      | localhost   | The server hostname                    |
+---------------+-------------+----------------------------------------+
| adminpassword | admin       | The admin account password             |
+---------------+-------------+----------------------------------------+
| dbname        | dci         | The DB name to store DCI related data  |
+---------------+-------------+----------------------------------------+
| dbuser        | dci         | The DB user dci will rely on           |
+---------------+-------------+----------------------------------------+
| dbpassword    | dci         | The DB password for the dci DB user    |
+---------------+-------------+----------------------------------------+
| dbhost        | 127.0.0.1   | The IP address on which the database   |
|               |             | can be reached                         |
+---------------+-------------+----------------------------------------+
| dbbackuppath  | /var/tmp    | The path where to store the DB dump    |
+---------------+-------------+----------------------------------------+
| apihost       | 127.0.0.1   | The IP address on which the DCI API    |
|               |             | can be reached                         |
+---------------+-------------+----------------------------------------+
| servername    | dci.example | Global domain name for DCI             |
|               | .com        |                                        |
+---------------+-------------+----------------------------------------+
| api\_serverna | api.dci.exa | The domain name on which the DCI API   |
| me            | mple.com    | can be reached                         |
+---------------+-------------+----------------------------------------+
| doc\_serverna | doc.dci.exa | The domain name on which the DCI DOC   |
| me            | mple.com    | can be reached                         |
+---------------+-------------+----------------------------------------+
| ui\_servernam | dci.example | The domain name on which the DCI UI    |
| e             | .com        | can be reached                         |
+---------------+-------------+----------------------------------------+
| monitoring\_s | monitoring. | The domain name on which the           |
| ervername     | dci.example | monitoring platform for DCI can be     |
|               | .com        | reached                                |
+---------------+-------------+----------------------------------------+
| serveradmin   | <distribute | The serveradmin that should be         |
|               | d-ci@exampl | contacted if there is any issue with   |
|               | e.com>      | the web server                         |
+---------------+-------------+----------------------------------------+
| sensu\_datace | 'Distribute | Sensu Datacenter name                  |
| nter\_name    | d-CI'       |                                        |
+---------------+-------------+----------------------------------------+
| sensu\_rabbit | '127.0.0.1' | The IP address on which rabbitmq can   |
| mq\_listen\_a |             | be reached                             |
| ddress        |             |                                        |
+---------------+-------------+----------------------------------------+
| sensu\_rabbit | '/sensu'    | The RabbitMQ virtual host to use for   |
| mq\_vhost     |             | Sensu purposes                         |
+---------------+-------------+----------------------------------------+
| sensu\_rabbit | sensu       | The RabbitMQ virtual user for Sensu    |
| mq\_user      |             | purposes                               |
+---------------+-------------+----------------------------------------+
| sensu\_rabbit | secret      | The password for the RabbitMQ virtual  |
| mq\_password  |             | user                                   |
+---------------+-------------+----------------------------------------+
| sensu\_redis\ | '127.0.0.1' | The IP address on which Redis can be   |
| _listen\_addr |             | reached                                |
| ess           |             |                                        |
+---------------+-------------+----------------------------------------+
| sensu\_api\_l | '127.0.0.1' | The IP address on which the Sensu API  |
| isten\_addres |             | can be reached                         |
| s             |             |                                        |
+---------------+-------------+----------------------------------------+
| sensu\_api\_p | 4567        | The Sensu port the API will be         |
| ort           |             | listening on                           |
+---------------+-------------+----------------------------------------+
| sensu\_dashbo | '0.0.0.0'   | The IP address on which the Sensu      |
| ard\_listen\_ |             | dashboard (Uchiwa) can be reached      |
| address       |             |                                        |
+---------------+-------------+----------------------------------------+
| sensu\_dashbo | 3000        | The port on which the Sensu dashboard  |
| ard\_port     |             | (Uchiwa) can be reached)               |
+---------------+-------------+----------------------------------------+
| sensu\_dashbo | admin\_secr | The password for the admin user of the |
| ard\_admin\_p | et          | sensu dashboard (Uchiwa)               |
| assword       |             |                                        |
+---------------+-------------+----------------------------------------+
| sensu\_dashbo | guest\_secr | The password for the guest user of the |
| ard\_guest\_p | et          | sensu dashboard (Uchiwa)               |
| assword       |             |                                        |
+---------------+-------------+----------------------------------------+


