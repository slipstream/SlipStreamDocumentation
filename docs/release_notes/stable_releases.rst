
Stable Releases
===============

Releases that pass our quality control and testing are promoted to
stable releases that are listed here. Stable releases are supported by
SixSq and are appropriate for production deployments. In general, we
recommend that people use the latest stable release.

v3.8 (candidate) - 15 July 2016
-------------------------------

Features
~~~~~~~~

Version v3.8 is the first stable release of the v3 series.  There are
major underlying changes to make this release more stable, robust, and
performant, including the introduction of Elasticsearch as a database,
switching from CentOS 6 to CentOS 7, and numerous bug fixes.

In addition, there are a number of new features to make this attactive
to both end-users and developers, including better support for
scalable applications, improved usage information, an expanded REST
API that uses the CIMI standard for new resources, and a streamlined
user interface.  The Enterprise Edition also contains an alpha-preview
of the placement and ranking service that allows policy-based
selection of cloud infrastructures when deploying applications and
integration with NuvlaBox appliances.

The detailed change log is given below.  For brevity bug fixes have
not been included, see the change logs for the intermediate releases
for the full set of changes and fixes.

For everyone [Alice, Bob, Clara, Dave]:
 - Provide a top-level support link for users, if the system
   administrator has set a support email address.
 - In the Enterprise Edition, improve the visualization of the Service
   Catalog entries and allow more than one entry per cloud connector.
 - Provide for status reporting of the NuvlaBox appliances connected
   to the SlipStream server.

For application users, developers, and SlipStream administrators [Alice, Clara, Dave]:
 - Update the general and API documentation to consistently use
   "scalable" runs for those that can be dynamically scaled while
   running.
 - Improve query performance when retrieving event resources through
   the API and in the UI.
 - Remove the save button on the service catalog when user isn't
   authorized to make changes.
 - Add a "+" to dashboard to make it easier to configure new cloud
   connectors.
 - Make application thumbnails clickable in the App Store.
 - Add terminated icon to terminated VMs in the dashboard.
 - Improve graphical feedback when viewing virtual machines to
   indicate those that are not known to SlipStream.
 - OpenNebula connector allows custom template fields to be
   specified to, for example, attach hardware devices or consoles.

