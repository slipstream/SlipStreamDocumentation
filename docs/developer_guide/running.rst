Running
=======

The following instructions describe how to run the SlipStream server
locally, primarily for development. If you are interested in running
SlipStream in production, you should install it from the generated
packages following the instructions in the Administrator Guide.

Databases
---------

SlipStream needs a JDBC friendly database. By default we use HSQLDB, but
the persistence.xml file contains a number of other databases, including
MySQL and PostgreSQL.
SlipStream API server uses Elastic Search.

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

    $ java -cp ~/.m2/repository/org/hsqldb/hsqldb/2.3.4/hsqldb-2.3.4.jar \
           org.hsqldb.server.Server \
           --database.0 file:slipstreamdb \
           --dbname.0 slipstream &

Note that starting the database in this way should not be done in
production. This is intended only for development testing.

Elastic Search installation
---------------------------

Follow instructions from Elastic Search documentation:
https://www.elastic.co/guide/en/elasticsearch/reference/current/_installation.html

Please use same version as the one found used SlipStream server (see pom.xml in ``SlipStream`` project).

To start Elastic Search engine, just type (in the ``bin`` directory):
::

    $ ./elasticsearch

SlipStream Services
-------------------

SlipStream is composed of a number of services. This section describes how
to start these services.

Starting the Ancillary SlipStream Service
------------------------------------------

This service should be started first and includes additional resources, such
as ``event`` and ``usage`` resources.  As opposed to the main service, which is
written in Java, this service is written in Clojure.  The service uses both
HSQLDB and Elasticsearch, so they should be up and running prior to starting
the service.

The service should be started from the ``ssclj/jar`` module of
``SlipStreamServer`` project.

::

   $ cd SlipStreamServer/ssclj/jar

