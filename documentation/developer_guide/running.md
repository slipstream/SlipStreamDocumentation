---
title: Running Locally
---

The following instructions describe how to run the SlipStream server
locally, primarily for development.  If you are interested in running
SlipStream in production, you should install it from the generated
packages following the instructions in the Administrator Guide.

# Database

SlipStream needs a JDBC friendly database. By default we use HSQLDB,
but the persistence.xml file contains a number of other databases,
including MySQL and PostgreSQL.

## Database Configuration

Create an HSQLDB definition file in your home area:

    $ cat > ~/sqltool.rc << EOF
    urlid slipstream
    url jdbc:hsqldb:hsql://localhost/slipstream
    username SA
    password
    EOF

The default username is "SA" and the default password is blank.

## Starting the Database

The HSQLDB database (a pure Java database) will have been downloaded
to your local maven repository when you built SlipStream.  You can run
the database with the downloaded jar file:

    $ java -cp ~/.m2/repository/org/hsqldb/hsqldb/2.3.2/hsqldb-2.3.2.jar \
           org.hsqldb.server.Server \
           --database.0 file:slipstreamdb \
           --dbname.0 slipstream &

Note that starting the database in this way should not be done in
production.  This is intended only for development testing. 

## Running SlipStream

To run the server, drop into the `war` subdirectory in the
`SlipStreamServer` module and then use Jetty to run the SlipStream web
archive (war file). 

    $ cd SlipStreamServer/war
    $ mvn jetty:run-war

If the last command returns an error like `JettyRunWarMojo :
Unsupported major.minor version 51.0` look here to configure maven for
Java 7 on Mac OS X: 
[Configuring Maven to use Java 7 on Mac OS
X](http://www.jayway.com/2013/03/08/configuring-maven-to-use-java-7-on-mac-os-x/).

As you can see, we run SlipStream as a war behind Jetty.  Now that the
server's running, visit
[http://localhost:8080/](http://localhost:8080/) with your Web
browser.


During development, especially when working on the UI with css and
JavaScript files, to avoid the war building round trip, you can start
the server pointing to source static location as following:

    $ mvn jetty:run-war \
          -Dstatic.content.location=file:../../SlipStreamUI/src/slipstream/ui/views 

You can also change the database backend connection using the
`persistence.unit`. For example:

    -Dpersistence.unit=mysql-schema

or

    -Dpersistence.unit=postgres-schema

You will obviously need to have either MySQL or Postgresql running
when configuring the server in this way.

# Configuring SlipStream

To do anything useful with the local SlipStream server, you will need
to configure it.  

## User(s)

During the initial startup of the server, an administrator account
("super") will be created.  The initial password for this account is
"supeRsupeR".  You should log in as this user, visit the profile page
(single user icon at top), and change the password to another value.

You can also create new user accounts by visiting the "users" page
(group of people icon at top).

## Connector(s)

Once the server is up and running you need to configure a connector
before trying to deploy a module. Out of the box, using the local
connector is the easiest way to get started. To do so, navigate to the
[server configuration page](http://localhost:8080/configuration) and
define a cloud connector instance in the SlipStream Basics section:

    test-cloud:local

You must be logged in with an administrator account to do this.  The
value of this field has the form "name1:connector1,name2:connector2";
multiple instances of a single connector are permitted.  If the name
isn't given, it defaults to the connector name.

For configuration of other cloud connectors, check our
[blog](http://sixsq.com/blog/index.html).

## Load default modules

The client module includes examples from the tutorial that can be
loaded.

    $ cd ../../SlipStreamClient/client/src/main/python
    $ ./ss-module-upload.py \
          --endpoint http://localhost:8080 \
          -u test -p tesTtesT \
          ../resources/doc/*

Change the username and password to an existing (preferably
non-administrator) account.

You now only need to configure the cloud parameters of a user
(e.g. "test"). And add the cloud IDs to the native images
(e.g. Ubuntu, CentOS) you just created.
