Installation
============

Prerequisites
=============

The system has been designed to have as few requirements as possible.
Nonetheless, there are some prerequisites for successfully running
SlipStream™. The server must have:

-   Java 6 or later installed.

-   A publicly accessible network address.

-   Either a commercial or self-signed certificate for SSL.

-   Access to a database that has a JDBC driver.

-   Any firewall around the server must allow access to port 443 (or
    configured port) on the server.

The clients running within the cloud must have:

-   Python 2.5 installed.

-   SlipStream™ client software installed.

-   Resources in the cloud must have port 22 accessible and be able to
    contact the SlipStream™ server.

SlipStream™ currently uses Amazon Web Services as the provider of cloud
resources. Each user must have valid Amazon credentials in order to use
the system. Deployments are submitted with the user's credentials and
usage is charged directly to the user.

Deployment Models
=================

There are a couple of deployment models for the system: Standalone and
Servlet. Of the two models, the easier to setup and configure is the
"Standalone" server. This uses the standard RESTlet HTTP(S) server and
client. If the Derby database is used with the Standalone server, no
additional software needs to be downloaded.

The Servlet model is a bit more complicated, but may be desired to take
advantage of an existing servlet infrastructure. Although the server
should work with any Servlet container, we routinely test the system
with Tomcat and recommend using that.

Distributions
=============

SixSq Sàrl provides a central server for evaluation of the service and
for limited use of the system. Send an email to
<slipstream-support@sixsq.com> to request an account on that server. To
deploy a private server, please send an email to the same address
indicating that you would like to deploy a private instance. You will be
contacted about licensing conditions and prices.

Unpacking Distribution
======================

For the Standalone distribution, unpack the distribution into a
convenient directory. You can copy the startup script to the appropriate
area to have the server automatically started when the machine boots.

For the Servlet distribution, unpack the distribution into a temporary
directory. Take the web archive file and drop this into your Tomcat (or
other servlet container). Depending on the database that you have chosen
you may also need to add your database's JDBC driver to the Tomcat
CLASSPATH.
