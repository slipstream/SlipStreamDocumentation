Prerequisities
==============

SlipStream is migrating towards a micro-server architecture and
consists of a number of individual services that work together.  The
front-end services are stateless; all of the persistent state is
stored in separate databases (currently Elasticsearch and
HSQLDB). Many administrators are familiar with this type of
architecture and will be comfortable running the necessary services
and databases.


Software Requirements
---------------------

The software is tested, packaged, and supported for CentOS 7 systems.
The packages should install and run correctly on any RHEL 7 compatible
system.

The software itself should build and run on any Unix-like system
(internally we use MacOS as a development platform), although some
changes may be needed for integration with the operating system's
service management infrastructure.

Hardware Requirements
---------------------

The hardware requirements of SlipStream are modest. Any modern,
multicore, server-class machine should run the SlipStream services
without problems.  We recommend a machine with a minimum of 4 CPU
cores and 8 GB of RAM.  A machine with 20-50 GB of disk space should
be sufficient for initial use.

As with any service, the resource requirements for the server will
increase with the number of users and with the number of system
deployments. Use a larger machine if you expect particularly large
scale or intense use of the service. For a production system, you
should strongly consider using a separate cluster for the
Elasticsearch and Zookeeper services.

Networking Requirements
-----------------------

SlipStream is available through a web-proxy on the standard HTTPS
(443) port. The proxy redirects all traffic on the HTTP (80) port to
the HTTPS port. Consequently, firewalls on the machine or site must
allow access to the HTTPS port from the users' machines; they may also
allow access to the HTTP port.

To administer and monitor the machine running the SlipStream service,
you may also want to have the SSH port (22) and the Nagios NRPE port
(5666) open to your administrators' machines.

For an initial test deployment, the Elasticsearch database is deployed
on the same machine as the other servers.  In this case, no additional
ports need to be opened to the outside world.  Production deployments
should have the Elasticsearch database deployed on separate machines.
In this case, the Elasticsearch ports (9200 and 9300) will need to be
opened to the machine(s) running the other SlipStream services.

The configured SlipStream connectors act as clients of the correponding
cloud service provider. Consequently, the server must also have
*outgoing* access to the underlying cloud service endpoints. The ports
used vary depending on the cloud service provider.

For any cloud service provider that does not support a virtual machine
contextualization mechanism, the server requires direct SSH access (port
22) to virtual machines within those clouds.

Cloud Requirements
------------------

SlipStream is a cloud deployment engine and requires access to at
least one supported cloud infrastucture. See the list of supported
clouds and conditions on the associated cloud connector to select the
cloud(s) you will be making available through your SlipStream
instance.

You must have at least one valid account on each cloud you want to
support to verify the SlipStream configuration for those clouds.


