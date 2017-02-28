Jobdefinitions
==============

.. http:post:: /api/v1/jobdefinitions

   Create a jobdefinition.

   **Example request**:

   .. sourcecode:: http

      POST /api/v1/jobdefinitions HTTP/1.1
      Accept: application/json
      Content-Length: 22
      Content-Type: application/json
      Host: example.com

      {
          "name": "jobdefinition_name",
          "priority": "100",
          "topic_id": "8621c080-9dce-47eb-ae8b-c47ea1caadc5",
          "test_id": "3e4224bd-7587-4390-898f-6390637caf7e",
          "component_types": ["puddle_osp", "puddle_ospd"]
      }

   **Example response**:

   .. sourcecode:: http

      HTTP/1.0 201 CREATED
      Content-Length: 123
      Content-Type: application/json

      {
          "jobdefinition": {
              "created_at": "2016-02-24T11:31:55.001974",
              "updated_at": "2016-02-24T11:31:55.001974",
              "topic_id": "8621c080-9dce-47eb-ae8b-c47ea1caadc5",
              "test_id": "3e4224bd-7587-4390-898f-6390637caf7e",
              "etag": "e78cf47c-12a7-4af7-bdb3-50352e6e32e1",
              "name": "jobdefinition_name",
              "id": "f640022c-495f-43c8-9952-ac2c7000e87d",
              "priority": "100",
              "component_types": ["puddle_osp", "puddle_ospd"]
          }
      }


   :jsonparam name: name of the jobdefinition
   :jsonparam priority: priority of the jobdefinition
   :jsonparam test_id: Test id the jobdefinition is attached to
   :jsonparam topic_id: Topic id the jobdefinition is attached to
   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 201: no error
   :statuscode 409: error on request data, maybe a conflict


.. http:delete:: /api/v1/jobdefinitions/<jobdefinition-id>

   Delete a jobdefinition.

   **Example request**:

   .. sourcecode:: http

      DELETE /api/v1/jobdefinitions/f640022c-495f-43c8-9952-ac2c7000e87d HTTP/1.1
      Accept: application/json
      Connection: keep-alive
      Content-Length: 0
      Host: example.com

   **Example response**:

   .. sourcecode:: http

      HTTP/1.0 204 NO CONTENT
      Content-Type: application/json

   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 204: no error
   :statuscode 409: error on topic id, maybe a conflict

.. http:get:: /api/v1/jobdefinitions/<jobdefinition-id>

   Get a jobdefinition.

   **Example request**:

   .. sourcecode:: http

      GET /api/v1/jobdefinitions/f640022c-495f-43c8-9952-ac2c7000e87d HTTP/1.1
      Accept: application/json
      Connection: keep-alive

   **Example response**:

   .. sourcecode:: http

      HTTP/1.0 200 OK
      Content-Length: 143
      Content-Type: application/json

      {
          "jobdefinition": {
              "created_at": "2016-02-24T11:31:55.001974",
              "updated_at": "2016-02-24T11:31:55.001974",
              "topic_id": "8621c080-9dce-47eb-ae8b-c47ea1caadc5",
              "test_id": "3e4224bd-7587-4390-898f-6390637caf7e",
              "etag": "e78cf47c-12a7-4af7-bdb3-50352e6e32e1",
              "name": "jobdefinition_name",
              "id": "f640022c-495f-43c8-9952-ac2c7000e87d",
              "priority": "100",
              "component_types": ["puddle_osp", "puddle_ospd"]
          }
      }


   :reqheader Accept: application/json
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 200: no error
   :statuscode 404: topic not found
