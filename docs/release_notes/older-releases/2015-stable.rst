
2015 Stable Releases
====================

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

.. _personae: http://sixsq.com/personae/
