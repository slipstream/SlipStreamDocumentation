Candidate Releases
==================

Results from each development cycle are packaged into candidate
releases. We welcome feedback on these releases; however, these are
**not** supported and **not** recommended for production deployments.

v3.3 (candidate) - 12 May 2016
------------------------------

New features and bug fixes in v3.3
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Because of a serious authentication bug that was introduced, this
release has been removed from the YUM package repository.**

For application users and developers [Alice, Clara]:
 - Added a field in the dashboard run list that indicates how many
   active VMs are associated with the run.

For application developers [Clara]:
 - Use readable names for downloaded deployment scripts to make
   debugging easier.
 - Move deployment scripts out of ``/tmp`` to avoid them disappearing
   on reboots.
 - Ensure that parameter values starting with a dash do not disrupt
   the application deployment.
 - Fix GET action of ss:groups parameter.

For SlipStream administrators [Dave]:
 - Fixed module download/upload cycle so that migration of modules
   between servers works.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is needed from v3.2 to v3.3.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.2-community...v3.3-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.2-community...v3.3-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.2-community...v3.3-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.2-community...v3.3-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v3.2-community...v3.3-community>`__

v3.2 (candidate) - 21 April 2016
--------------------------------

New features and bug fixes in v3.2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For application users and developers [Alice, Clara]:
 - Rename service catalog offers (service-offer) and attribute
   (service-attribute) resources for consistency.
 - Fix problem with application component scale up from an initial
   multiplicity of 0.
 - REST API more strictly validates its inputs on scale up/down
   requests. 
 - Add functions to the clojure client API to launch and terminate
   applications.

For SlipStream administrators [Dave]:
 - Improve logging by providing full URIs of application components.
 - Fix error in script that prevented the service from being started. 
 - Install service catalog by default (Enterprise Edition).

For application users, developers, and SlipStream administrators [Alice, Clara, Dave]:
 - Remove the save button on the service catalog when user isn't
   authorized to make changes.
 - Add a "+" to dashboard to make it easier to configure new cloud
   connectors. 
 - Make application thumbnails clickable in the App Store.
 - Add terminated icon to terminated VMs in the dashboard.
 - Fix serialization and calculation of usage information.
 - Fix vCloud connector so that node multiplicity works correctly.
 - Fix navigation and inactive run filter on the run page.
 - Fix refresh for the list of runs on application and application
   component pages. 
 - Fix client-side code for sanitizing tags provided by users.
 - Fix presentation of the gauges in the dashboard.
 - Fix a problem where non-pending VMs were mistakenly marked as
   pending.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is needed from v3.1 to v3.2.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.1-community...v3.2-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.1-community...v3.2-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.1-community...v3.2-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.1-community...v3.2-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v3.1-community...v3.2-community>`__

v3.1 (candidate) - 2 April 2016
-------------------------------

New features and bug fixes in v3.1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For managers and super users [Bob]:
 - Cloud managers can now see an overview of the activity on their
   cloud from all users.

For SlipStream administrators [Dave]:
 - Allow direct proxying of the two SlipStream services through nginx
   to provide more efficient and reliable system.
 - Improved installation and testing scripts.
 - Fix virtual machine state mapping for the OpenNebula connector.
 - Fix build image functionality for the OpenStack connector.
 - Fix various server-side exceptions to avoid "internal server error"
   responses.
 - Remove unnecessary logging to make the server activity easier to
   understand.

For application users and developers [Alice, Clara]:
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

