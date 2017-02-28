Job States
==========

.. http:post:: /api/v1/jobstates

   Create a new job state.

   **Example request**:

   .. sourcecode:: http

      POST /api/v1/jobstates HTTP/1.1
      Host: 127.0.0.1:5000
      Accept: application/json
      Authorization: Basic YWRtaW46YWRtaW4=
      Content-Type: application/json

      {
        "status": "new",
        "comment": "some comment",
        "team_id": "0c6b70b0-ae41-461a-af89-a2bd408b43f5",
        "job_id": "d4344452-f367-4b16-b0dd-fca87571e384"
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
        "jobstate": {
          "id": "cbd0ad1b-1f4b-4056-8c82-27ff9511e37f",
          "status": "new",
          "comment": "some comment",
          "created_at": "2016-02-25T13:32:41.706080",
          "team_id": "0c6b70b0-ae41-461a-af89-a2bd408b43f5",
          "job_id": "d4344452-f367-4b16-b0dd-fca87571e384"
        }
      }

   :jsonparam name: Name of the job state
   :jsonparam enum status: Status of the job state, can be one of the following
    values: ``new``, ``pre-run``, ``running``, ``post-run``, ``success``,
    ``failure``
   :jsonparam comment: Optional comment the user can write about the job
   :jsonparam job_id: ID of the job whom the job state belongs
   :jsonparam team_id: ID of the team whom the job state belongs
   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :resheader ETag: f6cad3d32fde30a7a4b2beeed4002705
   :statuscode 201: no error
   :statuscode 400: error on request data, request is malformed,
     see payload for informations
   :statuscode 401: unauthorized
   :statuscode 409: error on request data, maybe a conflict

.. http:delete:: /api/v1/jobstates/<jobstate-id>

   Delete a job state. This action can only be done by the administrator of the
   team or by the administrator of the application.

   **Example request**:

   .. sourcecode:: http

      DELETE /api/v1/jobstates/cbd0ad1b-1f4b-4056-8c82-27ff9511e37f HTTP/1.1
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

.. http:get:: /api/v1/jobstates/<jobstate-id>

   Get a job state.

   **Example request**:

   .. sourcecode:: http

      GET /api/v1/jobstates/cbd0ad1b-1f4b-4056-8c82-27ff9511e37f HTTP/1.1
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
        "jobstate": {
          "id": "cbd0ad1b-1f4b-4056-8c82-27ff9511e37f",
          "status": "new",
          "comment": "some comment",
          "created_at": "2016-02-25T13:32:41.706080",
          "team_id": "0c6b70b0-ae41-461a-af89-a2bd408b43f5",
          "job_id": "d4344452-f367-4b16-b0dd-fca87571e384"
        }
      }


   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 200: no error
   :statuscode 401: unauthorized
   :statuscode 404: jobstate not found


.. http:get:: /api/v1/jobstates

   Get all job states. This request will be scoped to your team, it is
   not possible to visualize job states of another team.

   **Example request**:

   .. sourcecode:: http

      GET /api/v1/jobstates HTTP/1.1
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
          "jobstates": [
            {
              "id": "cbd0ad1b-1f4b-4056-8c82-27ff9511e37f",
              "status": "new",
              "comment": "some comment",
              "created_at": "2016-02-25T13:32:41.706080",
              "team_id": "0c6b70b0-ae41-461a-af89-a2bd408b43f5",
              "job_id": "d4344452-f367-4b16-b0dd-fca87571e384"
            },
            {
              "id": "5bd0e63a-0237-4444-9f2b-6e29d1681904",
              "status": "success",
              "comment": "some other comment",
              "created_at": "2016-02-25T13:32:41.706080",
              "team_id": "0c6b70b0-ae41-461a-af89-a2bd408b43f5",
              "job_id": "5a0fb990-db97-4ae5-b5f9-7a4440e62a25"
            }
        ]
      }

   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 200: no error
   :statuscode 401: unauthorized
