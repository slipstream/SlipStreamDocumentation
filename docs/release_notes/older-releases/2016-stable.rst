
2016 Stable Releases
====================

v3.14 (stable) - 31 October 2016
--------------------------------

Features
~~~~~~~~

Below is the list of the main feature and improvements done in
releases 3.9 to 3.14.

 - Improvements in the functionality of the placement and ranking service.
 - Added complete set of resources for the Service Catalog (Enterprise
   Edition), allowing policy (and priced) based placement of virtual
   machines.
 - Introduced complete Clojure and ClojureScript API for the SlipStream
   CIMI resources.
 - This set of releases provides much of the groundwork for future
   improvements.  The emphasis has been on preparing new server-side
   resources for cloud connectors and service configuration; these will
   improve the management of these resources in the future.  There has
   also been significant work done to streamline the code organization,
   packaging, and release process.  This should speed development of
   new features.
 - Added the delete all versions feature for a module.

The detailed change log is given below.  For brevity bug fixes have
not been included, see the change logs for the intermediate releases
for the full set of changes and fixes.

For application users and developers [Alice, Clara]:
 - Provide pricing along with a filtered set of connectors on the run
   dialog. (Enterprise Edition)
 - Improve the bootstrapping process to avoid having the process hang
   on CentOS 6 systems.
 - Provide complete set of service catalog resources (serviceOffer,
   serviceAttribute, and serviceAttributeNamespace) to allow
   policy-based placement using the service catalog
   information. (Enterprise Edition)
 - Provide clojure/clojurescript API for SlipStream CIMI resources.
   The API provides asynchronous and synchronous implementations of
   all SCRUD actions.  Filtering and subsetting are provided for
   search operations.
 - Use larger modal dialog to avoid truncating long parameter or
   component names in run dialog.
 - Alpha versions of connector and configuration resources.  These are
   available through the API and will be integrated into the web
   interface in a future release.
 - Increase the allowed maximum size of a report.
 - Pass SNI information to backend services.
 - Add the delete all versions for a module.

For application users [Alice]:
 - Provide a better message when a cloud quota has been exceeded.  The
   message now includes the quota, number of running VMs, and number
   of requested VMs.

For application developers [Clara]:
 - Allow application developers to specify a placement policy for
   application components, for example, limiting the places where a
   component can run. (Enterprise Edition)
 - Improve the error messages reported to users of the SlipStream
   client API, providing more information about the underlying cause
   of a problem.
 - Selection of specific network for opennebula connector.

For administrators [Dave]:
 - Streamline the installation of SlipStream with a packaged version
   of PhantomJS and with a package for the Elasticsearch
   repositories.
 - Modify service dependencies to ensure cleaner start up of all
   SlipStream services on boot.
 - Improve the collection of virtual machine state information (used
   in the dashboard) to make it more efficient and reliable.  Put in
   additional logging to make debugging easier.
 - Upgrade to the latest production libraries for all server
   dependencies, improving the robustness of the server (in particular
   Aleph, Buddy, and ClojureScript).
 - Clean up and reorganize the packaging for the pricing service.
   Logging information will now appear in the standard OS directory.
 - Unify build system with boot for clojure code.

The Alice, Bob, Clara, and Dave personae_ can be found on the SixSq
website.

Migration
~~~~~~~~~

No migration is required from 3.8 to 3.14.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.8-community...v3.14-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.8-community...v3.14-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.8-community...v3.14-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.8-community...v3.14-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v3.8-community...v3.14-community>`__


==================================================================


v3.8 (stable) - 15 July 2016
----------------------------

Features
~~~~~~~~

Version v3.8 is the first stable release of the v3 series.  There are
major underlying changes to make this release more stable, robust, and
performant, including the introduction of Elasticsearch as a database (hsqldb still needed until the transition to Elastisearch is complete),
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

The Alice, Bob, Clara, and Dave personae_ can be found on the SixSq
website.

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

   The command below is required to be run if you are upgrading an
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

- The process that collects information abouts users' virtual machines
  can become saturated, resulting in the loss of this information for
  most users.  When this issue appears, the slipstream service can be
  restarted to return it to a normal state.

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

The Alice, Bob, Clara, and Dave personae_ can be found on the SixSq
website.

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

.. _personae: http://sixsq.com/personae/