For application users, developers, and SlipStream administrators [Alice, Clara, Dave]:
 - Update the general and API documentation to consistently use
   "scalable" runs for those that can be dynamically scaled while
   running.

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

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.0-community...v3.1-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.0-community...v3.1-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.0-community...v3.1-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.0-community...v3.1-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v3.0-community...v3.1-community>`__

v3.0 (candidate) - 7 March 2016
-------------------------------

New features and bug fixes in v3.0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For managers and super users [Bob]:
 - Provide better header information in the browser UI when a manager
   or super users is viewing information from several users.

For SlipStream administrators [Dave]:
 - **SlipStream must now be deployed on CentOS 7.** All services have
   been updated to support systemd only.  Caches have been moved from
   `/tmp` and `/var/tmp` to avoid startup problems.

For application users, developers, and SlipStream administrators [Alice, Clara, Dave]:
 - Improve query performance when retrieving event resources through
   the API and in the UI.
 - Improve graphical feedback when viewing virtual machines to
   indicate those that are not known to SlipStream.
 - OpenNebula connector allows custom template fields to be
   specified to, for example, attach hardware devices or consoles.
 - Fix a bug in the AWS connector that caused the creation of the
   'slipstream_managed' security group to fail.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

Because SlipStream v3 requires the CentOS 7 operating system, an
upgrade from the SlipStream v2 series to the SlipStream v3 series
requires a complete database migration from the old machine to a new
one running CentOS 7.  Details for this migration will come with a
subsequent release.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.23.2-community...v3.0-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.23.2-community...v3.0-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.23.2-community...v3.0-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.23.2-community...v3.0-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.23.2-community...v3.0-community>`__


v2.23.2 (stable) - 3 March 2016
-------------------------------

New features and bug fixes in v2.23.2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For SlipStream administrators [Dave]:
 - Fix a packaging bug that caused the Service Catalog resources not
   to appear.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

Database migration is **not** required from v2.23.1 to v2.23.2.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.23.1-community...v2.23.2-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.23.1-community...v2.23.2-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.23.1-community...v2.23.2-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.23.1-community...v2.23.2-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.23.1-community...v2.23.2-community>`__


v2.23.1 (candidate) - 22 February 2016
--------------------------------------

New features and bug fixes in v2.23.1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For application developers [Clara]:
 - Fixed issues with command line client so that the ``ss-get
   --noblock`` option works correctly, ``ss-abort`` no longer requires a
   message, and the ``ss-execute`` option ``--mutable-run`` has been
   changed to ``--scalable``.
 - Refactored client clojure API to make actions/functions correspond
   better to end user needs.
 - Fix a bug in which the same resource could be added twice.

For SlipStream administrators [Dave]:
 - Fix packaging issue which left out scripts for periodic usage
   analysis.

For application users, developers, and SlipStream administrators [Alice, Clara, Dave]:
 - Improved application state handling to avoid race conditions
   leading to failures when scaling an application.
 - Improve OpenStack connector to reduce time to retrieve the IP
   address, to order parameters consistently, and to fix a problem
   where the domain parameter was ignored.
 - Extend the OpenStack connector to support the Keystone API v3.
 - Stratuslab connector has improved logging of networking errors.
 - CloudStack connector now supports multiple zones.
 - AWS connector uses only the first SSH key to create a keypair to
   avoid deployment failures.
 - New terminology (application, component, image) is now the default
   in the user interface.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

Database migration is **not** required from v2.23 to v2.23.1.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.23-community...v2.23.1-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.23-community...v2.23.1-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.23-community...v2.23.1-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.23-community...v2.23.1-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.23-community...v2.23.1-community>`__


v2.23 (candidate) - 13 February 2016
------------------------------------

New features and bug fixes in v2.23
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For application users and developers [Alice, Clara]:
 - Provide new Service Catalog (enterprise) implementation along with
   API documentation for the new ServiceInfo and Attribute resources.

For application developers [Clara]:
 - An alpha version of a Clojure API has been created that supports
   scale up/down features.
 - Fix application logging when verbosity level is 0.

For SlipStream administrators [Dave]:
 - Optimize data flow by using nginx to route requests to the
   appropriate SlipStream services.

For application users, developers, and SlipStream administrators [Alice, Clara, Dave]:
 - Error handling when starting and stopping runs has been improved.
 - CloudStack and Exoscale (enterprise) connectors now support
   multiple zones.
 - OpenStack connector now supports the Keystone API v3 and has been
   streamlined to avoid unnecessary API calls.
 - OpenStack connector has been fixed to accommodate new VM states.
 - StratusLab, OpenStack connectors have improved error messages.
 - There is now an example application that demonstrates autoscaling.
 - A SoftLayer connector (enterprise) that uses native SoftLayer
   API and that supports vertical scaling is now available.
 - Fix problem with vCloud connector (enterprise) caused by missing VM
   states.
 - Fix Firefox display issues for message display and gauges on
   dashboard.
 - Fix bootstrapping failures on Ubuntu 14.04.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

