Search
======

.. http:post:: /api/v1/search

    Research entries in ElasticSearch with the specified pattern.

   **Example request**:

   .. sourcecode:: http

      POST /api/v1/search HTTP/1.1
      Host: example.com
      Accept: application/json
      Authorization: Basic YWRtaW46YWRtaW4=

      {
        "pattern": "ansible",
        "refresh": "true"
      }

   **Example response**:

   .. sourcecode:: http

      HTTP/1.1 200 OK
      Access-Control-Allow-Origin: *
      Content-Length: 73
      Content-Type: application/json
      Keep-Alive: timeout=5, max=100
      Server: Apache/2.4.6 (CentOS) OpenSSL/1.0.1e-fips mod_wsgi/3.4 Python/2.7.5
      
      {
          "logs": {
              "hits": [
                  {
                      "_id": "38c0feda-a98b-498a-ad48-af05c1b77a2c", 
                      "_index": "global", 
                      "_score": 0.4311155, 
                      "_source": {
                          "content": "- downloading role 'redis', owned by geerlingguy\n- downloading role from https://github.com/geerlingguy/ansible-role-redis/archive/1.2.0.tar.gz\n- extracting geerlingguy.redis to roles/geerlingguy.redis\n- geerlingguy.redis was installed successfully\n", 
                          "created_at": "2016-03-25T07:50:00.080332", 
                          "id": "38c0feda-a98b-498a-ad48-af05c1b77a2c", 
                          "job_id": null, 
                          "jobstate_id": "5f266054-74c7-476c-9aae-d576897db30f", 
                          "md5": null, 
                          "mime": "text/plain", 
                          "name": "ansible-galaxy_install_-r_installed_roles_-p_roles/", 
                          "team_id": "ccc822f5-919e-4abc-b44c-1a2add880802"
                      }, 
                      "_type": "log"
                  }, 
              ], 
              "max_score": 0.4311155, 
              "total": 1
          }
      }

   :jsonparam pattern: Pattern to look for in Elasticsearch
   :jsonparam refresh: Should the index be refreshed before query
   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 200: no error


.. http:get:: /api/v1/search/<search-id>

   Get a specific log from ElasticSearch

   **Example request**:

   .. sourcecode:: http

      GET /api/v1/search/22906027-0986-4e3f-82a9-227035f32776 HTTP/1.1
      Host: example.com
      Accept: application/json
      Authorization: Basic YWRtaW46YWRtaW4=


   **Example response**:

   .. sourcecode:: http

      HTTP/1.1 200 OK
      Access-Control-Allow-Origin: *
      Access-Control-Expose-Headers: Authorization, Content-Type, If-Match, ETag
      Connection: Keep-Alive
      Content-Length: 806
      Content-Type: application/json
      Date: Fri, 25 Mar 2016 14:08:59 GMT
      Keep-Alive: timeout=5, max=100
      Server: Apache/2.4.6 (CentOS) OpenSSL/1.0.1e-fips mod_wsgi/3.4 Python/2.7.5

      {
          "logs": {
              "_id": "22906027-0986-4e3f-82a9-227035f32776", 
              "_index": "global", 
              "_source": {
                  "content": "- downloading role 'redis', owned by geerlingguy\n- downloading role from https://github.com/geerlingguy/ansible-role-redis/archive/1.2.0.tar.gz\n- extracting geerlingguy.redis to roles/geerlingguy.redis\n- geerlingguy.redis was installed successfully\n", 
                  "created_at": "2016-03-25T10:43:49.345329", 
                  "id": "22906027-0986-4e3f-82a9-227035f32776", 
                  "job_id": null, 
                  "jobstate_id": "bd35889e-e0ef-4c04-a2c3-a2e1c0ed381e", 
                  "md5": null, 
                  "mime": "text/plain", 
                  "name": "ansible-galaxy_install_-r_installed_roles_-p_roles/", 
                  "team_id": "ccc822f5-919e-4abc-b44c-1a2add880802"
              }, 
              "_type": "log", 
              "_version": 1, 
              "found": true
          }
      }


   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 200: no error
