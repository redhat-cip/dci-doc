Files
=====

.. http:post:: /api/v1/files

   Create a file. The maximum size of an upload is controlled on the server
   side by the MAX_CONTENT_LENGTH configuration key. The default value is 20MB.

   **Example request**:

   .. sourcecode:: http

      POST /api/v1/files HTTP/1.1
      Host: example.com
      Accept: application/json
      Authorization: Basic YWRtaW46YWRtaW4=
      DCI-JOBSTATE-ID: 1fac28dc-d6bc-4511-af21-a226a18037cd
      DCI-MIME: text/plain
      DCI-NAME: helloworld.txt

      helloworld


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
          "created_at": "2016-02-25T13:32:41.706080",
          "id": "cbd0ad1b-1f4b-4056-8c82-27ff9511e37f",
          "jobstate_id": "1fac28dc-d6bc-4511-af21-a226a18037cd",
          "md5": null,
          "mime": "text/plain",
          "name": "helloworld.txt",
          "team_id": "0c6b70b0-ae41-461a-af89-a2bd408b43f5",
          "size": 10
        }
      }

   :reqheader DCI-JOBSTATE-ID: ID of the jobstate to attach the file to
   :reqheader DCI-MIME: MIME type of the file
   :reqheader DCI-NAME: Name of the file
   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 201: no error
   :statuscode 422: error on request data, maybe a conflict

.. http:delete:: /api/v1/files/<file-id>

   Delete a file.

   **Example request**:

   .. sourcecode:: http

      DELETE /api/v1/files/a47c2ba1-9582-4e9b-ae89-f518eda895fe HTTP/1.1
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
   :resheader Content-Type: application/json
   :statuscode 204: no error
   :statuscode 422: error on file id, maybe a conflict

.. http:get:: /api/v1/files/<file-id>

   Get a file.

   **Example request**:

   .. sourcecode:: http

      GET /api/v1/files/660abf0b998bf17842f376ca6def6eae HTTP/1.1
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
        "file": {
          "created_at": "2016-02-25T08:07:09.268789",
          "id": "33e60a67-afe4-44eb-b503-d4e7f9bf6efe",
          "jobstate_id": "1fac28dc-d6bc-4511-af21-a226a18037cd",
          "md5": "660abf0b998bf17842f376ca6def6eae",
          "mime": "text/plain",
          "name": "fubar_quux_norf.txt",
          "team_id": "99635d6a-1f8e-4090-aa49-01e41c41c0ec",
          "size": 12345
        }
      }


   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 200: no error
   :statuscode 404: file not found


.. http:get:: /api/v1/files

   Get all files.

   **Example request**:

   .. sourcecode:: http

      GET /api/v1/files HTTP/1.1
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
          "files": [
            {
              "created_at": "2016-02-25T08:07:09.268025",
              "id": "e687379d-89b6-42db-a7be-5e6e3b49c00a",
              "jobstate_id": "1fac28dc-d6bc-4511-af21-a226a18037cd",
              "md5": "fcb751e7f6a92c69a6d86d351116974f",
              "mime": "text/plain",
              "name": "bar_quux.txt",
              "team_id": "99635d6a-1f8e-4090-aa49-01e41c41c0ec",
              "size": 123
            },
            {
              "created_at": "2016-02-25T08:07:09.268789",
              "id": "33e60a67-afe4-44eb-b503-d4e7f9bf6efe",
              "jobstate_id": "1fac28dc-d6bc-4511-af21-a226a18037cd",
              "md5": "660abf0b998bf17842f376ca6def6eae",
              "mime": "text/plain",
              "name": "fubar_quux_norf.txt",
              "team_id": "99635d6a-1f8e-4090-aa49-01e41c41c0ec",
              "size": 234
            }
        ]
      }

   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 200: no error
   :statuscode 400: bad request

.. http:get:: /api/v1/files/<file-id>/content

   Get content of a file

   **Example request**:

   .. sourcecode:: http

      GET /api/v1/files/content HTTP/1.1
      Authorization: Basic YWRta321YWetaW4=
      Content-Length: 0
      Host: 127.0.0.1:5000

   **Example response**:

   .. sourcecode:: http

      HTTP/1.0 200 OK
      Access-Control-Allow-Origin: *
      Content-Length: 10
      Content-Type: text/plain

      helloworld

   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: text/plain
   :resheader Content-Length: length
   :statuscode 200: no error
   :statuscode 400: bad request
   :statuscode 404: file not found
   :statuscode 500: internal error