Database migration is **not** required from v2.22 to v2.23.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.22-community...v2.23-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.22-community...v2.23-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.22-community...v2.23-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.22-community...v2.23-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.22-community...v2.23-community>`__


v2.22 (candidate) - 5 February 2016
------------------------------------

New features and bug fixes in v2.22
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For application users and developers [Alice, Clara]:
 - Workaround application logging problem at log level 0
 - Improve error reporting from the node executor

For SlipStream administrators [Dave]:
 - Roles for users can now be defined by the system administrator
 - Remove unnecessary information from service error logs
 - Update third-party dependencies for robustness and stability

For application users, developers, and SlipStream administrators [Alice, Clara, Dave]:
 - Support GitHub authentication
 - Azure connector fully working for linux-based applications
 - Fix problem that prevented horizontal scale down from working
 - Fix poor or misleading authentication error messages

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

**Database migration is required from v2.21 to v2.22.  The following steps
MUST be followed:**

1. Upgrade SlipStream
2. Stop SlipStream

   ::

       $ service slipstream stop

3. Stop HSQLDB (or your DB engine)

   ::

       $ service hsqldb stop

4. Execute the following SQL script
   */opt/slipstream/server/migrations/017\_add\_external\_login.sql*:

   ::

       $ java -jar /opt/hsqldb/lib/sqltool.jar --autoCommit --inlineRc=url=jdbc:hsqldb:file:/opt/slipstream/SlipStreamDB/slipstreamdb,user=sa,password= /opt/slipstream/server/migrations/017\_add\_external\_login.sql

5. Start HSQLDB (or your DB engine)

   ::

       $ service hsqldb start

6. Start SlipStream

   ::

       $ service slipstream start


Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.21-community...v2.22-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.21-community...v2.22-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.21-community...v2.22-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.21-community...v2.22-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.21-community...v2.22-community>`__


v2.21 (candidate) - 18 December 2015
------------------------------------

New features and bug fixes in v2.21
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For application users and developers [Alice, Clara]:
 - The Dashboard can now filter out inactive runs, allowing you to
   focus on your running applications.
 - On the Dashboard and in the Run Dialog, only those clouds that you
   have configured are shown, reducing visual clutter on the page.

For SlipStream administrators [Dave]:
 - Roles can now be added to a user profile.  Those roles can
   eventually be used in the ACLs (Access Control Lists) for
   resources.
 - The RPM packaging has been improved for several components, in
   particular marking configuration files so that they are not
   overwritten on upgrades.
 - Spurious authentication failures after a server restart have been
   eliminated.

For application users, developers, and SlipStream administrators [Alice, Clara, Dave]:
 - OpenNebula cloud infrastructures can now be accessed from
   SlipStream.
 - SoftLayer cloud infrastructures can now be accessed from SlipStream
   Enterprise Edition deployments.
 - The foundations for a new implementation of service catalog with
   definable attributes have been laid.  This will eventually allow
   advanced searching of cloud services that can be used for automated
   placement of applications.
 - The SlipStream testing pipeline has been extended, providing more
   thorough testing and a more stable service for you.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

