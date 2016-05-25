Topics
======

.. http:post:: /api/v1/topics

   Create a topic.

   **Example request**:

   .. sourcecode:: http

      POST /api/v1/topics HTTP/1.1
      Accept: application/json
      Content-Length: 22
      Content-Type: application/json
      Host: 127.0.0.1:5000

      {
          "name": "topic_name"
      }

   **Example response**:

   .. sourcecode:: http

      HTTP/1.0 201 CREATED
      Content-Length: 123
      Content-Type: application/json

      {
          "topic": {
              "created_at": "2016-02-24T11:31:55.001974",
              "id": "8621c080-9dce-47eb-ae8b-c47ea1caadc5",
              "name": "topic_name"
          }
      }


   :jsonparam name: name of the topic
   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 201: no error
   :statuscode 422: error on request data, maybe a conflict

.. http:delete:: /api/v1/topics/<topic-id>

   Delete a topic.

   **Example request**:

   .. sourcecode:: http

      DELETE /api/v1/topics/8621c080-9dce-47eb-ae8b-c47ea1caadc5 HTTP/1.1
      Accept: application/json
      Connection: keep-alive
      Content-Length: 0
      Host: 127.0.0.1:5000

   **Example response**:

   .. sourcecode:: http

      HTTP/1.0 204 NO CONTENT
      Content-Type: application/json

   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 204: no error
   :statuscode 422: error on topic id, maybe a conflict

.. http:get:: /api/v1/topics/<topic-id>

   Get a topic.

   **Example request**:

   .. sourcecode:: http

      GET /api/v1/topics/f45deaa8-d1ca-4184-88ab-a9ed01e74f99 HTTP/1.1
      Accept: application/json
      Connection: keep-alive

   **Example response**:

   .. sourcecode:: http

      HTTP/1.0 200 OK
      Content-Length: 143
      Content-Type: application/json

      {
          "topic": {
              "created_at": "2016-02-24T11:37:16.396454",
              "id": "f45deaa8-d1ca-4184-88ab-a9ed01e74f99",
              "name": "topic_name"
          }
      }


   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 200: no error
   :statuscode 404: topic not found


.. http:get:: /api/v1/topics/user

   Get the topics of the current user.

   **Example request**:

   .. sourcecode:: http

      GET /api/v1/topics/user HTTP/1.1
      Accept: application/json
      Host: 127.0.0.1:5000

   **Example response**:

   .. sourcecode:: http

      HTTP/1.0 200 OK
      Content-Length: 329
      Content-Type: application/json

      {
          "_meta": {
              "count": 2
          },
          "topics": [
              {
                  "created_at": "2016-02-19T11:01:47.243499",
                  "id": "e78cf47c-12a7-4af7-bdb3-50352e6e32e1",
                  "name": "the_topic"
              },
              {
                  "created_at": "2016-02-19T11:02:49.547076",
                  "id": "4a1a87a5-43b8-4a28-8446-416e605a5c18",
                  "name": "mdr"
              }
          ]
      }

   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 200: no error
   :statuscode 404: topic not found


.. http:post:: /api/v1/topics/<topic-id>/teams

   Add a team to a topic.

   **Example request**:

   .. sourcecode:: http

      POST /api/v1/topics/f45deaa8-d1ca-4184-88ab-a9ed01e74f99/teams HTTP/1.1
      Accept: application/json
      Content-Length: 51
      Content-Type: application/json
      Host: 127.0.0.1:5000

      {
          "team_id": "d4bd2006-a0f7-4414-8059-b3a473054b65"
      }


   **Example response**:

   .. sourcecode:: http

      HTTP/1.0 201 CREATED
      Access-Control-Allow-Origin: *
      Content-Length: 0
      Content-Type: application/json

   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 201: no error
   :statuscode 400: bad request

.. http:delete:: /api/v1/topics/<topic-id>/teams/<team-id>

   Delete a team from a topic.

   **Example request**:

   .. sourcecode:: http

      DELETE /api/v1/topics/f45deaa8-d1ca-4184-88ab-a9ed01e74f99/teams/d4bd2006-a0f7-4414-8059-b3a473054b65 HTTP/1.1
      Accept: application/json
      Content-Length: 0
      Host: 127.0.0.1:5000

   **Example response**:

   .. sourcecode:: http

      HTTP/1.0 204 NO CONTENT
      Content-Length: 0
      Content-Type: application/json

   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 204: no error
   :statuscode 400: error on topic id or team id, maybe a conflict

.. http:get:: /api/v1/topics/<topic_id>/components/<component_id>/jobs

   Get all the jobs which rely on a specific component.

   **Example request**:

   .. sourcecode:: http

      GET /api/v1/topics/f45deaa8-d1ca-4184-88ab-a9ed01e74f99/components/0cc895f5-18af-45e7-a844-05e861bdc966/jobs HTTP/1.1
      Accept: application/json
      Content-Length: 0
      Host: 127.0.0.1:5000

   **Example response**:

   .. sourcecode:: http

      HTTP/1.0 200 OK
      Content-Length: 1606
      Content-Type: application/json

      {
          "_meta": {
          "count": 2
          },
          "jobs": [
              {
                  "comment": null,
                  "configuration": {},
                  "created_at": "2016-05-23T21:32:59.329834",
                  "etag": "21b290ceaacfa149f519df7aa4589273",
                  "id": "d88882a8-a82b-4f42-9985-7f990f71cab6",
                  "jobdefinition_id": "ad606326-0968-4230-963d-701688eb897f",
                  "recheck": false,
                  "remoteci_id": "41f0dc69-d619-4548-a672-ed26eb182c93",
                  "status": "pre-run",
                  "team_id": "921a7e52-d52a-491c-b959-fab151c0f6b4",
                  "updated_at": "2016-05-24T07:32:59.329862"
              },
              {
                  "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a diam lectus. Sed sit amet ipsum mauris. Maecenas congue ligula ac quam viverra nec consectetur ante hendrerit. Donec et mollis dolor. Praesent et diam eget libero egestas mattis sit amet vitae augue. Nam tincidunt congue enim, ut porta lorem lacinia consectetur. Donec ut libero sed arcu vehicula ultricies a non tortor.Lorem ipsum dolor sit amet, consectetur adipiscing elit.\nDonec a diam lectus. Sed sit amet ipsum mauris.\nMaecenas congue ligula ac quam viverra nec consectetur ante hendrerit.",
                  "configuration": {},
                  "created_at": "2016-05-24T07:32:59.335345",
                  "etag": "9928ecc7cd7e639967120a994fe189f4",
                  "id": "8dc276db-c82d-4432-baee-cbeb64f1d5c8",
                  "jobdefinition_id": "d139dff1-e8db-474d-b476-cafb82728cb0",
                  "recheck": false,
                  "remoteci_id": "41f0dc69-d619-4548-a672-ed26eb182c93",
                  "status": "new",
                  "team_id": "921a7e52-d52a-491c-b959-fab151c0f6b4",
                  "updated_at": "2016-05-24T11:32:59.335362"
              }
          ]
      }
