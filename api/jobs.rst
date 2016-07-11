Jobs
====

.. http:post:: /api/v1/jobs

   Create a new job.

   **Example request**:

   .. sourcecode:: http

      POST /api/v1/jobs HTTP/1.1
      Host: 127.0.0.1:5000
      Accept: application/json
      Authorization: Basic YWRtaW46YWRtaW4=
      Content-Type: application/json

      {
        "comment": "some comment",
        "recheck": true,
        "remoteci_id": "68bf9302-e9f7-41fb-89a1-823516dac13b",
        "jobdefinition_id": "d4344452-f367-4b16-b0dd-fca87571e384",
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
        "job": {
          "id": "cbd0ad1b-1f4b-4056-8c82-27ff9511e37f",
          "etag": "f6cad3d32fde30a7a4b2beeed4002705",
          "status": "new",
          "comment": "some comment",
          "recheck": true,
          "created_at": "2016-02-25T13:32:41.706080",
          "updated_at": "2016-02-25T13:32:41.706080",
          "remoteci_id": "68bf9302-e9f7-41fb-89a1-823516dac13b",
          "jobdefinition_id": "d4344452-f367-4b16-b0dd-fca87571e384",
          "team_id": "0c6b70b0-ae41-461a-af89-a2bd408b43f5"
        }
      }

   :jsonparam comment: Optional comment the user can write about the job
   :jsonparam recheck (boolean): Optional whether the job need to be rechecked or not
   :jsonparam remoteci_id: ID of the remote CI associated to the job
   :jsonparam jobdefinition_id: ID of the job definition associated to the job
   :jsonparam team_id: ID of the team whom the job belongs
   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :resheader ETag: f6cad3d32fde30a7a4b2beeed4002705
   :statuscode 201: no error
   :statuscode 400: error on request data, request is malformed,
     see payload for informations
   :statuscode 401: unauthorized

.. http:post:: /api/v1/jobs/schedule

   Schedule a job running.

   **Example request**: TODO: complete this

.. http:post:: /api/v1/jobs/recheck

   Schedule a job recheck.

   **Example request**: TODO: complete this


.. http:put:: /api/v1/jobs/<job-id>

   Update a job.

   **Example request**:

   .. sourcecode:: http

      PUT /api/v1/jobs/cbd0ad1b-1f4b-4056-8c82-27ff9511e37f HTTP/1.1
      Accept: application/json
      ETag: f6cad3d32fde30a7a4b2beeed4002705
      Authorization: Basic YWRtaW46YWRtaW4=
      Content-Length: 16
      Content-Type: application/json
      Host: 127.0.0.1:5000

      {
        "comment": "comment updated",
        "status": "running"
      }

   **Example response**:

   .. sourcecode:: http


      HTTP/1.0 204 NO CONTENT
      Access-Control-Allow-Origin: *
      Content-Length: 0
      Content-Type: application/json
      Date: Thu, 25 Feb 2016 13:38:44 GMT
      Server: Werkzeug/0.10.4 Python/2.7.10


   :jsonparam comment: (Optionnal) updated comment of the job
   :jsonparam status: (Optionnal) updated status of the job
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
   :statuscode 422: error on request data, maybe a conflict

   **Note**: You must provide an ETag header in order to make the API call
   works. If not an error will be issued. The response ETag value is also
   being updated.

.. http:delete:: /api/v1/jobs/<job-id>

   Delete a job. This action can only be done by the administrator of
   the team.

   **Example request**:

   .. sourcecode:: http

      DELETE /api/v1/jobs/cbd0ad1b-1f4b-4056-8c82-27ff9511e37f HTTP/1.1
      Accept: application/json
      ETag: a453c6e026f5b028c72f84e5684fc07d
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

.. http:get:: /api/v1/jobs/<job-id>

   Get a job.

   **Example request**:

   .. sourcecode:: http

      GET /api/v1/jobs/660abf0b998bf17842f376ca6def6eae HTTP/1.1
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
        "job": {
          "id": "cbd0ad1b-1f4b-4056-8c82-27ff9511e37f",
          "etag": "f6cad3d32fde30a7a4b2beeed4002705",
          "status": "new",
          "comment": "some comment",
          "recheck": true,
          "created_at": "2016-02-25T13:32:41.706080",
          "updated_at": "2016-02-25T13:32:41.706080",
          "remoteci_id": "68bf9302-e9f7-41fb-89a1-823516dac13b",
          "jobdefinition_id": "d4344452-f367-4b16-b0dd-fca87571e384",
          "team_id": "0c6b70b0-ae41-461a-af89-a2bd408b43f5"
        }
      }

   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 200: no error
   :statuscode 401: unauthorized
   :statuscode 404: not found


.. http:get:: /api/v1/jobs/<job-id>/results

   Get all results for a specific job.

   **Example request**:

   .. sourcecode:: http

      GET /api/v1/jobs/660abf0b998bf17842f376ca6def6eae/results HTTP/1.1
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
        "_meta": {
          "count": 1
        },
        "results": {
          "res_junit.xml": {
            "errors": "0",
            "failures": "0",
            "name": "pytest",
            "skips": "1",
            "success": 2,
            "time": "46.050",
            "total": "3"
          }
        }
      }

   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 200: no error
   :statuscode 401: unauthorized
   :statuscode 404: not found