Database migration is **not** required from v2.20 to v2.21.


Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.20-community...v2.21-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.20-community...v2.21-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.20-community...v2.21-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.20-community...v2.21-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.20-community...v2.21-community>`__


v2.20 (candidate) - 4 December 2015
-----------------------------------

New features and bug fixes in v2.20
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For application users [Alice]:
 - Improve text and workflow of the embedded SlipStream tour text,
   making it easier understand and follow.

For application users and developers [Alice, Clara]:
 - The events on the "run page" that shows the details of a cloud
   application deployment are automatically refreshed, making it
   easier to follow the timeline of an application.
 - Fix a bug which caused virtual machines that were removed from the
   deployment via the "scale-down" feature to not be terminated
   correctly.

For application developers [Clara]:
 - The organization of the archive (tarball) containing the reports
   has been flattened, making navigation to the reports easier.
 - A script can now be defined for the orchestrator, which allows
   deployment-wide actions for an application.  (Warning: beta
   feature!).

For SlipStream administrators [Dave]:
 - Better consistency when setting the SlipStream theme: the method
   for configuring the default and non-default themes is now uniform.
 - Extend the custom style sheet to allow the background of the active
   menubar items to be set within a theme.
 - Performance metrics related to the SlipStream servers themselves
   are now pushed to the local Graphite server, where they can be
   viewed.
 - Username validation at registration is more strict to avoid
   creation of accounts which wouldn't work correctly.
 - Correct the CloudStack connector packaging which could cause the
   symbolic links to CloudStack connector commands to be removed.
 - Refine the nginx rate limits so that they do not kick in for normal
   usage levels.
 - Fix a bug where the administrator ("super") would not see the
   events for all application deployments.

For everyone [Alice, Bob, Clara, Dave]:
 - Weekly and monthly summaries of the cloud resource usage are
   available, in addition to the existing daily summary.
 - New events have been added that provide a broader view of important
   actions within the SlipStream server and managed cloud
   applications.  The events indicate when the server was
   started/stopped, when user profiles are updated, and when the
   server configuration changes.
 - Make the application deployment workflow more reliable by introducing
   retries when encountering transient failures.
 - Fix a bug where the usage records could be incorrect if the
   SlipStream server was restarted.
 - Fix pagination of entries on the run and module displays.
   Requesting a new page happens immediately rather than waiting for
   the next automatic refresh cycle.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

**Database migration is required from v2.19.1 to v2.20.
The following steps MUST be followed:**

1. Upgrade SlipStream
2. Stop SlipStream

  ::

      $ service slipstream stop

3. Stop HSQLDB (or your DB engine)

  ::

      $ service hsqldb stop

4. Execute the following SQL script */opt/slipstream/server/migrations/016_add_frequency_usage.sql*:

  ::

      $ java -jar /opt/hsqldb/lib/sqltool.jar --autoCommit --inlineRc=url=jdbc:hsqldb:file:/opt/slipstream/SlipStreamDB/sscljdb,user=sa,password= /opt/slipstream/server/migrations/016_add_frequency_usage.sql

5. Start HSQLDB (or your DB engine)

  ::

      $ service hsqldb start

6. Delete all usage_summaries, and recompute them thanks to summarizer script:

::

    $ java -Dconfig.path=db.spec -cp \ "/opt/slipstream/ssclj/resources:/opt/slipstream/ssclj/lib/ext/*:/opt/slipstream/ssclj/lib/ssclj.jar" \
     com.sixsq.slipstream.ssclj.usage.summarizer -f <frequency> -n <nb-in-past>

Use 'daily, 'weekly' and 'monthly' for '-f' option.
Adapt value given to '-n' option for each frequency.

7. Start SlipStream

  ::

      $ service slipstream start



Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.19.1-community...v2.20-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.19.1-community...v2.20-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.19.1-community...v2.20-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.19.1-community...v2.20-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.19.1-community...v2.20-community>`__


v2.19.1 (candidate) - 17 November 2015
--------------------------------------

New features and bug fixes in v2.19.1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For everyone [Alice, Bob, Clara, Dave], a couple bug fixes:
 - Fix instabilities in the authentication system that caused erratic
   behavior.
 - Make the application deployment workflow more reliable by introducing
   retries when encountering transient failures.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

