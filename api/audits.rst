Audits
======

.. http:get:: /api/v1/audits

   Get all logs from users

   **Example request**:

   .. sourcecode:: http

      GET /api/v1/audits HTTP/1.1
      Host: example.com
      Accept: application/json

   **Example response**:

   .. sourcecode:: http

      HTTP/1.1 200 OK
      Connection: Keep-Alive
      Content-Length: 2704
      Content-Type: application/json

      {
        "_meta": {
          "count": 1
        },
        "audits":
        [
          {
            "action": "create_teams",
            "created_at": "2016-03-02T08:31:08.971546",
            "id": "ef08ec2b-b0ff-43d9-992b-4e17088678c2",
            "team_id": "73de0e1f-6904-40e8-82c7-9bc49989cb86",
            "user_id": "88e55e36-98ac-4590-a849-e1b21ed257d3"
          }
        ]
      }

   :jsonparam action: the action called
   :jsonparam created_at: the time and date when the action was called
   :jsonparam user_id: which user called this action
   :jsonparam team_id: in which team is this user
   :reqheader Authorization: Basic authentication credentials
   :resheader Content-Type: application/json
   :statuscode 200: no error
   :statuscode 401: unauthorized
