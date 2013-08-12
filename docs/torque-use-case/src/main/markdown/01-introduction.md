Introduction
============

Torque Batch System
===================

Torque is an open-source batch system maintained by [Cluster
Resources](http://www.clusterresources.com/). As for all batch systems,
Torque manages a set of distributed computing resources allowing
multiple users to run jobs (or tasks) on those resources. A full batch
system deployment contains a server for managing job submissions, a set
of workers for executing the jobs, and one or more clients from which
users submit jobs.

All of the modules for this use case can be found in the "Torque"
project.

Purpose
=======

The purpose of this use case is to show how SlipStream™ can be used to
build packages for Torque on a specific operating system and to test
those packages. This use case will install and configure those packages
in a variety of deployments, ensuring via a simple job submission that
the packages function correctly.

Scenarios
=========

The most complex scenario that we want to test will involve a torque
server, multiple (3) workers, and multiple (2) clients. The server,
workers, and clients will all be on separate machines that share a
common user configuration.

Rather than starting with the complex scenario, we will work up to it
starting from a simple, monolithic deployment and gradually increasing
the complexity. The scenarios that we will treat are:

-   Monolithic Deployment: A single machine will function as a server,
    worker, and client; the deployment will contain one machine.

-   Separate Worker: A machine will function as a server and a client. A
    separate machine will function as the worker. This deployment will
    contain two machines.

-   Separate Worker and Client: The server, worker, and client will each
    be on a separate machine. This deployment will contain three
    machines.

-   Multiple Workers and Clients: The deployment will contain 3 workers,
    2 clients, and 1 server all on separate machines. This deployment
    will contain 6 machines.

To determine that the system is working correctly, a test will submit
jobs from user accounts on the clients and verify that each job's
standard error and standard output contain the correct information. The
same test is used for all of the deployments.

To ensure that the packages are built correctly for the underlying
operating system, the Torque packages will be built from sources on the
base machine image. The generated packages will then be stored in
Amazon's S3 for later installation on the machines involved in the batch
system tests.