Start Clojure REPL with boot and in the REPL run the commands listed below::

    $ boot server-repl
      boot.user=> (require '[com.sixsq.slipstream.ssclj.app.server :as server :reload true])
      nil
      boot.user=> (def stop-fn (server/start 8201))
      nil
      boot.user=> ;; when needed, stop with
      boot.user=> ;; (server/stop stop-fn)

The services will be started on port ``8201``.  You can set it as needed,
taking into account that it will be required later during the startup of the
main SlipStream service.

It is assumed that an instance of `Elasticsearch <https://www.elastic.co>`__ is
running on ``localhost:9300``.  If this is not the case, export the following
environment variables defining the coordinates of Elasticsearch::

    $ export ES_HOST=<es-host>
    $ export ES_PORT=<es-port>

The service uses the configuration file defined by ``CONFIG_NAME`` environment
variable.  To be found by the service, the file should be on the service's
classpath. ``SlipStreamServer/ssclj/jar/boot.build`` (the project's
configuration file) sets the service configuration file name and extends the
classpath to include the default location containing the file. Typically, the
file is named ``config-hsqldb-mem.edn`` and located in ``test-resources``::

    (environ :env {:config-name      "config-hsqldb-mem.edn"
        ...
    (set-env! :source-paths #(set (concat % #{"test" "test-resources"})))
        ...

So, both the file name and its location can be modified in ``boot.build``.

Apart from other configuration parameters the configuration file contains
HSQLDB configuration definition.  Typical content looks like::

    {:auth-db {
       :classname    "org.hsqldb.jdbc.JDBCDriver"
       :subprotocol  "hsqldb"
       :subname      "mem://localhost:9012/devresources"
       :make-pool?   true}}

The ``config-hsqldb.edn`` is part of the source code and located under
``resources/`` subdirectory.

The service's log file can be found under ``logs/ssclj-.log``.

You can add other dependencies to the classpath
as needed.  This can be done either by editing the list of dependencies in
``build.boot``::

    21   :dependencies
    22   #(vec (concat %
    23                 (merge-defaults
    24                  ['sixsq/default-deps (get-env :version)]
    25                  '[[org.clojure/clojure]
    ...
    58                    [com.sixsq.slipstream/SlipStreamConnector-OpenStack-conf]
    59                    ;; added OpenStack connector jar

or providing the dependencies to ``boot`` command as follows::

    $ boot -d com.sixsq.slipstream/SlipStreamConnector-OpenStack-conf:3.17-SNAPSHOT repl

By adding connectors jar to the classpath of the service (as shown above) we
allow the service to create the connector instances.

Starting Pricing and Ranking Service (PRS)
------------------------------------------

To start PRS service go to ``SlipStreamServer/jar-prs-service`` and run::

    $ boot run

The service starts on ``localhost:3000`` by default.  Logs go to stdout/err.

Starting the Main SlipStream Service
------------------------------------

To run the main server, drop into the ``war`` subdirectory in the
``SlipStreamServer`` project and then use Jetty to run the SlipStream web
archive (war file).

::

    $ cd SlipStreamServer/war
    $ mvn jetty:run-war -Dpersistence.unit=hsqldb-schema

If the last command returns an error like ``JettyRunWarMojo : Unsupported
major.minor version 51.0`` make sure you have Java 8 installed. You can find
the appropriate download from the Java web site. You may also want to consult
`this article
<http://www.jayway.com/2013/03/08/configuring-maven-to-use-java-7-on-mac-os-x/>`__
for setting up the environment.

As you can see, we run SlipStream as a war behind Jetty. Now that the
server's running, visit http://localhost:8080/ with your Web browser.

During development, especially when working on the UI with css and
JavaScript files, to avoid the war building round trip, you can start
the server pointing to source static location as following:

::

    $ export ES_HOST=localhost
    $ export ES_PORT=9300
    $ mvn jetty:run-war \
          -Dpersistence.unit=hsqldb-schema \
          -Dstatic.content.location=file:../../SlipStreamUI/clj/src/slipstream/ui/views

The server makes use of Elasticsearch as database backend, therefore, you see
the need to set the host and port of Elasticsearch.
You can also change the main database backend connection updating the
``persistence.unit``. For example:

::

    -Dpersistence.unit=mysql-schema

or

::

    -Dpersistence.unit=postgres-schema

You will obviously need to have either MySQL or Postgresql running when
configuring the server in this way.

To add cloud connectors you need to modify ``pom.xml``.  Below is an example of
adding Exoscale connector that depends on CloudStack connector.  Please note
that both ``jar`` and ``conf`` artifacts should be added.

::

    <dependency>
      <groupId>com.sixsq.slipstream</groupId>
      <artifactId>SlipStreamConnector-Exoscale-jar</artifactId>
      <version>${project.version}</version>
    </dependency>
    <dependency>
      <groupId>com.sixsq.slipstream</groupId>
      <artifactId>SlipStreamConnector-Exoscale-conf</artifactId>
      <version>${project.version}</version>
    </dependency>
    <dependency>
      <groupId>com.sixsq.slipstream</groupId>
      <artifactId>SlipStreamConnector-CloudStack-jar</artifactId>
      <version>${project.version}</version>
    </dependency>
    <dependency>
      <groupId>com.sixsq.slipstream</groupId>
      <artifactId>SlipStreamConnector-CloudStack-conf</artifactId>
      <version>${project.version}</version>
    </dependency>

Starting HTTP Server and Reverce Proxy
--------------------------------------

HTTP server and reverse proxy are required to serve SlipStream static content
and calls to API.  Below this is done on an example of `Nginx
<https://www.nginx.com>`__.  As there are complementary SlipStream services
(SlipStream server, SSCLJ server) which run on different ports, and the
fact that SlipStream force the usage of secure cookies, all services should be
run behind an SSL encryption.  We use following simplified configuration of
Nginx to fulfill this need.

* Nginx installation

Linux users should install it from the official `documentation
<https://www.nginx.com/resources/wiki/start/topics/tutorials/install/>`__ page.

Mac OS X users can simply run ::

    brew install nginx

* Nginx configuration

By default, the main Nginx configuration file is named ``nginx.conf`` and
placed in the directory ``/usr/local/nginx/conf``, ``/etc/nginx``, or
``/usr/local/etc/nginx``.

It should contain the following ::

    worker_processes  1;

    events {
        worker_connections  1024;
    }


    http {
        include       mime.types;
        default_type  application/octet-stream;
        sendfile        on;
        keepalive_timeout  65;
        include servers/*.conf;
    }


You need to create configuration for upstream SlipStream services and SSL that will be located
in ``nginx/servers`` and ``nginx/ssl`` respectively ::

    $ mkdir {servers,ssl}
    $ cat > servers/slipstream.conf<<EOF

    upstream slipstream_servers {
        server 127.0.0.1:8080;

        keepalive 50;
    }

    upstream ssclj_servers {
        server 127.0.0.1:8201;

        keepalive 50;
    }

    ssl_session_cache shared:SSL:1m;
    ssl_session_timeout 30m;
    ssl_session_tickets on;
    ssl_prefer_server_ciphers on;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ecdh_curve prime256v1;
    ssl_ciphers "ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:DHE-RSA-AES256-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES256-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES128-SHA:DHE-RSA-AES128-SHA:!aNULL:!eNULL:!EXPORT:!DES:!MD5:!PSK:!RC4:!3DES:AES128-GCM-SHA256";
    resolver 8.8.8.8 8.8.4.4;

    server {
        listen 443 ssl http2; # deferred reuseport;

        ssl_certificate /usr/local/etc/nginx/ssl/nginx.crt;
        ssl_certificate_key /usr/local/etc/nginx/ssl/nginx.key;

        # Include SlipStream common configuration parameters
        location / {
            proxy_pass http://slipstream_servers;
            include servers/slipstream-proxy.params;
        }

        location /auth {
            proxy_pass http://ssclj_servers;
            include servers/slipstream-proxy.params;
        }

        location /api {
            proxy_pass http://ssclj_servers;
            include servers/slipstream-proxy.params;
        }

        location /filter-rank {
            proxy_pass http://prs_servers;
            include servers/slipstream-proxy.params;
        }

    }
    EOF

    $ cat > servers/slipstream-proxy.params<< EOF

    proxy_http_version 1.1;

    set $via "1.1 $host";
    if ($http_via) {
       set $via "$http_via, $via";
    }

    proxy_set_header Via $via;
    proxy_set_header Host $http_host;
    proxy_set_header Connection "";
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

    proxy_set_header slipstream-authn-info "";
    proxy_set_header slipstream-ssl-server-name $ssl_server_name;

    proxy_redirect off;

    $ cd ssl
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx.key -out nginx.crt

At this stage, your Nginx configuration directory should look like::

    ├── [...]
    ├── nginx.conf
    ├── servers
    │   ├── slipstream-proxy.params
    │   └── slipstream.conf
    ├── ssl
    │   ├── nginx.crt
    │   └── nginx.key


* Optionally you may want to test your Nginx configuration::

    sudo nginx -t

* Finally launch Nginx::

    sudo nginx

TCP port 443 which you have configured in ``servers/slipstream.conf`` is the
standard TCP port that is used for websites which use SSL, therefore your
Slipstream is available at ``https://localhost``


You are now ready to :ref:`configure <dg-cfg>` your new SlipStream
server.

.. warning::

    If you intend to configure your system from configuration files, do
    not start your service just yet and read on.

