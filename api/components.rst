Components
==========

.. http:post:: /api/v1/components

   Create a component.

   **Example request**:

   .. sourcecode:: http

      POST /api/v1/components HTTP/1.1
      Host: example.com
      Accept: application/json
      Authorization: Basic YWRta321YWetaW4=

      {
        "name": "component_name",
        "topic_id": "e78cf47c-12a7-4af7-bdb3-50352e6e32e1"
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
        "component": {
          "created_at": "2016-02-23T13:55:32.512778",
          "data": {},
          "id": "3e4224bd-7587-4390-898f-6390637caf7e",
          "name": "ptdr",
          "topic_id": "e78cf47c-12a7-4af7-bdb3-50352e6e32e1"
        }
      }

   :jsonparam name: name of the component
   :jsonparam topic_id: the id of the topic related to the component
   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 201: no error
   :statuscode 422: error on request data, maybe a conflict

.. http:delete:: /api/v1/components/<component-id>

   Delete a component.

   **Example request**:

   .. sourcecode:: http

      DELETE /api/v1/components/a47c2ba1-9582-4e9b-ae89-f518eda895fe HTTP/1.1
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
   :statuscode 422: error on component id, maybe a conflict

.. http:get:: /api/v1/components/<component-id>

   Get a component.

   **Example request**:

   .. sourcecode:: http

      GET /api/v1/components/a47c2ba1-9582-4e9b-ae89-f518eda895fe HTTP/1.1
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
          "component": {
              "canonical_project_name": "DCI-control-server - Rocky Pluto",
              "created_at": "2016-02-25T08:06:58.272061",
              "data": {},
              "git": null,
              "id": "a47c2ba1-9582-4e9b-ae89-f518eda895fe",
              "message": "rocky-pluto",
              "name": "DCI-control-server-4",
              "ref": "",
              "sha": "952b15805c75c2fc7c1207874327e8c04a6bc0e5",
              "title": "Rocky Pluto",
              "type": "package",
              "topic_id": "e78cf47c-12a7-4af7-bdb3-50352e6e32e1",
              "url": "https://github.com/rocky-pluto/commit/952b15805c75c2fc7c1207874327e8c04a6bc0e5"
        }
      }


   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 200: no error
   :statuscode 404: component not found


.. http:get:: /api/v1/topics/<topic-id>/components

   Get all components of a topic.

   **Example request**:

   .. sourcecode:: http

      GET /api/v1/topics/e78cf47c-12a7-4af7-bdb3-50352e6e32e1/components HTTP/1.1
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
          "components": [
              {
                  "canonical_project_name": "DCI-control-server - Rocky Pluto",
                  "created_at": "2016-02-25T08:06:58.272061",
                  "data": {},
                  "git": null,
                  "id": "a47c2ba1-9582-4e9b-ae89-f518eda895fe",
                  "message": "rocky-pluto",
                  "name": "DCI-control-server-4",
                  "ref": "",
                  "sha": "952b15805c75c2fc7c1207874327e8c04a6bc0e5",
                  "title": "Rocky Pluto",
                  "type": "package",
                  "topic_id": "e78cf47c-12a7-4af7-bdb3-50352e6e32e1",
                  "url": "https://github.com/rocky-pluto/commit/952b15805c75c2fc7c1207874327e8c04a6bc0e5"
              },
              {
                  "canonical_project_name": "DCI-control-server - Rocky Pluto Helper",
                  "created_at": "2016-02-25T08:06:58.272061",
                  "data": {},
                  "git": null,
                  "id": "123e4567-e89b-12d3-a456-426655440000",
                  "message": "Rocky pluto helper description",
                  "name": "rocky-pluto-helper",
                  "ref": "",
                  "sha": "",
                  "title": "Rocky Pluto Helper",
                  "type": "package",
                  "topic_id": "e78cf47c-12a7-4af7-bdb3-50352e6e32e1",
                  "url": "https://github.com/rocky-pluto-helper/commit/4574efc69dbde511fc873ac1cacbec21bedc1f3c"
              }
          ]
      }

   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 200: no error
   :statuscode 400: bad request

.. http:get:: /api/v1/topics/<topic-id>/components/<component-id>/jobs

   Get all jobs from a components in a topic.

   **Example request**:

   .. sourcecode:: http

      GET /api/v1/topics/e78cf47c-12a7-4af7-bdb3-50352e6e32e1/components/123e4567-e89b-12d3-a456-426655440000/jobs HTTP/1.1
      Accept: application/json
      Authorization: Basic YWRta321YWetaW4=
      Content-Length: 0
      Host: 127.0.0.1:5000

   **Example response**:

   .. sourcecode:: http

      {
          "_meta": {
              "count": 140
          }, 
          "jobs": [
              {
                  "comment": null, 
                  "configuration": {}, 
                  "created_at": "2016-07-06T16:06:52.051195", 
                  "etag": "a648856530d8a04ada16e2157d26042a", 
                  "id": "de2b2d59-d58d-406f-b6b2-f31c3895cae8", 
                  "jobdefinition_id": "2ba03e3b-8a7e-4df4-ac10-543c37876292", 
                  "recheck": false, 
                  "remoteci_id": "d7cebe5b-1785-4052-9f7f-b747e5dfbda7", 
                  "status": "new", 
                  "team_id": "d4bd6bd7-4a61-4043-b8c7-5f6c1d86d965", 
                  "updated_at": "2016-07-06T16:06:52.051195"
              },
	      ....
          ]
      }