Database migration is **not** required from v2.19 to v2.19.1.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.19-community...v2.19.1-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.19-community...v2.19.1-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.19-community...v2.19.1-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.19-community...v2.19.1-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.19-community...v2.19.1-community>`__


v2.19 (candidate) - 12 November 2015
------------------------------------

New features and bug fixes in v2.19
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For users [Alice, Clara]:
 - The run page has been enhanced to show the time-ordered list of
   events associated with a run.
 - The vocabulary in the interface has been made more clear and
   precise to make understanding SlipStream easier.

For users [Alice, Clara] and administrators [Dave]:
 - There is now a prototype (alpha) Azure connector available, which
   will be extended to a production connection over the next couple of
   releases.
 - There is a specialized cloud connector for the Exoscale cloud
   platform that allows images to be referenced by name, disk sizes to
   be controlled, and platform-specific instance sizes.
 - Allow the proper inheritance of image parameters to avoid having to
   edit/save child images when a parent has been modified.

For administrators [Dave]:
 - There is now a configuration option that will allow server metrics
   (e.g. request responses, request rates, service resource usage) to
   be pushed to a Graphite server.
 - Logging levels have been reduced in many cases to avoid noise in the
   logs.
 - A new authentication system is being used that will allow external
   authentication mechanisms to be used for a SlipStream server.
 - SElinux can now be used for the machine running the SlipStream
   server, allowing the service to be more tightly secured.

For everyone [Alice, Bob, Clara, Dave], a few bug fixes:
 - Modify the introductory tour to follow the new application layout.
 - When an attribute error is raised, provide a correct error message
   rather than a misleading one referring to an illegal state.
 - Upgrade internal SSH libraries to allow deployment to work with
   newer versions of Ubuntu (15.04+).
 - Correct a problem that caused new projects to be created but not
   visible.
 - Truncate log error messages in run parameters to avoid masking the
   real error with an internal server error (500).

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

Database migration is **not** required from v2.18 to v2.19.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.18-community...v2.19-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.18-community...v2.19-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.18-community...v2.19-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.18-community...v2.19-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.18-community...v2.19-community>`__


v2.18 (candidate) - 23 october 2015
-----------------------------------

New features and bug fixes in v2.18
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Make the Dashboard the landing page for users
-  Dashboard, Modules, App Store, and Service Catalog are split in the
   UI and have direct links from top menubar
-  Include root disk volumes for StratusLab clouds
-  Improve units for displaying cloud resource usage
-  Consolidated monthly usage available through API
-  Improve EC2 connector to catch errors related to VPC change and to
   provide more informative error message
-  fix: add missing module in SlipStream client package for `pip`
   (affected `ss-config-dump` command)

Migration
~~~~~~~~~

**Database migration is required from v2.17 to v2.18. The following steps
MUST be followed:**

1. Upgrade SlipStream
2. Stop SlipStream

   ::

       $ service slipstream stop

3. Stop HSQLDB (or your DB engine)

   ::

       $ service hsqldb stop

4. Execute the following SQL script
   */opt/slipstream/server/migrations/015_compute_timestamp_usage.sql*:

   ::

       $ java -jar /opt/hsqldb/lib/sqltool.jar --autoCommit --inlineRc=url=jdbc:hsqldb:file:/opt/slipstream/SlipStreamDB/sscljdb,user=sa,password= /opt/slipstream/server/migrations/015_compute_timestamp_usage.sql

5. Start HSQLDB (or your DB engine)

   ::

       $ service hsqldb start

6. Start SlipStream

   ::

       $ service slipstream start

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.17-community...v2.18-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.17-community...v2.18-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.17-community...v2.18-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.17-community...v2.18-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.17-community...v2.18-community>`__


v2.17 (candidate) - 5 october 2015
----------------------------------

New features and bug fixes in v2.17
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Allow use of the http-kit or aleph web application containers
   (clojure server)
-  Allow initialization of resources before starting server (clojure
   server)
-  Clean up main and server namespaces for ssclj server (clojure server)
-  After launching a run, the user gets redirected to the dashboard
   (previously the redirection was to the run page)
-  Add back the environment variable SLIPSTREAM\_CONNECTOR\_INSTANCE
-  fix: terminate button is properly updated after closing dialog in the
   dashboard
-  fix: fixed an issue which prevented multi-cloud deployment to work
-  fix: add missing index in resources table (clojure server)

Migration
~~~~~~~~~

A database migration from v2.16 to v2.17 is not needed.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.16-community...v2.17-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.16-community...v2.17-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.16-community...v2.17-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.16-community...v2.17-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.16-community...v2.17-community>`__

