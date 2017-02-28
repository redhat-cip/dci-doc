Remote CIs
==========

.. http:post:: /api/v1/remotecis

   Create a new remote CI.

   **Example request**:

   .. sourcecode:: http

      POST /api/v1/remotecis HTTP/1.1
      Host: 127.0.0.1:5000
      Accept: application/json
      Authorization: Basic YWRtaW46YWRtaW4=
      Content-Type: application/json

      {
        "name": "remoteci_name",
        "active": true,
        "data": {"some data": "foo"},
        "team_id": "0c6b70b0-ae41-461a-af89-a2bd408b43f5"
      }

   **Example response**:

   .. sourcecode:: http


      HTTP/1.0 201 CREATED
      Access-Control-Allow-Origin: *
      Content-Length: 276
      Content-Type: application/json
      Date: Tue, 23 Feb 2016 13:55:32 GMT
      Server: Werkzeug/0.10.4 Python/2.7.6

      {
        "remoteci": {
          "id": "cbd0ad1b-1f4b-4056-8c82-27ff9511e37f",
          "name": "remoteci_name",
          "active": true,
          "data": {"foo": "bar"},
          "etag": "f6cad3d32fde30a7a4b2beeed4002705",
          "created_at": "2016-02-25T13:32:41.706080",
          "updated_at": "2016-02-25T13:32:41.706080",
          "team_id": "1fac28dc-d6bc-4511-af21-a226a18037cd"
        }
      }

   :jsonparam name: Name of the remote CI
   :jsonparam boolean active: optional remote CI state
    (will be set to true as default)
   :jsonparam JSON data: Some additional data
   :jsonparam team_id: ID of the team whom the remote CI belongs
   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :resheader ETag: f6cad3d32fde30a7a4b2beeed4002705
   :statuscode 201: no error
   :statuscode 400: error on request data, request is malformed,
     see payload for informations
   :statuscode 401: unauthorized
   :statuscode 409: error on request data, maybe a conflict

.. http:put:: /api/v1/remotecis/<remoteci-id>

   Update a remote CI.

   **Example request**:

   .. sourcecode:: http

      PUT /api/v1/remotecis/cbd0ad1b-1f4b-4056-8c82-27ff9511e37f HTTP/1.1
      Accept: application/json
      Authorization: Basic YWRtaW46YWRtaW4=
      Content-Length: 16
      Content-Type: application/json
      Host: 127.0.0.1:5000

      {
        "name": "remoteci_name_updated",
        "active": false,
        "data": {"foo": "bar updated"}
      }

   **Example response**:

   .. sourcecode:: http


      HTTP/1.0 204 NO CONTENT
      Access-Control-Allow-Origin: *
      Content-Length: 0
      Content-Type: application/json
      Date: Thu, 25 Feb 2016 13:38:44 GMT
      Server: Werkzeug/0.10.4 Python/2.7.10


   :jsonparam name: Updated name of the remote CI
   :jsonparam boolean active: Updated state of the remote CI
   :jsonparam JSON data: Updated data of the remote CI
   :jsonparam team_id: ID of the team whom the remote CI belongs
   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :reqheader ETag: f6cad3d32fde30a7a4b2beeed4002705
   :resheader Content-Type: application/json
   :resheader ETag: a453c6e026f5b028c72f84e5684fc07d
   :statuscode 201: no error
   :statuscode 400: error on request data, request is malformed,
    see payload for informations
   :statuscode 401: unauthorized
   :statuscode 404: not found
   :statuscode 409: error on request data, maybe a conflict

   **Note**: You must provide an ETag header in order to make the API call
   works. If not an error will be issued. The response ETag value is also
   being updated.

.. http:delete:: /api/v1/remotecis/<remoteci-id>

   Delete a remote CI. This action can only be done by the administrator of the
   team or by the administrator of the application.

   **Example request**:

   .. sourcecode:: http

      DELETE /api/v1/remotecis/cbd0ad1b-1f4b-4056-8c82-27ff9511e37f HTTP/1.1
      Accept: application/json
      Authorization: Basic YWRta321YWetaW4=
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
   :reqheader ETag: a453c6e026f5b028c72f84e5684fc07d
   :resheader Content-Type: application/json
   :statuscode 204: no error
   :statuscode 401: unauthorized
   :statuscode 404: not found

.. http:get:: /api/v1/remotecis/<remoteci-id>

   Get a remote CI.

   **Example request**:

   .. sourcecode:: http

      GET /api/v1/remotecis/660abf0b998bf17842f376ca6def6eae HTTP/1.1
      Accept: application/json
      Authorization: Basic YWRta321YWetaW4=
      Content-Length: 0
      Host: 127.0.0.1:5000

   **Example response**:

   .. sourcecode:: http

      HTTP/1.0 200 OK
      Content-Length: 1137
      Content-Type: application/json

      {
        "remoteci": {
          "id": "cbd0ad1b-1f4b-4056-8c82-27ff9511e37f",
          "name": "remoteci_name",
          "active": true,
          "data": {"foo": "bar"},
          "etag": "f6cad3d32fde30a7a4b2beeed4002705"
          "created_at": "2016-02-25T13:32:41.706080",
          "updated_at": "2016-02-25T13:32:41.706080",
          "team_id": "1fac28dc-d6bc-4511-af21-a226a18037cd"
        }
      }


   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 200: no error
   :statuscode 401: unauthorized
   :statuscode 404: remoteci not found


.. http:get:: /api/v1/remotecis

   Get all remote CIs. This request will be scoped to your team, it is
   not possible to visualize remote CIs of another team.

   **Example request**:

   .. sourcecode:: http

      GET /api/v1/remotecis HTTP/1.1
      Accept: application/json
      Authorization: Basic YWRta321YWetaW4=
      Content-Length: 0
      Host: 127.0.0.1:5000

   **Example response**:

   .. sourcecode:: http

      HTTP/1.0 200 OK
      Access-Control-Allow-Origin: *
      Content-Length: 3961
      Content-Type: application/json

      {
          "_meta": {
              "count": 2
          },
          "remotecis": [
            {
              "id": "cbd0ad1b-1f4b-4056-8c82-27ff9511e37f",
              "name": "remoteci_name",
              "active": true,
              "data": {"foo": "bar"},
              "etag": "f6cad3d32fde30a7a4b2beeed4002705"
              "created_at": "2016-02-25T13:32:41.706080",
              "updated_at": "2016-02-25T13:32:41.706080",
              "team_id": "1fac28dc-d6bc-4511-af21-a226a18037cd"
            },
            {
              "id": "ffa89647-43d1-4ad5-b4b8-006aa66c6cd1",
              "name": "other_remoteci_name",
              "active": false,
              "data": {"other foo": "other bar"},
              "etag": "694a88d7dcd9c86bc9b0c72914b4328e"
              "created_at": "2016-02-25T13:32:41.706080",
              "updated_at": "2016-02-25T13:32:41.706080",
              "team_id": "1fac28dc-d6bc-4511-af21-a226a18037cd"
            }
        ]
      }

   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 200: no error
   :statuscode 401: unauthorized
