Signature Authentication
========================

Signature Authentication is the authentication mechanism used to authenticate API requests originating from a RemoteCI client.

A RemoteCI client allow to have credentials dedicated to a RemoteCI shared with the members of a team (contrary to user credentials which should be kept personal).

A signed API requests allows to:

- Authenticate a request with:

  - a RemoteCI ID,
  - an API secret.

- Secured against modification during transit as all its content is signed.

- Secured aginst replay by carrying a timestamp (which is also part of the signed content) which must fit in ± 5 minutes around the reception of the request on the server.

Implementation
--------------

Along each request, the client must add the two following HTTP headers:

- ``DCI-Client-Info``
- ``DCI-Auth-Signature``

They are build as following

DCI-Client-Info
^^^^^^^^^^^^^^^

It should look like: ``DCI-Client-Info: <timestamp>/remoteci/<remoteci_id>`` with:

- ``<timestamp>``: the current client timestamp in `UTC timezone` with the following format: ``YYYY-MM-DD HH:MI:SSZ`` (e.g.: ``2017-06-12 14:29:17Z``)
- ``<remoteci_id>``: the RemoteCI ID found in the RemoteCI description

DCI-Auth-Signature
^^^^^^^^^^^^^^^^^^

The signature header ``DCI-Auth-Signature: <signature>`` is obtained with:

- ``<signature>``: ``hexdigest( HMAC-SHA256( <api secret>, <string_to_sign>.encode('utf-8') ) )``
- ``<api secret>``: the API Secret found in the RemoteCI description
- ``<stringtosign>``::

    <HTTP Verb> + "\n"
    <Content-Type> + "\n"
    <timestamp> + "\n"
    <url> + "\n"
    <query_string> + "\n"
    <payload hash>


  - ``<HTTP Verb>``: the HTTP method used `in uppercase`
  - ``<Content-Type>``: Usually ``application/json`` for API calls
  - ``<timestamp>``: as previously, the client timestamp in `UTC timezone` with the following format: ``YYYY-MM-DD HH:MI:SSZ``
  - ``<url>``: the API resource url, without query string (e.g.: ``https://distributed-ci.io/api/v1/job/1231231123123123213/``)
  - ``<query_string>``: the parameter passed when querying (the part after the ``?`` in the full URL)
  - ``<payload hash>``: ``hexdigest( SHA256( payload ) )``