v2.16 (candidate) - 18 September 2015
-------------------------------------

New features and bug fixes in v2.16
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  HTML representations of event and usage resources available
-  improved configuration for cloud connector configuration
-  upgrade to latest libcloud release (0.18.0) for all connectors
-  allow easier automated installation from configuration files
-  allow finer control over information dumped in ``ss-config-dump``
-  create open security group to avoid app. failures on clouds that
   support it
-  add prototype user-editable service catalog (enterprise)
-  fix: ``ss-config-dump`` for unaliased connector names
-  fix: reintroduce older EC2 VM sizes
-  fix: allow multiple versions of Java on SlipStream machines
-  fix: missing python dependency in packages for cloud connectors
-  fix: incorrect path for dependency in OpenStack and CloudStack
   connectors
-  fix: run parameters not shown on image module

Migration
~~~~~~~~~

A database migration from v2.15 to v2.16 is not needed. However, when
upgrading from previous versions two files must be renamed by hand:

-  ``mv /etc/default/slipstream.rpmnew /etc/default/slipstream``
-  ``mv /etc/default/ssclj.rpmnew /etc/default/ssclj``

This is not needed on a fresh installations of v2.16.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.15-community...v2.16-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.15-community...v2.16-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.15-community...v2.16-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.15-community...v2.16-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.15-community...v2.16-community>`__


v2.15 (candidate) - 29 August 2015
----------------------------------

New features and bug fixes in v2.15
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  documentation for horizontal and vertical scaling of applications
   (horizontal scaling is supported by all connectors; **vertical
   scaling is currently only supported by flexiant and okeanos
   connectors**)
-  update terminology in UI: mutable changed to scalable
-  dashboard improvements: auto-refresh, service URL link, and terminate
   button
-  improve layout of workflow scripts on image modules
-  allow SlipStream configuration to be dumped and restored from files
-  change location of log files to permanent ``/var/log/slipstream``
   location
-  upgrade jetty (9.3.2), libcloud (0.18.0), and other java/clojure
   dependencies
-  fix: failures on CloudStack connector when service returns empty body
   in requests
-  fix: make CIMI CloudEntryPoint conform to standard
-  fix: pagination in image and deployment pages
-  fix: pagination in run section of a module

Migration
~~~~~~~~~

A database migration from v2.14 to v2.15 is not needed.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.14-community...v2.15-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.14-community...v2.15-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.14-community...v2.15-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.14-community...v2.15-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.14-community...v2.15-community>`__

v2.14 (stable) - 13 August 2015
-------------------------------

New features and bug fixes in v2.14
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  add SlipStream instance to the text of usage email messages
-  mark Java 1.7 as conflicting with SlipStream RPM package installation
-  improve mechanism for initial bootstrap configuration of server from
   configuration files
-  change URLs for event (and other clojure) resources from camel-case
   to kebab-case
-  change change CIMI root resource api/CloudEntryPoint
-  fix: pagination of results in UI
-  fix: crash of node executor on empty target script output

Migration
~~~~~~~~~

A database migration from v2.13 to v2.14 is not needed.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.13-community...v2.14-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.13-community...v2.14-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.13-community...v2.14-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.13-community...v2.14-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.13-community...v2.14-community>`__

v2.13 (candidate) - 30 July 2015
--------------------------------

New features and bug fixes in v2.13
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

Migration
~~~~~~~~~

A database migration from v2.12 to v2.13 is not needed.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.12-community...v2.13-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.12-community...v2.13-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.12-community...v2.13-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.12-community...v2.13-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.12-community...v2.13-community>`__

v2.12 (candidate) - 10 July 2015
--------------------------------

New features and bug fixes in v2.12
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

Migration
~~~~~~~~~

