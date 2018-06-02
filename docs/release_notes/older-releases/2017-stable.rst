
2017 Stable Releases
====================

v3.27 (stable) - 23 May 2017
----------------------------

Features
~~~~~~~~

Below is the list of the main features and improvements done in
releases 3.15 to 3.27.

- Introduced a different approach to the service configuration.  Now the
  configuration can be managed with the help of the extra tooling directly in
  the Elasticsearch DB.
- Service Catalog displays prices consistently in EUR.
- Added support of CPU/RAM/Disk server side as module parameters.
- Introduced new Python CLI and API to SlipStream service like `nuv.la
  <https://nuv.la>`_.
- Made Service Catalog available in the community version.
- Added new connector for Open Telecom Cloud https://cloud.telekom.de/ named
  OTC.
- Introduced a number of improvements to editing of Application module and JSON
  rendering of all module types and run.
- Improved OpenNebula connector and allow it to resize the root disk of VM.
- Improved EC2 connector.
- Removed OCCI connector.
- Improved the implementation of the internal SlipStream inter-service
  communication implementation, unified the implementation of the users'
  authentication code.

The detailed change log is given below.  For brevity bug fixes have
not been included, see the change logs for the intermediate releases
for the full set of changes and fixes.

For application users and developers [Alice, Clara]:
 - Users can now enter CPU/RAM/Disk sizes for the component instances in the
   generic Cloud Configuration -> Cloud section on the components.  Depending
   on the cloud (working with t-shirt sizes or directly with CPU/RAM/Disk),
   these values will be mapped either directly to the corresponding CPU/RAM/Disk
   or the closest match to the t-shirt size will be made.  The mapping is done
   using service offers defined the Service Catalog.
 - New Python CLI and API were released to be used with SlipStream services
   like `nuv.la <https://nuv.la>`_.  For more details please see `CLI
   <https://github.com/slipstream/SlipStreamCLI>`_ and
   `API <https://github.com/slipstream/SlipStreamPythonAPI>`_.
 - Add m2.2xlarge instance type for the Amazon cloud service.
 - Add checkbox to highlight option for multi-cloud deployment.
 - Improve the SlipStream VM bootstrap process to better handle
   environments where Python 3 is the default (e.g. Ubuntu 16.04).
 - Improve the OpenNebula connector to allow both OpenNebula native
   contextualization and cloud-init contextualization.
 - Made foundational changes on the server and UI that will allow a
   workflow more focused on cloud service provider offers in the
   future.
 - Improve the SlipStream OpenNebula and NuvlaBox cloud connectors to
   allow them to resize the root disk of a virtual machine.
 - EC2 connector: added new instance types and regions; added support for extra
   disk; updated to the latest version of *boto*.
 - OCCI connector was removed.

For application developers [Clara]:
 - Enabled editing of Pre/Post-Scale scripts in `Application Workflows` tab of
   components. For details, please see `Scalability Workflow Hooks
   <http://ssdocs.sixsq.com/en/latest/tutorials/ss/scalable-applications.html#scalability-workflow-hooks-scripts>`_
   section of the SlipStream tutorial on running scalable applications.
 - Improved modification of application component.
 - Allowed the possibility to edit the description and category of input/output
   parameters on components.
 - Added JSON rendering for module type resources (project, component,
   application) and run.
 - Allow managers to create and to manage a group of users.

For administrators [Dave]:
 - New way of managing the service configuration via configuration files and
   `ss-config` utility.  See `documentation
   <http://ssdocs.sixsq.com/en/latest/developer_guide/configuration_files.html>`_.
 - Introduced installation of Metricbeat with SlipStream.  This provides the OS
   level monitoring and storage of the metrics to Elasticsearch for later
   visualization with Kibana.


For organization manager and SlipStream administrator [Bob and Dave]:
 - New connector named OTC for Open Telecom Cloud.

The Alice, Bob, Clara, and Dave personae_ can be found on the SixSq
website.

Migration
~~~~~~~~~

Multiple migrations are required between 3.14 and 3.27:

 1. 3.14 -> 3.15
 2. 3.15 -> 3.16
 3. 3.21 -> 3.22
 4. 3.22 -> 3.23

For details see the release notes for each of the `corresponding
candidate releases <candidate_releases.html>`_.  The migrations should
be applied in the order defined above.  Upgrades of the SlipStream
packages should be carried out carefully step by step from the release
to release that require migration.  To accomplish this, one has to
explicitly define the version numbers of the packages.  For example::

    # List available version numbers
    $ yum --showduplicates list slipstream-server
    # Select the version number you are upgrading to and run
    $ yum upgrade slipstream-*3.15-0.el7
    # Apply migration.
    # Repeat.

Starting from release v3.21, you should explicitly exclude packages with
`enterprise` and `community` in their names. E.g.,::

    $ yum upgrade slipstream-*3.21-0.el7 --exclude=*-enterprise \
      --exclude=*-community

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.14-community...v3.27>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.14-community...v3.27>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.14-community...v3.27>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.14-community...v3.27>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v3.14-community...v3.27>`__


.. _personae: http://sixsq.com/personae/
