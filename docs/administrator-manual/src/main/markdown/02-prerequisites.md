
# Prerequisites

The SlipStream server has a standard, n-tier web application
architecture: the application runs within a Java web application
container and stores data within an SQL database.  Consequently, many
administrators will be familiar with its configuration needs and
modest resource requirements.

## Software Requirements

The software is tested, packaged, and supported for CentOS 6 systems.
The packages should install and run correctly on any RHEL 6 compatible
system.  The software itself should build and run on any Unix-like
system, although some changes may be needed for integration with the
operating system's service management infrastructure.

## Hardware Requirements

The hardware requirements of SlipStream are modest.  Any modern,
multicore, server-class machine should run the server without
problems.  At least 2 gigabytes of RAM should be dedicated to the Java
Virtual Machine (JVM) running the service.  Similarly 10-20 GB of disk
space should be sufficient for initial use.

As with any service, the resource requirements for the server will
increase with the number of users and with the number of system
deployments.  Use a larger machine if you expect particularly large
scale or intense use of the service.

## Networking Requirements

SlipStream is available through a web-proxy through the standard HTTPS
(443) port.  In addition, the proxy redirects all traffic on the HTTP
(80) port to the HTTPS port.  Consequently, firewalls on the machine
or site must allow access to the HTTPS port from the users' machines;
they may also allow access to the HTTP port.

To administer and monitor the machine running the SlipStream service,
you may also want to have the SSH port (22) and the Nagios NRPE
port (5666) open to your administrators' machines.

The configured SlipStream connectors act as clients of the
correponding cloud service provider.  Consequently, the server must
also have _outgoing_ access to the underlying cloud service endpoints.
The ports used vary depending on the cloud service provider.

For any cloud service provider that does not support a virtual machine
contextualization mechanism, the server requires direct SSH access
(port 22) to virtual machines within those clouds.

## Cloud Requirements

SlipStream is a cloud deployment engine and requires access to at
least one supported cloud infrastucture.  See the list of supported
clouds and conditions on the associated cloud plugin to select the
cloud(s) you will be making available through your SlipStream
instance.

