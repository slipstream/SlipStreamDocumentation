Starting SlipStream™
====================

Starting Up the Server
======================

How the server is started depends on what deployment model you have
chosen. The details are in the following sections.

Standalone Server
-----------------

Deployment as a standalone server is the easiest to deploy. In this
case, setup the database, define the configuration parameters, and start
the service. Be sure that any firewalls protecting the server permit the
server port to be contacted. This is port 443 if you are using the
standard HTTPS port.

Tomcat Deployment
-----------------

To deploy the service within a Tomcat server, use the SlipStream™
servlet distribution. This contains a web archive (war) that contains
most of the software necessary for running the service. The possible
exception is the JDBC driver. The Derby database and JDBC driver are
included in the web archive. If you are using a different database, then
you will need to make the JDBC driver available to the SlipStream™
servlet. This can either be done by inserting the jar file with the JDBC
driver in the `lib` area of the web archive or by adding it to the
global area of the Tomcat server.

You will have to edit the deployment descriptor (`web.xml`) and give the
root URL for the server. You will also have to provide the required
parameters for the service in the `config.properties` file.

Once those steps have been done, you can start the service within
Tomcat.

Adding Users
============

One the service has been started, you must add the real users to the
system. From the main page click on "Start SlipStream" and log in as
"super". Once logged in, click on the "users" link. Click on the "Add
User" button and fill in the form for each user. You need only fill in
the user name and password. When users first log into their account,
they can provide the remaining information, such as the Amazon
credentials.

Further Information
===================

Information about the capabilities of the SlipStream™ system and how to
use it can be found in the User Manual.
