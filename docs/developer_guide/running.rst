Running
=======

The following instructions describe how to run the SlipStream server
locally, primarily for development. If you are interested in running
SlipStream in production, you should install it from the generated
packages following the instructions in the Administrator Guide.

Database
--------

SlipStream needs a JDBC friendly database. By default we use HSQLDB, but
the persistence.xml file contains a number of other databases, including
MySQL and PostgreSQL.

Database Configuration
----------------------

Create an HSQLDB definition file in your home area:

::

    $ cat > ~/sqltool.rc << EOF
    urlid slipstream
    url jdbc:hsqldb:hsql://localhost/slipstream
    username SA
    password
    EOF

The default username is "SA" and the default password is blank.

Starting the Database
---------------------

The HSQLDB database (a pure Java database) will have been downloaded to
your local maven repository when you built SlipStream. You can run the
database with the downloaded jar file:

::

    $ java -cp ~/.m2/repository/org/hsqldb/hsqldb/2.3.2/hsqldb-2.3.2.jar \
           org.hsqldb.server.Server \
           --database.0 file:slipstreamdb \
           --dbname.0 slipstream &

Note that starting the database in this way should not be done in
production. This is intended only for development testing.

SlipStream Services
-------------------

SlipStream is composed of two main services. This section describes how
to start these services.

Running the Main SlipStream Service
-----------------------------------

To run the main server, drop into the ``war`` subdirectory in the
``SlipStreamServer`` module and then use Jetty to run the SlipStream web
archive (war file).

::

    $ cd SlipStreamServer/war
    $ mvn jetty:run-war

If the last command returns an error like
``JettyRunWarMojo : Unsupported major.minor version 51.0`` make sure you
have Java 8 installed. You can find the appropriate download from the
Java web site. You may also want to consult `this
article <http://www.jayway.com/2013/03/08/configuring-maven-to-use-java-7-on-mac-os-x/>`__
for setting up the environment.

As you can see, we run SlipStream as a war behind Jetty. Now that the
server's running, visit http://localhost:8080/ with your Web browser.

During development, especially when working on the UI with css and
JavaScript files, to avoid the war building round trip, you can start
the server pointing to source static location as following:

::

    $ mvn jetty:run-war \
          -Dstatic.content.location=file:../../SlipStreamUI/src/slipstream/ui/views 

You can also change the database backend connection using the
``persistence.unit``. For example:

::

    -Dpersistence.unit=mysql-schema

or

::

    -Dpersistence.unit=postgres-schema

You will obviously need to have either MySQL or Postgresql running when
configuring the server in this way.

You are now ready to :ref:`configure <dg-cfg>` your new SlipStream
server.

.. warning::

    If you intend to configure your system from configuration files, do
    not start your service just yet and read on.

Running the Ancillary SlipStream Service
----------------------------------------

This service includes additional resources, such as ``event`` and
``usage`` resources. As opposed to the main service written in Java,
this service is written in Clojure.

To run the service from the ``ssclj`` repository, use the jar file that
contains all of the service dependencies:

::

    /usr/bin/java
      -Ddb.config.path=<db.spec>
      -Dlogfile.path=<environment.name>
      -cp .:target/SlipStreamCljResources-jar-<version>-jar-with-dependencies.jar
      com.sixsq.slipstream.ssclj.app.main 8201

Changing the name of the generated jar file as needed.

The directory containing the ``db.spec`` file must be on the classpath
(here it is "``.``\ "). You can add other dependencies to the classpath
as needed. The service will start on the port 8200 by default or you can
provide an argument to change the port (port 8201 in the example).

The ``db.spec`` is the path to the file containing the database
definition (e.g. *config-hsqldb-mem.edn*). Typical content looks like:

::

    {:db {
      :classname    "org.hsqldb.jdbc.JDBCDriver"
      :subprotocol  "hsqldb"
      :subname      "mem://localhost:9012/devresources"
      :make-pool?   true}}

Note that the log file will be named after the value of
``environment.name``.
