Candidate Releases
==================

Results from each development iteration (sprint) are packaged into
candidate releases. We welcome feedback on these releases; however,
these are **not** supported and **not** recommended for production
deployments.

v2.18 (candidate) - 23 october 2015
-----------------------------------

New features and bug fixes in v2.18
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Make the Dashboard the landing page for users
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