.. http:get:: /api/v1/jobs/<job-id>/files

   Get all files for a specific job.

   **Example request**:

   .. sourcecode:: http

      GET /api/v1/jobs/660abf0b998bf17842f376ca6def6eae/files HTTP/1.1
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
        "_meta": {
            "count": 2
        },
        "files": [
          {
            "content": "Hello World",
            "created_at": "2016-02-25T08:07:09.268025",
            "id": "e687379d-89b6-42db-a7be-5e6e3b49c00a",
            "jobstate_id": "1fac28dc-d6bc-4511-af21-a226a18037cd",
            "md5": "fcb751e7f6a92c69a6d86d351116974f",
            "mime": "text/plain",
            "name": "bar_quux.txt",
            "team_id": "99635d6a-1f8e-4090-aa49-01e41c41c0ec"
          },
          {
            "content": "this is file fubar_quux_norf",
            "created_at": "2016-02-25T08:07:09.268789",
            "id": "33e60a67-afe4-44eb-b503-d4e7f9bf6efe",
            "jobstate_id": "1fac28dc-d6bc-4511-af21-a226a18037cd",
            "md5": "660abf0b998bf17842f376ca6def6eae",
            "mime": "text/plain",
            "name": "fubar_quux_norf.txt",
            "team_id": "99635d6a-1f8e-4090-aa49-01e41c41c0ec"
          }
        ]
      }

   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 200: no error
   :statuscode 401: unauthorized
   :statuscode 404: not found


.. http:post:: /api/v1/jobs/<job-id>/files

   Create a new file for a specific job.

   **Example request**:

   .. sourcecode:: http

      POST /api/v1/jobs/660abf0b998bf17842f376ca6def6eae/files HTTP/1.1
      Host: example.com
      Accept: application/json
      Authorization: Basic YWRtaW46YWRtaW4=

      {
        "content": "helloworld",
        "jobstate_id": "1fac28dc-d6bc-4511-af21-a226a18037cd",
        "mime": "text/plain",
        "name": "helloworld.txt"
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
        "file": {
          "content": "helloworld",
          "created_at": "2016-02-25T13:32:41.706080",
          "id": "cbd0ad1b-1f4b-4056-8c82-27ff9511e37f",
          "jobstate_id": "1fac28dc-d6bc-4511-af21-a226a18037cd",
          "md5": null,
          "mime": "text/plain",
          "name": "helloworld.txt",
          "team_id": "0c6b70b0-ae41-461a-af89-a2bd408b43f5"
        }
      }

   :jsonparam content: Content of the file
   :jsonparam jobstate_id: ID of the jobstate to attach the file to
   :jsonparam mime: MIME type of the file
   :jsonparam name: Name of the file
   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 201: no error
   :statuscode 422: error on request data, maybe a conflict

.. http:get:: /api/v1/jobs/<job-id>/jobstates

   Get all jobstates for a specific job.

   **Example request**:

   .. sourcecode:: http

      GET /api/v1/jobs/d4344452-f367-4b16-b0dd-fca87571e384/jobstates HTTP/1.1
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
            "job_id": "d4344452-f367-4b16-b0dd-fca87571e384"
          }
        ]
      }

   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 200: no error
   :statuscode 401: unauthorized
   :statuscode 404: not found

.. http:get:: /api/v1/jobs

   Get all jobs. This request is scoped to the user team.

   **Example request**:

   .. sourcecode:: http

      GET /api/v1/jobs HTTP/1.1
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
        "jobs": [
          {
            "id": "cbd0ad1b-1f4b-4056-8c82-27ff9511e37f",
            "etag": "f6cad3d32fde30a7a4b2beeed4002705",
            "status": "new",
            "comment": "some comment",
            "recheck": true,
            "created_at": "2016-02-25T13:32:41.706080",
            "updated_at": "2016-02-25T13:32:41.706080",
            "remoteci_id": "68bf9302-e9f7-41fb-89a1-823516dac13b",
            "jobdefinition_id": "d4344452-f367-4b16-b0dd-fca87571e384",
            "team_id": "0c6b70b0-ae41-461a-af89-a2bd408b43f5"
          }, {
            "id": "95691d7f-d09e-427e-9230-e08063f6ba33",
            "etag": "ade963cd93e892f2a5979fba78f9bc71",
            "status": "running",
            "comment": "some other comment",
            "recheck": false,
            "created_at": "2016-02-25T13:32:41.706080",
            "updated_at": "2016-02-25T13:32:41.706080",
            "remoteci_id": "68bf9302-e9f7-41fb-89a1-823516dac13b",
            "jobdefinition_id": "ca9ea007-1541-42d3-8207-f120611182f5",
            "team_id": "0c6b70b0-ae41-461a-af89-a2bd408b43f5"
          }
        ]
      }

   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 200: no error
   :statuscode 401: unauthorized