A database migration from v2.11 to v2.12 is not needed.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.11-community...v2.12-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.11-community...v2.12-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.11-community...v2.12-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.11-community...v2.12-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.11-community...v2.12-community>`__

v2.11 (candidate) - 22 June 2015
--------------------------------

New features and bug fixes in v2.11
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

Migration
~~~~~~~~~

A database migration from v2.10 to v2.11 is not needed.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.10-community...v2.11-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.10-community...v2.11-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.10-community...v2.11-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.10-community...v2.11-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.10-community...v2.11-community>`__

v2.10 (candidate) - 7 June 2015
-------------------------------

New features and bug fixes in v2.10
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

A database migration from v2.9 to v2.10 is not needed.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.9-community...v2.10-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.9-community...v2.10-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.9-community...v2.10-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.9-community...v2.10-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.9-community...v2.10-community>`__

v2.9 (stable) - 18 May 2015
---------------------------

New features and bug fixes in v2.9
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  only allow configured clouds to be used in UI
-  provide pagination of event and usage resources
-  package scripts for preparing usage summaries
-  reduce resource requirements for collected metrics
-  patch timezone handling bug in UI
-  fix storage of service configuration enum parameters
-  remove unnecessary dependencies in build artifacts

Migration
~~~~~~~~~

A database migration from v2.8 to v2.9 is not needed.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.8-community...v2.9-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.8-community...v2.9-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.8-community...v2.9-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.8-community...v2.9-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.8-community...v2.9-community>`__

v2.8 (candidate) - 29 April 2015
--------------------------------

New features and bug fixes in v2.8
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  allow connectors to indicate when a VM is usable (for usage records)
-  improve logging (more concise messages, longer retention times)
-  provide quick installation script with documentation of procedure
-  provide "event" resource with standard lifecycle events
-  expose "usage" summary as a resource
-  updated advanced tutorial for current release
-  fix bug which prevented deployments from being saved
-  fix bug which erased parameters starting with ``http://``
-  fix deadlock associated with multiple database clients
-  fix run ordering by time
-  fix truncation of fields hiding information (popovers used
   everywhere)
-  improve rendering of errors to make the cause more visible

Migration
~~~~~~~~~

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

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.7-community...v2.8-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.7-community...v2.8-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.7-community...v2.8-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.7-community...v2.8-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.7-community...v2.8-community>`__

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

**This release has been promoted to a stable release.**

New features and bug fixes from v2.6
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  UI critical bug fix: null pointer exception in the VMs section of
   dashboard
-  UI bug fix: 'Undefined' incorrectly prepended to 'Provisioning'
   message

Migration
~~~~~~~~~

No migration is required from v2.6 to v2.6.1.

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.6-community...v2.6.1-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.6-community...v2.6.1-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.6-community...v2.6.1-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.6-community...v2.6.1-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.6-community...v2.6.1-community>`__

v2.6 (candidate) - 2 April 2015
-------------------------------

New features and bug fixes from v2.5
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

Migration
~~~~~~~~~

You have to execute the following script (while HSQLDB is running) to do
the BD migration:

::

    java -jar /opt/hsqldb/lib/sqltool.jar --autoCommit --inlineRc=url=jdbc:hsqldb:hsql://localhost:9001/slipstream,user=sa,password= --sql "UPDATE VmRuntimeParameterMapping SET hostnameRuntimeParameterUri = CONCAT(REGEXP_SUBSTRING(vmstateRuntimeParameterUri,'^[^:]+'),':hostname') WHERE hostnameRuntimeParameterUri IS NULL;"

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.5-community...v2.6-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.5-community...v2.6-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.5-community...v2.6-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.5-community...v2.6-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.5-community...v2.6-community>`__

v2.5 (candidate) - 20 March 2015
--------------------------------

New features and bug fixes from v2.4.2 (stable)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v2.4.2...v2.5-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v2.4.2...v2.5-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v2.4.2...v2.5-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v2.4.2...v2.5-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v2.4.2...v2.5-community>`__

v2.4.2 (stable) - 28 February 2015
----------------------------------

**This release has been promoted to a stable release.**

For this and previous stable releases see the "Stable Releases" page.
