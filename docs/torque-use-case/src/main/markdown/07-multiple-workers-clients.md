Multiple Workers and Clients
============================

Introduction
============

Production systems almost always contain large numbers of workers and
clients. Very often problems with services are revealed when increasing
the number of clients or number of resources in the system. To show how
to move to a larger deployment to test scalability issues, we modify the
previous deployment to include 3 workers and 2 clients.

Machine Configuration
=====================

Because we have already anticipated that there will be multiple workers
and multiple clients, the machine configurations are identical to those
in the previous case.

Deployment
==========

This deployment will consist of 6 machines in total: 3 workers, 2
clients, and 1 server. However, the description of the deployment is
nearly identical to the previous one, except that the multiplicity of
the workers is set to 3 and that of the clients, to 2. There are no
other changes needed in the deployment.

The returned reports will be provided per machine. In this case, the
logs from the 3 workers will be provided as well as the logs from the 2
clients.
