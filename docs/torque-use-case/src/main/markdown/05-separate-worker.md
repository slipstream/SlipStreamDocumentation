Separate Worker
===============

Introduction
============

As a first step towards the final configuration, we will run a worker on
one node and a combined server and client on a second node. This will
allow us to start dealing with synchronization issues between the
machines. This is a common problem when bringing up and then testing
n-tier systems.

Worker Configuration
====================

Essentially the execute and report scripts simply take the
worker-related parts from the monolithic configuration. The execute
script is the following:

    TODO

The reports script is the following:

    TODO

The only change in the configuration is to make sure that the server
name is used to configuration the pbs\_mom service. This is done by
explicitly providing the server in the property name.

Server and Client Configuration
===============================

Again the scripts look very similar to those for the monolithic
configuration, except with the worker configuration removed. The execute
script is:

    TODO

and the reports script is:

    TODO

The primary difference is that we must identify the worker node to
include in the Torque nodes file. This is again done with an explicit
reference to the worker machine.

Deployment
==========

The deployment will now consist of two machines. This is the first
multi-machine deployment and shows that cross-machine synchronization
can be used to ensure that the ensemble is in the proper state.
