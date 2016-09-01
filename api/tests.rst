Tests
=====

.. http:post:: /api/v1/tests

   Create a test.

   **Example request**:

   .. sourcecode:: http

      POST /api/v1/tests HTTP/1.1
      Host: example.com
      Accept: application/json

      {
        "name": "test_name",
        "team_id": "e78cf47c-12a7-4af7-bdb3-50352e6e32e1"
      }

   **Example response**:

   .. sourcecode:: http

      HTTP/1.0 201 CREATED
      Access-Control-Allow-Origin: *
      Content-Length: 180
      Content-Type: application/json
      Date: Tue, 23 Feb 2016 13:55:32 GMT
      Server: Werkzeug/0.10.4 Python/2.7.6

      {
        "test": {
          "created_at": "2016-02-23T13:55:32.512778",
          "data": {},
          "id": "3e4224bd-7587-4390-898f-6390637caf7e",
          "name": "ptdr",
          "team_id": "e78cf47c-12a7-4af7-bdb3-50352e6e32e1"
        }
      }

   :jsonparam name: name of the test
   :jsonparam topic_id: the id of the topic related to the test
   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 201: no error
   :statuscode 422: error on request data, maybe a conflict

.. http:delete:: /api/v1/tests/<test-id>

   Delete a test.

   **Example request**:

   .. sourcecode:: http

      DELETE /api/v1/tests/3e4224bd-7587-4390-898f-6390637caf7e HTTP/1.1
      Accept: application/json
      Content-Length: 0
      Host: 127.0.0.1:5000

   **Example response**:

   .. sourcecode:: http

      HTTP/1.0 204 NO CONTENT
      Access-Control-Allow-Origin: *
      Content-Length: 0
      Content-Type: application/json

   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 204: no error
   :statuscode 422: error on test id, maybe a conflict

.. http:get:: /api/v1/tests/<test-id>

   Get a test.

   **Example request**:

   .. sourcecode:: http

      GET /api/v1/tests/3e4224bd-7587-4390-898f-6390637caf7e HTTP/1.1
      Accept: application/json
      Content-Length: 0
      Host: 127.0.0.1:5000

   **Example response**:

   .. sourcecode:: http

      HTTP/1.0 200 OK
      Content-Length: 1137
      Content-Type: application/json

      {
          "test": {
              "created_at": "2016-02-19T11:01:47.282132",
              "data": {},
              "id": "51cad1bf-f7b4-4ebe-865f-6d19e8fd186f",
              "name": "tox",
              "team_id": "e78cf47c-12a7-4af7-bdb3-50352e6e32e1"
          }
      }

   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 200: no error
   :statuscode 404: test not found

.. http:post:: /api/v1/topics/<topic-id>/tests

   Attach a test to a topic (Only the super admin can do this)

   **Example request**:

   .. sourcecode:: http

      POST /api/v1/topics/27407592-19c3-47d6-9f8e-183358063376/tests HTTP/1.1
      Host: example.com
      Accept: application/json

      {
        "test_id": "51cad1bf-f7b4-4ebe-865f-6d19e8fd186f"
      }

   **Example response**:

   .. sourcecode:: http

      HTTP/1.0 201 CREATED
      Content-Length: 103
      Content-Type: application/json

      {
          "test_id": "51cad1bf-f7b4-4ebe-865f-6d19e8fd186f",
          "topic_id": "27407592-19c3-47d6-9f8e-183358063376"
      }

.. http:get:: /api/v1/topics/<topic-id>/tests

   Get all tests of a topic.

   **Example request**:

   .. sourcecode:: http

      GET /api/v1/topics/e78cf47c-12a7-4af7-bdb3-50352e6e32e1/tests HTTP/1.1
      Accept: application/json
      Content-Length: 0
      Host: 127.0.0.1:5000

   **Example response**:

   .. sourcecode:: http

      HTTP/1.0 200 OK
      Access-Control-Allow-Origin: *
      Content-Length: 3885
      Content-Type: application/json

      {
          "_meta": {
              "count": 2
          },
          "tests": [
              {
                  "created_at": "2016-02-19T11:01:47.279013",
                  "data": {},
                  "id": "599994de-3b77-4440-87da-2df31965f8bd",
                  "name": "tempest",
                  "topic_id": "e78cf47c-12a7-4af7-bdb3-50352e6e32e1"
              },
              {
                  "created_at": "2016-02-19T11:01:47.281001",
                  "data": {},
                  "id": "f640022c-495f-43c8-9952-ac2c7000e87d",
                  "name": "khaleesi-tempest",
                  "topic_id": "e78cf47c-12a7-4af7-bdb3-50352e6e32e1"
              }
          ]
      }
   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 200: no error
   :statuscode 400: bad request

.. http:post:: /api/v1/remotecis/<remoteci-id>/tests

   Attach a test to a remoteci (Only users in the remoteci's team can do it)

   **Example request**:

   .. sourcecode:: http

      POST /api/v1/remotecis/b39416e3-b903-46ea-a838-0b8673006fa7/tests HTTP/1.1
      Accept: application/json
      Content-Length: 51
      Content-Type: application/json

      {
          "test_id": "5738e238-2a5a-4215-b70a-93d3393c7406"
      }

   **Example response**:

   .. sourcecode:: http

      HTTP/1.0 201 CREATED
      Content-Length: 106
      Content-Type: application/json

      {
          "remoteci_id": "b39416e3-b903-46ea-a838-0b8673006fa7",
          "test_id": "5738e238-2a5a-4215-b70a-93d3393c7406"
      }


  .. http:get:: /api/v1/remotecis/<remoteci-id>/tests

     Get all tests of a Remote CI.

   **Example request**:

     .. sourcecode:: http

        GET /api/v1/remotecis/b39416e3-b903-46ea-a838-0b8673006fa7/tests HTTP/1.1
        Accept: application/json
        Content-Length: 0
        Host: 127.0.0.1:5000

   **Example response**:

     .. sourcecode:: http

        HTTP/1.0 200 OK
        X-Requested-With
        Content-Length: 283
        Content-Type: application/json

        {
            "_meta": {
                "count": 1
            },
            "tests": [
                {
                    "created_at": "2016-09-08T13:50:06.087575",
                    "data": null,
                    "id": "5738e238-2a5a-4215-b70a-93d3393c7406",
                    "name": "khaleesi-tempest",
                    "team_id": "59eec938-b58a-457b-a91a-a6faba9cc850"
                }
            ]
        }