For application users and developers [Alice, Clara]:
 - Inherited output parameters are visible to the users, allowing
   an input parameter to be mapped to an inherited output parameter.
 - The SlipStream bootstrap process is now able to run on operating
   systems with only Python 3 installed. The robustness of the
   bootstrapping process has also been improved.
 - Display prices for running components and applications and certain
   clouds in the run dialog (Enterprise Edition).
 - Make the bootstrap mechanism more reliable over low-quality networks
   (e.g. satellite connections).
 - Allow to define relative and absolute paths for module logo.
 - Improve the retry mechanism for the SlipStream clients to make them
   behave more uniformly and to be more robust.
 - Added a field in the dashboard run list that indicates how many
   active VMs are associated with the run.
 - Rename service catalog offers (service-offer) and attribute
   (service-attribute) resources for consistency.
 - REST API more strictly validates its inputs on scale up/down
   requests.
 - Add functions to the clojure client API to launch and terminate
   applications.
 - Application component definitions now inherit configuration scripts
   from their parents, facilitating reuse of existing application
   components.
 - Updated dashboard provides more detailed information about virtual
   machine states and to which run they belong.
 - User profile now provides visual clues as to which cloud connectors
   are configured and which are not.
 - The command line client and API now use nuv.la as the default
   endpoint for the SlipStream service.
 - An early alpha clojure(script) API is now available.  It contains
   functions for scaling runs and for the CRUD actions on CIMI-like
   resources. Feedback on the API is welcome.
 - Restarting an aborted run (through ``ss-abort --cancel`` now
   generates an event in the run's event log.
 - Expand SlipStream bootstrap mechanism to more operating systems
   (notably SuSE and OpenSuSE 11-13).
 - Improve the logs for machines deployed with SlipStream.
 - Exoscale: Add support for Mega and Titan instances.
 - OpenStack: Added support for Floating IPs.
 - OpenNebula: Added default values for image parameters

For application developers [Clara]:
 - Allow the client API to be used for test instances of SlipStream
   that use a self-signed certificate.
 - Update API documentation for cookie authentication.  Cookie
   authentication is now the preferred method; basic authentication is
   deprecated.
 - Add a command to allow the reports from a run to be retrieved.
 - Fixed disk size unit in describe instance action in OpenNebula
   connector.
 - DELETE on API resources now returns 200 instead of 204.
 - Use readable names for downloaded deployment scripts to make
   debugging easier.
 - Move deployment scripts out of ``/tmp`` to avoid them disappearing
   on reboots.
 - Ensure that parameter values starting with a dash do not disrupt
   the application deployment.

For administrators [Dave]:
 - Avoid dependency version conflicts by removing hard-coded
   dependencies for the PRS-lib component.
 - Rationalize logging and logging levels
 - Improved installation and testing scripts.
 - Make the installation script more robust concerning RPM package
   names.
 - Improve the configuration of the nginx configuration to enhance the
   security of the service.
 - Improve logging by providing full URIs of application components.
 - Install service catalog by default (Enterprise Edition).
 - Allow direct proxying of the two SlipStream services through nginx
   to provide more efficient and reliable system.
 - Remove unnecessary logging to make the server activity easier to
   understand.
 - **SlipStream must now be deployed on CentOS 7.** All services have
   been updated to support systemd only.  Caches have been moved from
   `/tmp` and `/var/tmp` to avoid startup problems.

For managers and super users [Bob]:
 - Cloud managers can now see an overview of the activity on their
   cloud from all users.
 - Provide better header information in the browser UI when a manager
   or super users is viewing information from several users.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

**NB!** Because SlipStream v3 requires the CentOS 7 operating system, an
upgrade from the SlipStream v2 series to the SlipStream v3 series
requires a complete database migration from the old machine to a new
one running CentOS 7.

In addition, the names for the service catalog resources have changed.
Follow the migration instructions for those resources before migrating
the database, if you are running the service catalog.

Below are the full migration instructions.

Installation of SlipStream
^^^^^^^^^^^^^^^^^^^^^^^^^^

Install SlipStream on CentOS 7 following `Administrators Guide
<../administrator_guide/index.html>`__.  Please note that for installation of
SlipStream Enterprise edition you will have to (re-)use the client certificate
to be able to access SlipStream Enterprise YUM repository.  The certificates are usually
installed as `/etc/slipstream/yum-client.*`.  On the existing SlipStream
installation this can be checked by::

   # grep sslclient /etc/yum.repos.d/slipstream.repo
   sslclientcert=/etc/slipstream/yum-client.crt
   sslclientkey=/etc/slipstream/yum-client.key
   ...

When installing cloud connectors, it's important to ensure that the
list of the connectors to be installed matches the one configured on
the previous SlipStream instance as we are going to fully migrate DB
containing the complete service configuration of the current
SlipStream instance to the new one.  The list of the installed
connectors can be obtained on the current SlipStream by::

    # rpm -qa | \
          grep slipstream-connector | \
          grep -v python | \
          cut -d'-' -f3 | \
          tee installed-connectors.txt
    cloudstack
    ec2
    opennebula
    openstack
    nuvlabox
    nativesoftlayer
    stratuslab
    azure
    exoscale
    #

After installation of SlipStream and
`connectors <../administrator_guide/quick_installation.html#cloud-connectors>`__
on CentOS 7, verify that the service is properly up and running by accessing the main page
of the service.

Migration of Service Catalog Resources
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Following renaming of resources linked to Service Catalog, a script needs to be executed.
Please contact support to obtain this script with information on how to run it.

Migration of DB, reports and logs
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

On the current CentOS 6 machine running SlipStream take the following
steps.

1. Stop the following services::

    $ service nginx stop
    $ service slipstream stop
    $ service ssclj stop

2. Restart hsqldb to checkpoint the DB (this will trigger replay of
   the WAL log)::

    $ service hsqldb restart

3. Stop hsqldb::

    $ service hsqldb stop

4. Archive SlipStream DB, deployment reports, service logs, nginx configuration::

    $ tar -zc /opt/slipstream/SlipStreamDB \
         /opt/slipstream/server/logs \
         /var/log/slipstream/ssclj \
         /var/tmp/slipstream/reports \
         /etc/nginx/{ssl/,conf.d/} \
         --dereference \
         -f ~/SlipStream-backup.tgz

5. Copy the archive to the new CentOS 7 machine that will be hosting
   SlipStream.


On the new CentOS 7 machine, after installing SlipStream from scratch
and validating that it works,

1. Stop all the services by running::

    $ systemctl stop nginx
    $ systemctl stop slipstream
    $ systemctl stop ssclj
    $ systemctl stop hsqldb

2. Inflate the backup tarball as follows::

    $ tar -zxvf ~/SlipStream-backup.tgz -C /

This should inflate

 - database to ``/opt/slipstream/SlipStreamDB``
 - reports to ``/var/tmp/slipstream/reports``
 - logs to ``/opt/slipstream/server/logs`` and
   ``/var/log/slipstream/ssclj/``

3. Change the service configuration to reference the new host IP the service is running on by::

    # sed -i -e '/SERVICECONFIGURATIONPARAMETER/ s/<old-IP>/<new-IP>/g' \
         /opt/slipstream/SlipStreamDB/slipstreamdb.{log,script}

4. Update the SlipStream nginx cache location::

    # sed -i -e 's|proxy_cache_path.*keys_zone=zone_one:10m;|proxy_cache_path /var/local/slipstream/nginx/cache keys_zone=zone_one:10m;|' \
        /etc/nginx/conf.d/slipstream-ssl.conf

5. Start all the services in the following order::

    $ systemctl start hsqldb
    $ systemctl start ssclj
    $ systemctl start slipstream
    $ systemctl start nginx

This completes the migration process. Validate the migration by
logging to the service and launching a test deployment.

Further Incremental Migration Steps
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Riemann Service
***************

The following migration is required on SlipStream Enterprise instance.

In this release the `Riemann <http://riemann.io/>`_ service was
introduced.  It is intended to be used with `NuvlaBox
<http://sixsq.com/products/nuvlabox/>`_ product.

If you are using or intending to start using NuvlaBoxes with
SlipStream Enterprise, please follow the migration procedure below.
After following this procedure you will be able to see the connection
status of the NuvlaBoxes on the SlipStream dashboard.

1. Make sure that NuvlaBox connector is installed on the SlipStream
   instance. If not, install it with::

     yum install slipstream-connector-nuvlabox-enterprise

   Restart SlipStream service on the current instance::

     systemctl restart slipstream

2. Add and configure NuvlaBox connector
   (e.g. `nuvlabox-james-chadwick:nuvlabox`) on the SlipStream
   instance.  See NuvlaBox documentation for the details. The name of
   the connector should match the name under which the added NuvlaBox
   will be publishing its metrics.

3. Connect NB to SS for publication of availability metrics::

     /root/nuvlabox-register-mothership \
        -U nuvlabox-<NB-name> \
        -S "ssh-rsa <ssh-key> root@nuvlabox-<NB-name>"

   Add the following configuration parameters before first `Match`
   section in `/etc/ssh/sshd_config`::

     ClientAliveInterval 15
     ClientAliveCountMax 2

   Restart `sshd`::

     systemctl restart sshd

4. Populate Service Offer resource with the information on the
   NuvlaBox.  This step has to be manually done each time when a new
   NuvlaBox needs to be made available on the SlipStream instance via
   the NuvlaBox connector.

   Add NuvlaBox info into the service offer::

     curl -u super:<super-password> -k -s \
       -D - https://<ss-ip>/api/service-offer -d @nuvlabox.json \
       -H "Content-type: application/json"

   with the following content in `nuvlabox.json`::

     {
       "connector" : {"href" : "nuvlabox-<nb-name>"},

       "state": "nok",

       "acl" : {
         "owner" : { "principal" : "ADMIN",
                     "type" : "ROLE"},
         "rules" : [
           { "principal" : "USER",
             "type" : "ROLE",
             "right" : "VIEW"}
         ]
       }
     }

5. Run the following to install and configure the Riemann service.

   The command below is required to be ran if you are upgrading an
   existing SlipStream instance.  You don't need to run the command
   below if you've just installed SlipStream from scratch::

     curl -LkfsS https://raw.githubusercontent.com/slipstream/SlipStream/candidate-latest/install/ss-install-riemann.sh | bash

   Edit `/etc/sysconfig/riemann` and export the following environment
   variables::

     export SLIPSTREAM_ENDPOINT=https://127.0.0.1
     export SLIPSTREAM_SUPER_PASSWORD=change_me_password

   Restart Riemann service::

     systemctl restart riemann

Elasticsearch
*************

Elasticsearch is now required for the SlipStream service.  When
upgrading, Elasticsearch will need to be installed, configured, and
started by hand.  Start by adding the Elasticsearch repository::

    $ yum install slipstream-es-repo-community

Use "community" or "enterprise" as appropriate for you installation.

Install Elasticsearch::

    $ yum install elasticsearch
    $ systemctl daemon-reload
    $ systemctl enable elasticsearch.service

Update the configuration::

    $ cd /etc/elasticsearch/
    $ mv elasticsearch.yml elasticsearch.yml.orig
    $ cat > elasticsearch.yml <<EOF
    network.host: 127.0.0.1
    EOF

And finally start the service::

    $ systemctl start elasticsearch.service

You can test that Elasticsearch is running correctly with::

    $ systemctl status elasticsearch.service
    $ curl http://localhost:9200/_cluster/health?pretty=true

The first should show that the service is running and the second
should provide the health of the Elasticsearch cluster.  It should
contain one node and be in a "green" state.

For data persistency, SlipStream is moving from hsqldb, a Java-based
SQL relational database, to Elasticsearch, a high-performance,
document-oriented data store.  The migration from one to the other
will be incremental, so during the transition, both databases will be
used.  This is the first release where Elasticsearch is used.

Before starting the migration procedure, please make sure that
``slipstream`` and ``ssclj`` are not running.  Both databases (hsqldb
and Elasticsearch) must be running.

Then you can migrate the resources with the following commands::

    $ export ES_HOST=localhost
    $ export ES_PORT=9300
    $ java -cp /opt/slipstream/server/webapps/slipstream.war/WEB-INF/lib/clojure-1.8.0.jar:/opt/slipstream/ssclj/lib/ssclj.jar com.sixsq.slipstream.ssclj.migrate.script

Resources are migrated (from hsqldb to elastic search) by batches of
10'000 documents.  Example of output of this script::

    ...
    Creating ES client
    Index resetted
    Will create korma database with db-spec
    ...
    Migrating  usage , nb resources = XXX
    Migrating usage 0  ->  9999
    ...
    Migrating  usage-record , nb resources = XXX
    Migrating usage-record 0  ->  9999
    ...
    Migrating  event , nb resources = XXX
    Migrating event 0  ->  9999
    ...


Known Issues
~~~~~~~~~~~~

No major known issues.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.23.2-community...v3.8-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.23.2-community...v3.8-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.23.2-community...v3.8-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.23.2-community...v3.8-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.23.2-community...v3.8-community>`__

v2.23.2 (stable) - 3 March 2016
-------------------------------

Features
~~~~~~~~

As this is a major release, a large number of bugs have been fixed in
addition to the listed features.  For bug fixes, see the release notes
for the intermediate candidate releases.  Only the new features are
listed below. 

For application users [Alice]:
 - Major improvements to the text and workflow of the embedded
   SlipStream tour, making it easier to understand and to follow.
 - Major reorganization of the brower interface (and vocabulary),
   making the dashboard the initial landing page and providing easy
   access to the other major interface elements (App Store, Workspace,
   and Service Catalog).

For application users and developers [Alice, Clara]:
 - The new Service Catalog implementation allows for flexible schemas
   and full CRUD actions through the SlipStream API.  This allows it
   to cover a wider range of different cloud services and cloud
   service providers. 
 - Improve the application state machine and associated control
   processes to ensure that there are fewer spurious errors and that
   scaling is more reliable.
 - Enhanced the error reporting from the cloud connectors and the
   application control processes to make the returned error messages
   more precise. 
 - Dashboard has been markedly improved to provide a clearer and more
   concise view of your cloud activities.  For example, only gauges
   relevant to you are shown and you can filter out terminated
   applications. Applications can provide direct, clickable links to
   the deployed service. 
 - The events on the "run" page of an application are automatically
   refreshed (and time-ordered) to allow you to easily follow the
   progress of your application.

For application developers [Clara]:
 - Streamlined and refactored the command line interface to make the
   usage more intuitive.
 - Report tarball has been "flattened" to make navigation of the logs
   easier.
 - A script can now be defined for the orchestrator (beta feature)
   that allows for deployment-wide actions for an application.
 - Provides an alpha client API in clojure that provides functions
   that allow you to control most of an application's lifecycle,
   particularly the scaling actions.

For SlipStream administrators [Dave]:
 - Improved packaging that simplifies installation of SlipStream,
   ensures that customized configuration files are not inadvertantly
   overwritten, and allows the services to run with SELinux. 
 - Optimized data flow through the nginx proxy to the appropriate,
   backend SlipStream services; refine rate limits so that they do not
   affect normal usage.
 - Administrators can now assign roles to users that can be used
   within resource URLs.
 - Reduce unnecessary logging to make the log files more effective
   when trying to find problems. 
 - SlipStream now supports several external authentication mechanisms
   to be used, GitHub for example. 
   
For application users, developers, and SlipStream administrators [Alice, Clara, Dave]:
 - Improve browser support to ensure a consistent rendering across all
   of the major browsers. 
 - SlipStream supports scaling both horizontally (adding more
   machines) and vertically (adding more resources).
 - There is an example application that demonstrates autoscaling with
   SlipStream.
 - Daily, weekly, and monthly summaries of your cloud resource usage
   are available.  Daily reminders can also be enabled in your user
   profile. 
 - New events have been added that provide a broader view of important
   actions within the SlipStream server and managed cloud
   applications.  The events indicate when the server was
   started/stopped, when user profiles are updated, and when the
   server configuration changes.
 - Automatically create an open security group (on clouds that support
   it) to avoid application failures due to network connectivity.

The list of available cloud connectors has expanded and existing connectors have been improved:
 - AWS (EC2)

   - Connector only uses the first configured SSH key during
     deployment to avoid provisioning failures.
   - Errors messages in general and those related to the VPC change
     have been improved.
     
 - Azure
   
   - A complete connector for Azure is available that allows the full
     control of linux-based systems.
     
 - CloudStack
   
   - Connector now supports multiple zones.
      
 - Exoscale
   
   - This specialized cloud connector allows images to be referenced
     by name, disk sizes to be controlled, and platform-specific
     instance sizes.
     
 - OpenNebula
   
   - A connector to use OpenNebula platforms from SlipStream is
     available.
   - The OpenNebula machines templates can be customized from the
     SlipStream interface.
     
 - OpenStack
   
   - Now supports the Keystone API v3.
   - Connector has been streamlines to reduce the time to retrieve the
     virtual machine's IP address.
   - Error messages have been improved to help resolve connectivity
     and cloud problems.
     
 - SoftLayer
   
   - A connector (enterprise) that uses the native SoftLayer API is
     now available.  The connector supports vertical scaling.
     
 - StratusLab
   
   - Improved logging of networking errors as well as error messages.
   
Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

**When upgrading from previous versions two files must be renamed by
hand**:

-  ``mv /etc/default/slipstream.rpmnew /etc/default/slipstream``
-  ``mv /etc/default/ssclj.rpmnew /etc/default/ssclj``

This is not needed on a fresh installations of v2.23.2.

**Database migration is required from v2.14 to v2.23.2.  The following steps
MUST be followed:**

1. Upgrade SlipStream
2. Stop SlipStream::

       $ service slipstream stop

3. Stop HSQLDB (or your DB engine)::

       $ service hsqldb stop

4. Execute the following SQL script
   */opt/slipstream/server/migrations/015_compute_timestamp_usage.sql*::

       $ java -jar /opt/hsqldb/lib/sqltool.jar --autoCommit --inlineRc=url=jdbc:hsqldb:file:/opt/slipstream/SlipStreamDB/sscljdb,user=sa,password= /opt/slipstream/server/migrations/015_compute_timestamp_usage.sql

5. Execute the following SQL script */opt/slipstream/server/migrations/016_add_frequency_usage.sql*::

      $ java -jar /opt/hsqldb/lib/sqltool.jar --autoCommit --inlineRc=url=jdbc:hsqldb:file:/opt/slipstream/SlipStreamDB/sscljdb,user=sa,password= /opt/slipstream/server/migrations/016_add_frequency_usage.sql

6. Execute the following SQL script
   */opt/slipstream/server/migrations/017\_add\_external\_login.sql*::

       $ java -jar /opt/hsqldb/lib/sqltool.jar --autoCommit --inlineRc=url=jdbc:hsqldb:file:/opt/slipstream/SlipStreamDB/slipstreamdb,user=sa,password= /opt/slipstream/server/migrations/017\_add\_external\_login.sql

7. Start HSQLDB (or your DB engine)::

       $ service hsqldb start

8. Delete all usage_summaries, and recompute them thanks to summarizer script::

    $ java -Dconfig.path=db.spec -cp \ "/opt/slipstream/ssclj/resources:/opt/slipstream/ssclj/lib/ext/*:/opt/slipstream/ssclj/lib/ssclj.jar" \
     com.sixsq.slipstream.ssclj.usage.summarizer -f <frequency> -n <nb-in-past>

Use 'daily, 'weekly' and 'monthly' for '-f' option.  Adapt value given
to '-n' option for each frequency.

9. Start SlipStream::

       $ service slipstream start

Known Issues
~~~~~~~~~~~~

No major known issues.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.14-community...v2.23.2-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.14-community...v2.23.2-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.14-community...v2.23.2-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.14-community...v2.23.2-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.14-community...v2.23.2-community>`__

v2.14 (stable) - 13 August 2015
-------------------------------

From 2.13 (candidate) to v2.14 (stable)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  add SlipStream instance to the text of usage email messages
-  mark Java 1.7 as conflicting with SlipStream RPM package installation
-  improve mechanism for initial bootstrap configuration of server from
   configuration files
-  change URLs for event (and other clojure) resources from camel-case
   to kebab-case
-  change change CIMI root resource api/CloudEntryPoint
-  fix: pagination of results in UI
-  fix: crash of node executor on empty target script output

From 2.12 (candidate) to v2.13 (candidate)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  reduced dependency from jdk to jre
-  migrated to java 8
-  provide more metrics from connectors (cpu, ram, instance type, root
   disk size)
-  multiple bug fixes and improvements in UI
-  run page refreshes asynchronously on background
-  on run page alert (abort) messages are truncated (full abort message
   can still be seen in Global section)
-  display a loading screen while waiting for request from the server
-  added an ability for machine executor (orchestrator and node) to
   survive reboot of the host they are running on
-  more metrics can now be returned by OpenStack and CloudStack
   connectors
-  VMs section of dashboard can now display cpu, ram, instance type and
   root disk size if provided by the cloud connectors
-  improved collection of the usage records

From 2.11 (candidate) to v2.12 (candidate)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  added documentation on obtaining API Key and Secret on CloudStack
-  improved packaging of python code for cloud connectors
-  updated and improved example image and deployment modules that are
   shipped with SlipStream; added documentation on how to publish the
   modules to running SlipStream instance
-  bug fixes and improvements of the machine executor (orchestrator and
   node)
-  initial implementation of vertical scaling of node instances
-  new SlipStream dashboard layout with correspondingly adapted tour
-  numerous fixes and improvements in UI

From 2.10 (candidate) to v2.11 (candidate)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  users can now receive daily cloud usage emails (turn on via parameter
   in user profile)
-  changes to the server for better support of application scaling
-  the cloud contextualization method can be chosen through the cloud
   connector configuration
-  Java 1.8 is now required by the SlipStream server
-  fix: handling of open subsection in URL
-  fix: catch EINTR interrupt to prevent script failures on Windows
-  fix: invalid URL when clicking on VM gauge in dashboard
-  fix: problem with scaling scripts not being called on scaling actions
-  fix: various browser issues with embedded SlipStream tour

From v2.9 (stable) to v2.10 (candidate)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  interactive tour available through SlipStream interface (beta)
-  clicking on dashboard gauges opens the corresponding cloud section
-  allow event and usage resources to be filtered
-  disallow changes to parameter types through UI to be consistent with
   server
-  improve contextualization mechanisms for Windows
-  allow admins to choose contextualization method used for a cloud
-  fix: dashboard gauges incorrectly rendered in some cases
-  fix: wrong version comment sometimes displayed for module
-  fix: module logo is not displayed
-  fix: Windows deployments intermittently fail
-  fix: "noscript" message was not working when JavaScript

Migration
~~~~~~~~~

No migration is needed from v2.9 to v2.14.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.9-community...v2.14-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.9-community...v2.14-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.9-community...v2.14-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.9-community...v2.14-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.9-community...v2.14-community>`__

v2.9 (stable) - 18 May 2015
---------------------------

From v2.8 (candidate) to v2.9 (stable)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  only allow configured clouds to be used in UI
-  provide pagination of event and usage resources
-  package scripts for preparing usage summaries
-  reduce resource requirements for collected metrics
-  patch timezone handling bug in UI
-  fix storage of service configuration enum parameters
-  remove unnecessary dependencies in build artifacts

From v2.7 (stable) to v2.8 (candidate)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  allow connectors to indicate when a VM is usable (for usage records)
-  improve logging (more concise messages, longer retention times)
-  provide quick installation script with documentation of procedure
-  provide "event" resource with standard lifecycle events
-  expose "usage" summary as a resource
-  updated advanced tutorial for current release
-  fix bug which prevented deployments from being saved
-  fix bug which erased parameters starting with "http://"
-  fix deadlock associated with multiple database clients
-  fix run ordering by time
-  fix truncation of fields hiding information (popovers used
   everywhere)
-  improve rendering of errors to make the cause more visible

Migration
~~~~~~~~~

The migration procedures should be run in the order from the last stable
release to the current release.

From v2.8 (candidate) to v2.9 (stable)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

No migration required.

From v2.7 (stable) to v2.8 (candidate)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Database migration is required from v2.7 to v2.8. The following steps
MUST be followed:**

1. Upgrade SlipStream
2. Stop SlipStream

   ::

       $ service slipstream stop

3. Stop HSQLDB (or your DB engine)

   ::

       $ service hsqldb stop

4. Execute the following SQL script
   */opt/slipstream/server/migrations/014\_enumvalues\_size\_fix.sql*:

   ::

       $ java -jar /opt/hsqldb/lib/sqltool.jar --autoCommit --inlineRc=url=jdbc:hsqldb:file:/opt/slipstream/SlipStreamDB/slipstreamdb,user=sa,password= /opt/slipstream/server/migrations/014_enumvalues_size_fix.sql

5. Start HSQLDB (or your DB engine)

   ::

       $ service hsqldb start

6. Start SlipStream

   ::

       $ service slipstream start

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.7-community...v2.9-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.7-community...v2.9-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.7-community...v2.9-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.7-community...v2.9-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.7-community...v2.9-community>`__

v2.7 (stable) - 15 April 2015
-----------------------------

New features and bug fixes from v2.7
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Bug fixes for launching and accessing Windows virtual machines
-  Support for v5.5 of vCloud API
-  Allow input parameters to be specified for simple image run to avoid
   having to create a deployment for this
-  Add back App Store to the image chooser
-  Add custom error pages for SlipStream frontend proxy
-  Make forward/backward navigation more natural (avoid URLs with
   fragment changes in history)
-  Improve rendering of tables on mobile devices

Migration
~~~~~~~~~

No migration is required from v2.6.1 to v2.7.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.6.1-community...v2.7-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.6.1-community...v2.7-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.6.1-community...v2.7-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.6.1-community...v2.7-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.6.1-community...v2.7-community>`__

v2.6.1 (stable) - 7 April 2015
------------------------------

New features and bug fixes
~~~~~~~~~~~~~~~~~~~~~~~~~~

From 2.6 (candidate) to 2.6.1 (stable)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  UI critical bug fix: null pointer exception in the VMs section of
   dashboard
-  UI bug fix: 'Undefined' incorrectly prepended to 'Provisioning'
   message

From 2.5 (candidate) to 2.6 (candidate)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Expose event resource
-  Allow usage notes to be added to image and deployment modules
-  Filter VMs by User (for administrator) and by Run Owner
-  Add more node information in VM resources (UI and XML)
-  Allow input parameters for simple run
-  Allow
-  Improvements to VMs resource: additional node information, ability to
   filter by User/Run Owner/Run UUID
-  Ability to run an image with installation scripts even if the image
   has not been built.
-  Ensure that a module "copy" operation copies all fields
-  Fix for time zone parsing error
-  Ensure build image operation works
-  Fix bugs in v2.5 that caused SlipStream to stop responding to
   requests and that caused ready applications to be moved to
   "finalizing" incorrectly
-  Improve standard example applications: Ubuntu Standalone, CentOS
   Standalone, Wordpress, and LAMP++
-  Improve monitoring of service with collectd
-  Ensure time is aligned between SlipStream services by adding ntpd to
   SlipStream deployments
-  Move documentation to dedicated server and remove the embedded
   documentation from the SlipStream server
-  Numerous UI improvements: disactivating buttons when actions are not
   allowed, display user-friendly state in dashboard, improvements for
   touch devices, fix wrapping of fields on small devices, improve
   organization of sections in user profile

From v2.4.2 (stable) to v2.5 (candidate)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Added the Event server
-  Improved authorization mechinisme
-  Improved logging
-  Improved the collector
-  Improved stability of the /vms resource when there is a huge amount
   of VMs
-  Improved the Run dialog on the UI:
-  The Cloud for all node can be selected at one place
-  The two checkboxes in the user profile to define the ``keep running``
   behaviour was converted into a dropdown menu
-  The ``keep running`` behaviour can be redefined
-  Tags can be defined when creating a Run.
-  The value selected for ``Cloud`` and ``Keep running`` dropdown menus
   correspond to the default of the user profile.
-  It's now possible to create a Run even if there is no SSH key in the
   user profile
-  An error is displayed if SSH access is asked but there is no key in
   the user profile
-  Improved the time needed to terminate VMs with
   ``stratuslabiter-terminate-instances``.
-  Increased the maximum amount of items returned by /vms and /run to
   500
-  New packaging for the community edition.
-  Fixed a bug where deployment scripts were not executed when running a
   simple image.
-  Bugfixes

Migration
~~~~~~~~~

The migration procedures should be run in the order from the last stable
release to the current release.

From v2.6 (candidate) to v2.6.1 (stable)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

No migration necessary.

From v2.5 (candidate) to v2.6 (candidate)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You have to execute the following script (while HSQLDB is running) to do
the BD migration:

::

    java -jar /opt/hsqldb/lib/sqltool.jar --autoCommit --inlineRc=url=jdbc:hsqldb:hsql://localhost:9001/slipstream,user=sa,password= --sql "UPDATE VmRuntimeParameterMapping SET hostnameRuntimeParameterUri = CONCAT(REGEXP_SUBSTRING(vmstateRuntimeParameterUri,'^[^:]+'),':hostname') WHERE hostnameRuntimeParameterUri IS NULL;"

From 2.4.2 (stable) to v2.5 (candidate)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**IMPORTANT: v2.5 requires data migration from v2.4.2. The following
steps MUST be followed:**

1. Upgrade SlipStream
2. Ensure SlipStream is running
3. Execute the following python script *012\_edit\_save\_all\_users.py*
   from the directory */opt/slipstream/server/migrations/*

   ::

       $ cd /opt/slipstream/server/migrations/
       $ python 012_edit_save_all_users.py <username> <password>

   ``<username>`` and ``<password>`` have to be credentials of a
   SlipStream administrator.

4. Stop SlipStream

   ::

       $ service slipstream stop

5. Stop HSQLDB (or your DB engine)

   ::

       $ ss-db-shutdown

6. Execute the following SQL script
   */opt/slipstream/server/migrations/013\_convert\_to\_keep\_running.sql*:

   ::

       $ java -jar /opt/hsqldb/lib/sqltool.jar --inlineRc=url=jdbc:hsqldb:file:/opt/slipstream/SlipStreamDB/slipstreamdb,user=sa,password= /opt/slipstream/server/migrations/013_convert_to_keep_running.sql

7. Start HSQLDB (or your DB engine)

   ::

       $ service hsqldb start # ignore start error

8. Start SlipStream

   ::

       $ service slipstream start

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.4.2...v2.6.1-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.4.2...v2.6.1-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.4.2...v2.6.1-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.4.2...v2.6.1-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.4.2...v2.6.1-community>`__

v2.4.2 - 28 February 2015
-------------------------

New features and bug fixes from v2.4.0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Change monitoring implementation to avoid corrupted dashboard
   information
-  Improve monitoring implementation to avoid peaks in activity
-  Allow deployments to set a tolerance for provisioning failures
-  Fix bug that caused service catalog entries to be deleted
-  Allow style of UI to be more easily customized
-  Validate multiplicity values in deployments
-  SlipStream client now backs off and waits when server is loaded
-  Add network mapping parameters for OpenStack connector
-  Add pagination support for VM listings on dashboard
-  Optimize uploading of reports to improve performance
-  Numerous minor improvements and bug fixes in UI

Migration
~~~~~~~~~

**IMPORTANT: v2.4.2 requires data migration from v2.4.0. The following
steps MUST be followed:**

1. Stop SlipStream
2. Stop HSQLDB (or your DB engine)
3. Execute the following SQL files located in
   ``/opt/slipstream/server/migrations``:

-  ``011_add_maxprovisioningfailures_in_node.sql``

4. Start HSQLDB (or your DB engine)
5. Start SlipStream\*\*

Command to stop HSQLDB:

::

    java -jar /opt/hsqldb/lib/sqltool.jar --inlineRc=url=jdbc:hsqldb:hsql://localhost:9001/slipstream,user=sa,password= --sql 'SHUTDOWN;' 

Example command to execute the migration script:

::

    java -jar /opt/hsqldb/lib/sqltool.jar --autoCommit --inlineRc=url=jdbc:hsqldb:file:/opt/slipstream/SlipStreamDB/slipstreamdb,user=sa,password= /opt/slipstream/server/migrations/011_add_maxprovisioningfailures_in_node.sql

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.4.0...v2.4.2>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.4.0...v2.4.2>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.4.0...v2.4.2>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.4.0...v2.4.2>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.4.0...v2.4.2>`__

v2.4.1 - 20 February 2015
-------------------------

This release is deprecated because of problems discovered after
deployment. Use the v2.4.2 release.

v2.4.0 - 13 January 2015
------------------------

New features and bug fixes
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  New UI based on `Bootstrap <http://getbootstrap.com/>`__
-  Added export of users as CSV
-  Image Run will attach extra disk if defined in cloud parameters and
   the action is supported by the cloud connector
-  Minor updates and fixes in StratusLab and StratusLabIter connector

Migration
~~~~~~~~~

No DB migration (from v2.3.9) is required.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.3.9...v2.4.0>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.3.9...v2.4.0>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.3.9...v2.4.0>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.3.9...v2.4.0>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.3.9...v2.4.0>`__

v2.3.9 - 19 December 2014
-------------------------

New features and bug fixes
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Bugfix of the service catalog on the welcome page.
-  Improvements in documentation around traoubleshooting of the user
   deployments.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.3.8...v2.3.9>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.3.8...v2.3.9>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.3.8...v2.3.9>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.3.8...v2.3.9>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.3.8...v2.3.9>`__

v2.3.8 - 17 December 2014
-------------------------

Migration procedure
~~~~~~~~~~~~~~~~~~~

**IMPORTANT: v2.3.8 requires data migration from v2.3.7. The following
steps MUST be followed:**

1. Stop SlipStream
2. Stop HSQLDB (or your DB engine)
3. Execute the following SQL files located in
   ``/opt/slipstream/server/migrations``:

-  ``010_varchar_size_fix_3.sql``

4. Start HSQLDB (or your DB engine)
5. Start SlipStream\*\*

Command to stop HSQLDB:

::

    java -jar /opt/hsqldb/lib/sqltool.jar --inlineRc=url=jdbc:hsqldb:hsql://localhost:9001/slipstream,user=sa,password= --sql 'SHUTDOWN;' 

Example command to execute the migration script:

::

    java -jar /opt/hsqldb/lib/sqltool.jar --autoCommit --inlineRc=url=jdbc:hsqldb:file:/opt/slipstream/SlipStreamDB/slipstreamdb,user=sa,password= /opt/slipstream/server/migrations/010_varchar_size_fix_3.sql

New features and bug fixes
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Performance improvement for Runs with a big amount of VMs.
-  StratusLab connector was refactored.
-  Support Cloud images without wget preinstalled (fallback to curl).
-  Bug fixes.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.3.7...v2.3.8>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.3.7...v2.3.8>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.3.7...v2.3.8>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/SlipStreamConnectors-2.3.7...v2.3.8>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.3.7...v2.3.8>`__

v2.3.7 - 7 November 2014
------------------------

New features and bug fixes
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Refactored cloud connector base classes to simplify connector
   development and maintenance on both Java and Python parts.
-  EC2 connector: migrated to the AWS python-boto 2.32.
-  StratusLab connector: RPM name changed -
   ``slipstream-connector-stratuslab-python`` obsoletes
   ``stratuslab-slipstream-downloads``.
-  Bug fixes.

Migration
~~~~~~~~~

No DB migration (from v2.3.6) is required.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.3.6...SlipStreamServer-2.3.7>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.3.6...SlipStreamUI-2.3.7>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.3.6...SlipStreamClient-2.3.7>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/SlipStreamConnectors-2.3.6...SlipStreamConnectors-2.3.7>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.3.6...SlipStreamDocumentation-2.3.7>`__

v2.3.6 - 29 October 2014
------------------------

New features and bug fixes
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Removed all usage of the deprecated SSLv3
-  Prefer the usage of TLSv1 for secure communications.
-  Bug fixes

Migration
~~~~~~~~~

No DB migration (from v2.3.5) is required.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.3.5...SlipStreamServer-2.3.6>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.3.5...SlipStreamUI-2.3.6>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.3.5...SlipStreamClient-2.3.6>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.3.5...SlipStreamDocumentation-2.3.6>`__

v2.3.5 - 23 October 2014
------------------------

New features and bug fixes
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Removed autocreation of the users test and sixsq.
-  Improvement of the logging.
-  Fixed a bug where the ownership of a module can be changed implicitly
   when editing the module (#14).
-  Fixed a bug in the orchestrator that can generate a error in a
   mutable run (#15).
-  Fixed a bug in the StratusLab connector that prevent to Run an Image
   with an extra disk (#16).
-  Fixed a bug in the vCloud connector that prevent it to work with
   SlipStream v2.3.4+ (#17).
-  Added support for building an image with ss-execute.

Migration
~~~~~~~~~

No DB migration (from v2.3.4) is required.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.3.4...SlipStreamServer-2.3.5>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.3.4...SlipStreamUI-2.3.5>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.3.4...SlipStreamClient-2.3.5>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.3.4...SlipStreamDocumentation-2.3.5>`__

v2.3.4 - 3 October 2014
-----------------------

Migration procedure
~~~~~~~~~~~~~~~~~~~

**IMPORTANT: v2.3.4 requires data migration from v2.3.0. The following
steps MUST be followed:**

1. Stop SlipStream
2. Stop HSQLDB (or your DB engine)
3. Execute the following SQL files located in
   ``/opt/slipstream/server/migrations``:

-  ``008_runtimeparameter_new_name_column.sql``
-  ``009_embedded_authz_in_module.sql``

4. Start HSQLDB (or your DB engine)
5. Start SlipStream\*\*

Command to stop HSQLDB:

::

    java -jar /opt/hsqldb/lib/sqltool.jar --inlineRc=url=jdbc:hsqldb:hsql://localhost:9001/slipstream,user=sa,password= --sql 'SHUTDOWN;' 

Example command to execute the migration script:

::

    java -jar /opt/hsqldb/lib/sqltool.jar --autoCommit --inlineRc=url=jdbc:hsqldb:file:/opt/slipstream/SlipStreamDB/slipstreamdb,user=sa,password= /opt/slipstream/server/migrations/008_runtimeparameter_new_name_column.sql

New features and bug fixes
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Database performance improvement.
-  Added support of mutable Run in ss-execute.
-  All server-side connectors are now extracted in individual packages.
-  Added per-connector config files.
-  Improved XML importation.
-  Improved error reporting from SlipStream Clients to the SlipStream
   Server.
-  Increase the maximal size of runtime parameter values to 4096 bytes.
-  Fixed a bug which prevent to get the runtimeparameters 'ids' and
   'multiplicity' with ss-get.
-  Fixed a bug where a failure in a deployment script might not be
   detected.
-  Fixed a bug where deployment refuse to start if the cloudservice is
   set to 'default'.
-  Fixed a bug of circular reference in modules.
-  Updated the documentation.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.3.0...SlipStreamServer-2.3.4>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.3.0...SlipStreamUI-2.3.4>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.3.0...SlipStreamClient-2.3.4>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.3.0...SlipStreamDocumentation-2.3.4>`__

v2.3.0 - 14 August 2014
-----------------------

New features and bug fixes
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Mutable Run.
-  Some UI improvements related to the mutable run.
-  SlipStream Client is now tolerant to network fault.
-  Refactored the SlipStream Client. Connectors needs to be upgraded to
   work with this version.
-  Improved the security of all resources by generating a restricted
   cookie for each Run.
-  When Metering is disabled the data collection is now also disabled.
-  Overall performance improvements.

Migration
~~~~~~~~~

No DB migration (from v2.2.5) is required.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.2.5...SlipStreamServer-2.3.0>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.2.5...SlipStreamUI-2.3.0>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.2.5...SlipStreamClient-2.3.0>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.2.5...SlipStreamDocumentation-2.3.0>`__

v2.2.5 - 18 June 2014
---------------------

New features and bug fixes
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Some UI improvements related to the new state machine.
-  In the UI when a Run page is loaded the delay of 10 seconds before
   the first update of the overview section was removed.
-  Added the ability for privileged users to see the vmstate in the Runs
   of other users.
-  Improved the migration of the garbage collector.
-  Improved the logging and the error handling of describeInstance.
-  Fixed an HTTP 500 when there is no user-agent in the request.
-  Fixed a bug where when you try to build an image, run a deployment or
   run an image, the latest version is always used even if you were not
   on the latest version when creating the Run.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.2.4...SlipStreamServer-2.2.5>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.2.4...SlipStreamUI-2.2.5>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.2.4...SlipStreamClient-2.2.5>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.2.4...SlipStreamDocumentation-2.2.5>`__

v2.2.4 - 13 June 2014
---------------------

Migration procedure
~~~~~~~~~~~~~~~~~~~

**IMPORTANT: v2.2.4 requires data migration from v2.2.3. The following
steps MUST be followed:**

1. Stop SlipStream
2. Stop HSQLDB (or your DB engine)
3. Execute the SQL files located in
   ``/opt/slipstream/server/migrations`` (files 006 and 007)
4. Start HSQLDB (or your DB engine)
5. Start SlipStream\*\*

Example command to execute the migration script:

::

    java -jar /opt/hsqldb/lib/sqltool.jar --debug --autoCommit --inlineRc=url=jdbc:hsqldb:file:/opt/slipstream/SlipStreamDB/slipstreamdb,user=sa,password= /opt/slipstream/server/migrations/006_run_states_fix.sql

New features and bug fixes
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  New State Machine.
-  New logic for the garbage collector.
-  Auto-discovery of connectors.
-  Fixed a bug where module parameters disappear of the old version when
   a new version is saved.
-  Improved some RuntimeParameters.
-  Fixed a bug where SSH login with keys doesn't work on images with
   SELinux enabled.
-  Improved messages displayed during a Build.
-  Added target script termination when abort flag is raised.
-  Improved the detection of VMs not killed in a final state.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.2.3...SlipStreamServer-2.2.4>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.2.3...SlipStreamUI-2.2.4>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.2.3...SlipStreamClient-2.2.4>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.2.3...SlipStreamDocumentation-2.2.4>`__

v2.2.3 - 2 June 2014
--------------------

New features and bug fixes
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Improved error handling of CloudStack connector
-  Fixed a bug with SSH (paramiko)
-  Updated RPM packaging of SlipStream client
-  Updated xFilesFactor of graphite. For local update run the following

   for f in $(find /var/lib/carbon/whisper/slipstream/ -name \*.wsp); do
   whisper-resize $f --xFilesFactor=0 --aggregationMethod=max 10s:6h
   1m:7d 10m:5y; done

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.2.2...SlipStreamServer-2.2.3>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.2.2...SlipStreamUI-2.2.3>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.2.2...SlipStreamClient-2.2.3>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.2.2...SlipStreamDocumentation-2.2.3>`__

v2.2.2 - 27 May 2014
--------------------

New features and bug fixes
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Updated CloudStack connector to use the new TasksRunner when
   terminating instances
-  Force draw on usage panel, since now default section

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.2.1...SlipStreamServer-2.2.2>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.2.1...SlipStreamUI-2.2.2>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.2.1...SlipStreamClient-2.2.2>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.2.1...SlipStreamDocumentation-2.2.2>`__

v2.2.1 - 26 May 2014
--------------------

Migration procedure
~~~~~~~~~~~~~~~~~~~

**IMPORTANT: v2.2.1 requires data migration from v2.2.0. The following
steps MUST be followed:**

1. Stop SlipStream
2. Stop HSQLDB (or your DB engine)
3. Execute the SQL files located in
   ``/opt/slipstream/server/migrations`` (file 005)
4. Start HSQLDB (or your DB engine)
5. Start SlipStream\*\*

New features and bug fixes
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Multi-thread bulk VM creation can be limited for clouds that can't
   cope
-  Added support for CloudStack Advanced Zones as a sub-connector
-  Fix issues related to API doc and xml processing
-  Made c3p0 optional (see
   jar-persistence/src/main/resources/META-INF/persistence.xml for
   details)
-  Add persistence support for MySQL and Postgres
-  Update the OpenStack connector to use the new OpenStack CLI
-  Update poms following SlipStreamParent -> SlipStream git repo rename
-  Upgrade c3p0 version
-  Now using Apache HTTP client connector unstead of default Restlet
   Client connector
-  Streamline log entries for asynchronous activity
-  Upgrade Restlet to v2.2.1
-  Metering update communicate via temporary file instead of stdin
-  Remove StratusLab from default configuration
-  Fix strange orm issue with JPA 2.0
-  A few more minor bug fixes

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.2.0...SlipStreamServer-2.2.1>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.2.0...SlipStreamUI-2.2.1>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.2.0...SlipStreamClient-2.2.1>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.2.0...SlipStreamDocumentation-2.2.1>`__

v2.2.0 - 10 May 2014
--------------------

Migration procedure
~~~~~~~~~~~~~~~~~~~

**IMPORTANT: v2.2.0 requires data migration from v2.1.x. The following
steps MUST be followed:**

1. Stop SlipStream
2. Stop HSQLDB (or your DB engine)
3. Execute the SQL files located in
   ``/opt/slipstream/server/migrations`` (files 001..004)
4. Start HSQLDB (or your DB engine)
5. Start SlipStream\*\*

New features and bug fixes
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Fixed performance issue under heavy load due to HashMap causing
   infinite loop
-  Wrapping parameters of Parameterized into ConcurrentHashMap
-  Improved asynchronious behaviour
-  Improved metering feature
-  Removed dependency on jclouds-slf4j
-  Removed hibernate3 maven plugin
-  Added SQL migration scripts
-  Removed Nexus tasks for repo generation
-  Migrate to Hibernate 4.3.5
-  Fix checkbox not set correctly in edit mode for user
-  Enable c3p0 database connection pooling by default
-  Improve ergonomics of run dashboard
-  Fixed issue with the metering legend items ending with a parenthesis
-  Fix several minor bug

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.1.16...SlipStreamServer-2.2.0>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.1.16...SlipStreamUI-2.2.0>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.1.16...SlipStreamClient-2.2.0>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.1.16...SlipStreamDocumentation-2.2.0>`__
