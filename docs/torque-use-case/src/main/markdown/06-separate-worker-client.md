Separate Worker and Client
==========================

Introduction
============

Now we will place the three components of a batch system—server, client,
and worker—on three separate nodes. The configurations differ only
slightly from previous deployments, with the server and client
configurations split.

Worker Configuration
====================

The worker configuration is identical to the previous deployment.

Server Configuration
====================

The server configuration is similar to the previous deployment except
that the client configuration has been removed. In addition, the server
configuration must also include the list of clients that are authorized
to connect to the server.

    TODO

The reports script, as before, copies the Torque log files to the
reports area.

Client Configuration
====================

The client configuration is also similar to the previous deployment
except that the server configuration has been removed. Note that the
name of the batch server must be configured for the client.

    TODO

The reports script now copies all of the job output to the reports area.

Deployment
==========

The deployment will now consist of three machines. Again the
synchronization mechanisms are used to ensure that the services have
properly been initialized before starting the system tests.
