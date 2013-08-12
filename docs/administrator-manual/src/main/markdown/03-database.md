Setting Up Database
===================

The metadata describing machine and deployment configurations are stored
in a relational database. SlipStream™ uses standard JDBC bindings to
access the database, so the server should work with any database that
provides a JDBC driver. In practice, the system is regularly tested with
MySQL and Derby; hence, those are the recommended databases to use.

MySQL
=====

You should use MySQL 5.0 or later. Once the server has been installed
and configured, create a database for SlipStream™. You must also create
a user that has full rights to administer that database. Ensure that the
user is allowed to access the database from the SlipStream™ server
(localhost if the database is running on the same machine as the
server).

You must download the JDBC drivers corresponding to the MySQL version
that your running. Ensure that those drivers are in the CLASSPATH when
starting the SlipStream™ server.

Use the `slipstream-schema.sql` file in the distribution to setup the
tables necessary for the server.

Derby
=====

The Derby database can either be used as a stand-alone server or as an
embedded server. In either case, create the database for the SlipStream™
server. Create the database with a username and password. If running the
server as an embedded server, the database must clearly reside on the
same machine as the server. A stand-alone server can be deployed on a
separate machine if desired.

The Derby database and JDBC driver are distributed with the SlipStream™
distribution.

Use the `slipstream-schema.sql` file in the distribution to setup the
tables necessary for the server.
