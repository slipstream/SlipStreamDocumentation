
Stable Releases
===============

Releases that pass our quality control and testing are promoted to
stable releases that are listed here. Stable releases are supported by
SixSq and are appropriate for production deployments. In general, we
recommend that people use the latest stable release.

v2.23.2 (stable) - 3 March 2016
-------------------------------

For application developers [Clara]:
 - Fixed issues with command line client so that the `ss-get
   --noblock` option works correctly, `ss-abort` no longer requires a
   message, and the `ss-execute` option `--mutable-run` has been
   changed to `--scalable`. 
 - Refactored client clojure API to make actions/functions correspond
   better to end user needs.
 - Fix a bug in which the same resource could be added twice.

For SlipStream administrators [Dave]:
 - Fix packaging issue which left out scripts for periodic usage
   analysis. 

For application users, developers, and SlipStream administrators
[Alice, Clara, Dave]:
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

A database migration is required from v2.14 to v2.23.2.  Please
execute the following procedures in order to perform the necessary
migration.

**TBD**

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
