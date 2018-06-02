2017 Candidate Releases
=======================


v3.41 (candidate) - 2 December 2017
-----------------------------------


This release v3.41 provides more reliable information via the
dashboard for everyone and improves the Clojure and Python APIs for
developers.


New features and bug fixes
~~~~~~~~~~~~~~~~~~~~~~~~~~

For Everyone:
 - Dashboard has been updated to take virtual machine information from
   new monitoring subsystem, that is both more scalable and more
   reliable.
 - Fix ACLs on virtual machine records to make them visible to the
   correct users.

For Clara:
 - Updates to the Python API to allow the cloud image identifier to be
   obtained, to get all parameters of a modules, and to update a
   module.
 - Updates to the Clojure API to respect the insecure? flag with the
   pricing, modules, and run resources, allow start/termination of
   runs, and to remove unnecesary XML processing.

For Dave:
 - Provide a better mechanism for configuring the user migration
   script. 
 - Remove code related to old, unused authentication methods.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is required.

Known issues
~~~~~~~~~~~~

 - No known issues.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.40...v3.41>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.40...v3.41>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.40...v3.41>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.40...v3.41>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.40...v3.41>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.40...v3.41>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.40...v3.41>`__
 -  `SlipStreamJobEngine <https://github.com/slipstream/SlipStreamJobEngine/compare/v3.40...v3.41>`__

v3.40 (candidate) - 10 November 2017
------------------------------------


This release v3.40 add new job actions implementation to the new job
resource as well as provides various bug fixes.


New features and bug fixes
~~~~~~~~~~~~~~~~~~~~~~~~~~

For Everyone:
 - Directly from SlipStream, create an Exoscale account or add trial credit to an existing one
   by using a coupon code.

For Clara:
 - Add an ElasticSearch client to SlipStreamJobEngine.

For Dave:
 - Add cleanup job and vms job distribution and implementation.
 - Fix bad directory location of slipstream connectors configuration jar.
 - Fix type of service offer attribute in Virtual machine mapping resource.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is required.

Known issues
~~~~~~~~~~~~

 - No known issues.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.39...v3.40>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.39...v3.40>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.39...v3.40>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.39...v3.40>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.39...v3.40>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.39...v3.40>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.39...v3.40>`__
 -  `SlipStreamJobEngine <https://github.com/slipstream/SlipStreamJobEngine/compare/v3.39...v3.40>`__

v3.39 (candidate) - 4 November 2017
-----------------------------------

The v3.39 release includes a number of underlying improvements to
improve the scalability and resilience of the SlipStream service. One
major improvement is the deployment of a new monitoring infrastruture
that will allow more rapid feedback on resource utilization. This
includes a new Job resource that will allow many tasks from the API to
be performed asynchronously.


New features and bug fixes
~~~~~~~~~~~~~~~~~~~~~~~~~~

For Everyone:
 - New monitoring infrastructure based on asynchronous Job resource to
   provide faster feedback on resource utilization and to improve
   reliability. 
 - Fixed issues with certificate validation and packaging that caused
   some deployments to fail.

For Bob:
 - Added quota enforcement algorithm.
 - Fixed missing usage collection script that causes resource usage
   information to not be collected.
 - Fixed exception when collecting metering information that caused
   some information to be lost.

For Clara:
 - Added support for CIMI aggregations to the Python API and
   refactored for obtaining credential resources.
 - Ensure that operations for credential resources are correct. (The
   edit operation is not allowed.)

For Dave:
 - Updated clojure dependencies to ensure that bug and security fixes
   are included.
 - Remove hardcoded endpoint in Java server configuration to allow for
   more flexible SlipStream deployments.
 - Use common application server to reduce duplicated code between
   servers to reduce service footprint.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

 - A migration of the user credentials is required to run the new
   collector service.  This is currently optional but will be required 
   in upcoming releases.
  
   - Add the followings:
      ``DBMIGRATION_USER=<username>``

      ``DBMIGRATION_PASSWORD=<password>``

      ``DBMIGRATION_ENDPOINT``: e.g ``http://localhost:8201/api/cloud-entry-point``

      ``DBMIGRATION_OPTIONS``: defaults to ``{:insecure? false}`` and can be set to ``{:insecure? false}``

      ``DBMIGRATION_CONFIGFILE`` : (optional) path to specific migration configuration file

The optional migration file is a EDN formatted file looking like::

   {
   :my-category       {:connectors    #{"my-connector1", "myconnector2", ....}
                        :template-keys [:key1 :key2 :key3 ....]}
   ...
   }

where the list of keys in ``:template-keys`` must match the credential-template corresponding to your connectors category

   - Set the `CLASSPATH` to::

        export CLASSPATH=/opt/slipstream/ring-container/lib/*:/opt/slipstream/ssclj/lib/*

   - Launch the migration script::

        java -cp $CLASSPATH com/sixsq/slipstream/ssclj/migrate/user_cred


 - Install a zookeeper server (needed for the new CIMI job resource)

 - A migration of CIMI server default configuration is needed `/etc/default/ssclj`.

   - Add followings:
      ``SLIPSTREAM_RING_CONTAINER_INIT=com.sixsq.slipstream.ssclj.app.server/init``
      ``SLIPSTREAM_RING_CONTAINER_PORT=<SSCLJ_PORT>``
      ``ZK_ENDPOINTS=<ZK_SERVER_IP>:<ZK_SERVER_PORT>``
   - Remove following:
      ``SSCLJ_PORT``

Known issues
~~~~~~~~~~~~

 - Connector jar files are installed in the wrong directory.  Copy
   links from ``/opt/slipstream/ssclj/lib/ext`` to
   ``/opt/slipstream/ssclj/lib`` or add the previous path to the
   service deployment file to work around the issue.

   - `Issue SixSq/SlipStreamConnectors#115 <https://github.com/SixSq/SlipStreamConnectors/issues/115>`_
   - `Issue slipstream/SlipStreamConnectors#179 <https://github.com/slipstream/SlipStreamConnectors/issues/179>`_

 - ``ss-config`` command fail to connect to Elasticsearch.

   - `Issue slipstream/SlipStreamServer#1285 <https://github.com/slipstream/SlipStreamServer/issues/1285>`_

 - Insert a ``virtual-machine-mapping`` with a service offer fail.

   - `Issue slipstream/SlipStreamServer#1287 <https://github.com/slipstream/SlipStreamServer/issues/1287>`_

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.38...v3.39>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.38...v3.39>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.38...v3.39>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.38...v3.39>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.38...v3.39>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.38...v3.39>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.38...v3.39>`__


v3.38 (candidate) - 13 October 2017
-----------------------------------

New features and bug fixes
~~~~~~~~~~~~~~~~~~~~~~~~~~

For Alice:
 - Fix issue with credentials for users that have long usernames from
   External authentication methods (e.g. eduGAIN or Elixir).
 - Treat entitlements coming from the Elixir AAI federation as
   SlipStream roles.
   
For Bob:
 - Attach pricing information to metering resource to allow
   approximate cost estimates to be provided.

For Clara:
 - Provide links in the "reference" section to the specific API
   documentation (Clojure, Python, and Libcloud) in the main
   SlipStream documentation.
 - Improve the documentation for using the API key/secret pairs
   through the API.
 - Allow users to supply their own server token when using the Clojure
   API.
 - Support Debian for package installation.
 - Add an ``ss-terminate`` command and ensure that ``ss-login`` and
   ``ss-logout`` are packaged.

For Clara and Dave:
 - Initial implementation of Job resource to allow for asynchronous
   actions on the server.

For Everyone:
 - Fix an issue with updating the internal ACL representation when
   editing resources, which affected the accuracy of search requests.
 - Fix an issue with some cloud connectors to avoid collisions (and
   failures) when creating SSH key resources.
 - Add support for private network addresses for the Open Telekom
   Cloud. 

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is required.

Known issues
~~~~~~~~~~~~

 - No known issues.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.37...v3.38>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.37...v3.38>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.37...v3.38>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.37...v3.38>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.37...v3.38>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.37...v3.38>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.37...v3.38>`__


v3.37 (candidate) - 1 October 2017
----------------------------------

New features and bug fixes
~~~~~~~~~~~~~~~~~~~~~~~~~~

For Clara:
 - Improve the error messages when trying to upload CIMI resources
   that do not follow the defined resource schema.
 - Provide a ServiceBenchmark resource that allows users to post
   performance and reliability information concerning cloud resources
   and services.
 - Adapt language-specific libraries to use "Session" resources for
   authentication, allowing also the use of API key/secret pairs.
 - Provide a Libcloud driver for SlipStream.  See the documentation
   for details.

For Bob:
 - Implement new resource usage and metering scheme to provide
   flexible mechanism for usage and billing reports.  This involves
   the new VirtualMachine, Quota, and Metering resources.
 - Provide an initial implementation of a cloud credentials resource
   that will eventually permit sharing of credentials between users.

For Everyone:
 - Add a wait for a routable IP address in the node executor to avoid
   unnecessary deployment failures.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is required.

Known issues
~~~~~~~~~~~~

 - No known issues.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.36...v3.37>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.36...v3.37>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.36...v3.37>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.36...v3.37>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.36...v3.37>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.36...v3.37>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.36...v3.37>`__


v3.36 (candidate) - 8 September 2017
------------------------------------

New features and bug fixes
~~~~~~~~~~~~~~~~~~~~~~~~~~

For Clara:
 - Server:
    - First version of the CIMI VirtualMachines resource
For Dave:
 - Client:
    - The node executor now start only after a valid network configuration is available on OS with SystemD. 
 - Server:
    - Install Zookeeper together with SlipStream

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is required.

Known issues
~~~~~~~~~~~~

- The new CIMI VirtualMachines resource will not be populated by the server because of a schema issue.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.35...v3.36>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.35...v3.36>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.35...v3.36>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.35...v3.36>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.35...v3.36>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.35...v3.36>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.35...v3.36>`__


v3.35 (candidate) - 25 August 2017
----------------------------------

New features and bug fixes
~~~~~~~~~~~~~~~~~~~~~~~~~~

For Alice:
 - UI:
    - The usage page is now rendered correctly
    - Weekly and monthly usages have been removed
For Clara:
 - Server:
    - Implementation of the `$aggregation` query parameters on CIMI resources

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is required.

Known issues
~~~~~~~~~~~~

There are no known issues with this release.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.34...v3.35>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.34...v3.35>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.34...v3.35>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.34...v3.35>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.34...v3.35>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.34...v3.35>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.34...v3.35>`__


v3.34 (candidate) - 11 August 2017
----------------------------------

New features and bug fixes in v3.34
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For Alice:
 - UI:
    - Fixed minor typo in help hint
 - Connectors:
    - Fixed the disk resizing for VMs in the OTC provider
For Dave:
 - Client:
    - Use Python's "requests" lib instead of "httplib2"
    - Allow deployments from users having usernames with special
      characters
 - Server:
    - Reduce memory consumption of ElasticSearch if it is 
      installed locally
    - On deploy, do not use service-offer if it is empty
    - Fixed memory leak when using ElasticSearch client
    - Improve error logging
    - Implementation of API key credentials 

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is required.

Known issues
~~~~~~~~~~~~

There are no known issues with this release.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.32...v3.34>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.32...v3.34>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.32...v3.34>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.32...v3.34>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.32...v3.34>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.32...v3.34>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.32...v3.34>`__


v3.32 (candidate) - 14 July 2017
--------------------------------

New features and bug fixes in v3.32
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For Alice:
 - UI:
    - On the "Deploy" dialog, the Cloud you selected will stay
      selected after a service offers refresh even if it's not
      the cheapest one
    - Allow to enter the amount of RAM as a float

For Clara:
 - CIMI resources:
    - ``$orderby`` query parameter now support sorting by fields
      containing ``:`` (colon) character

For Dave:
 - Client:
    - Service Offers scrapers delete only obsolete service offers
      of type ``VM``
 - Server:
    - Allow to internally create account with special characters
      in username (for external auth)
    - PRS now use one query per Node per Cloud. Each query return
      maximum one element. Queries are threaded.
    - PRS only search service offers of type ``VM``

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is required.

Known issues
~~~~~~~~~~~~

There are no known issues with this release.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.31...v3.32>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.31...v3.32>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.31...v3.32>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.31...v3.32>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.31...v3.32>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.31...v3.32>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.31...v3.32>`__


v3.31 (candidate) - 30 June 2017
--------------------------------

New features and bug fixes in v3.31
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For Alice:
 - UI:
    - If PRS is available use by default the fields CPU, RAM, Disk to
      find the most appropriate service offers
    - CPU, RAM, Disk values can be changed from the deployment dialog
 - Server:
    - Various enhancements to the PRS service
    - Improved authentication with federated identity
    - Separated OIDC and Cyclone authentication methods

For Clara:
 - Python API:
    - Improved error handling of CIMI resources in SlipStreamPythonAPI

For Dave:
 - Client:
    - Reduced the size of the SlipStreamClient tarball
 - Connectors:
    - Added service offers scraper to connectors
 - Server:
    - Improved logging for CIMI resources
    - Added ability to start a deployment with service offers

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

Service offers schema has been changed.
To use PRS, please delete all service offers and regenerate them with
``*-service-offers`` commands (eg: ``openstack-service-offers``)

Known issues
~~~~~~~~~~~~

There are no known issues with this release.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.29...v3.31>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.29...v3.31>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.29...v3.31>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.29...v3.31>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.29...v3.31>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.29...v3.31>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.29...v3.31>`__

v3.30 (candidate) - 23 June 2017
--------------------------------

This release is an internal release.
Please look at the release notes of v3.31.

v3.28 (candidate) - 21 May 2017
-------------------------------

New features and bug fixes in v3.28
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For Alice and Clara:
 - Server:
    - Various updates and fixes around authentication: adding sessions, fixing
      eduGAIN workflow and OIDC.
 - Client:
    - Fix: accept parameter values containing `=` sign.
 - Client API:
    - Added functions for CIMI resources.
 - Connectors:
    - EC2: added support for extra disk.
    - OpenStack:
       - fixed leaking of private IPs.
       - improved retrieval of IPs on OpenStack.

For contributors:
 - Improved contributor documentation around setting up Python environment.
 - Improved conditional building of RPMs on systems with no rpmbuild installed.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is required.

Known issues
~~~~~~~~~~~~

- OpenStack connector fail to deploy a component (application deployment work).

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.27...v3.28>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.27...v3.28>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.27...v3.28>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.27...v3.28>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.27...v3.28>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.27...v3.28>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.27...v3.28>`__

v3.27 (candidate) - 8 May 2017
------------------------------

New features and bug fixes in v3.27
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This release v3.27 improves the implementation of the internal SlipStream
inter-service communication implementation, unifies the implementation of the
users' authentication code as well as provides various bug fixes.

For Dave:
 - Introduced installation of Metricbeat with SlipStream.  This provides the OS
   level monitoring and storage of the metrics to Elasticsearch for later
   visualization with Kibana.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is required.

Known issues
~~~~~~~~~~~~

There are no known issues with this release.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.26...v3.27>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.26...v3.27>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.26...v3.27>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.26...v3.27>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.26...v3.27>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.26...v3.27>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.26...v3.27>`__

v3.26 (candidate) - 21 April 2017
---------------------------------

New features and bug fixes in v3.26
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This release v3.26 brings updates to EC2 connector. The release also includes a
couple of other fixes and clean ups of the underlying code.  Read below for
more details.

For Clara and Alice:
 - EC2 connector: added new instance types and regions; added support for extra
   disk; updated to the latest version of *boto*.
 - OCCI connector was removed.
 - Updated help messages and fixed an issue with HTTP redirection in SlipStream
   CLI.
 - Fixed outdated links in the Web UI Tour.

For Dave:
 - Installation of SlipStream server installs full ELK stack for collection of
   the logs from different components of the service.
 - SlipStream server logs were moved to /var/log/slipstream/server.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is required.

Known issues
~~~~~~~~~~~~

When accessing the v3.26 server with an old cookie that is still valid, the
server responds with an internal server error (500).  See `old cookie causes
internal server error <https://github.com/slipstream/SlipStreamServer/issues/1007>`__.
The issue is already fixed in master branch and the updated RPM with the fix is
available from *SlipStream-Snapshots-** repos.  The next release will contain
the fix by default.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.25...v3.26>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.25...v3.26>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.25...v3.26>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.25...v3.26>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.25...v3.26>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.25...v3.26>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.25...v3.26>`__

v3.25 (candidate) - 7 April 2017
--------------------------------

New features and bug fixes in v3.25
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Version v3.25 fixes a problem where the server could effectively hang
when accessing resources in the underlying database.  The release also
include a couple other fixes and clean ups of the underlying code.

For everyone:
 - Diagnose and fix an issue with the underlying database that caused
   the service to hang.
 - Fix broken links in the deployment dialog (to SSH configuration)
   and in the tour (to external documentation).
 - Fix the Kubernetes deployment in the App Store.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is required.

Known issues
~~~~~~~~~~~~

There are no known issues with this release.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.24...v3.25>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.24...v3.25>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.24...v3.25>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.24...v3.25>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.24...v3.25>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.24...v3.25>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.24...v3.25>`__

v3.24 (candidate) - 26 March 2017
---------------------------------

New features and bug fixes in v3.24
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Version v3.24 allows the OpenNebula cloud connector to resize the root
disk of virtual machines and enhances the user management capabilities
of the SlipStream Python API. Several bugs have been fixed and some
foundational changes have been made to improve consistency and
reliability.

For everyone:
 - Improve the SlipStream OpenNebula and NuvlaBox cloud connectors to
   allow them to resize the root disk of a virtual machine.
 - Fix a problem where the pricing service would hang, causing the
   deployment dialog to wait for a timeout.
 - Ensure that the SlipStream client is only installed under Python
   2.7+, not under Python 3.x (which isn't supported).
 - The SlipStream client can now the use the "disk" generic cloud
   parameter.

For SlipStream administrator [Dave]:
 - Improve management of users through SlipStream Python API.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is required.

Known issues
~~~~~~~~~~~~

There are no known issues with this release.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.23...v3.24>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.23...v3.24>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.23...v3.24>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.23...v3.24>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.23...v3.24>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.23...v3.24>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.23...v3.24>`__

v3.23 (candidate) - 14 March 2017
---------------------------------

New features and bug fixes in v3.23
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Version v3.23 makes some foundational changes for future improvements,
improves the OpenNebula connector, makes the bootstrap process more
reliable, and fixes a few bugs.

For everyone:
 - Improve the SlipStream VM bootstrap process to better handle
   environments where Python 3 is the default (e.g. Ubuntu 16.04).
 - Improve the OpenNebula connector to allow both OpenNebula native
   contextualization and cloud-init contextualization.
 - Fix hybrid cloud option in the deployment dialog which would
   prevent the deployment of the application.
 - Made foundational changes on the server and UI that will allow a
   workflow more focused on cloud service provider offers in the
   future.

For SlipStream administrator [Dave]:
 - Improve handling of certificates for generating authentication
   tokens.
 - Fix startup failure of Riemann server.
 - Add missing file in the server backup RPM package.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

1. IMPORTANT. Certificates for generation of authentication tokens are no
   longer password-protected.  The new unencrypted certificates will be
   generated under ``/etc/slipstream/auth`` as part of post-install script of
   ``slipstream-ssclj`` RPM.  Next time when RPM gets updated the files will
   not be overwritten.  You can update them at your will (check
   `/opt/slipstream/ssclj/bin/generate-auth-keys.sh`).  Only one service
   ``ssclj.service`` requires private key for encrypting the authentication
   token.  All other services require only public key for decryption.
   Locations of both can be configured in their respective ``systemd``
   configuration files or in the respective ``/etc/default/<service>`` files.

2. The schema for the server configuration has changed.  You will need to
   remove the "PRS Endpoint" and "PRS Enabled" parameters from the
   configuration before starting the updated service.  First, save the current
   configuration into a file::

      ss-config -r configuration/slipstream > config-ss.edn

   Edit ``config-ss.edn`` and delete ``:prsEndpoint`` and ``:prsEnable``
   key/value pairs from the configuration file.  Then, upload the updated
   configuration back to DB with::

      ss-config config-ss.edn

Known issues
~~~~~~~~~~~~

There are no known issues with this release.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.22-community...v3.23-community>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.22-community...v3.23-community>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.22-community...v3.23-community>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.22-community...v3.23-community>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.22-community...v3.23-community>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.22-community...v3.23-community>`__

v3.22 (candidate) - 24 February 2017
------------------------------------

New features and bug fixes in v3.22
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Version v3.22 provides improvements aimed primarily at SlipStream
administrators.  The major change being an upgrade from Elasticsearch
2.x to 5.x.

For SlipStream administrator [Dave]:
 - Upgrade of Elasticsearch to v5.x to take advantage of
   database improvements.
 - Fix broken packaging for OTC and Azure connectors that
   prevented upgrades.
 - Refactor placement and pricing service (PRS) to simplify
   the service and to improve the logging of errors.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

The version of Elasticsearch being used by SlipStream has changed to Version 5.

Migration of SlipStream database for Elasticsearch 5 is NOT required.

Manual upgrade of Elasticsearch plugins is required.  Here it's shown on an
example of S3 snapshot plugin::

    systemctl stop elasticsearch
    /usr/share/elasticsearch/bin/elasticsearch-plugin remove cloud-aws
    echo y | /usr/share/elasticsearch/bin/elasticsearch-plugin -s install repository-s3
    systemctl start elasticsearch

Known issues
~~~~~~~~~~~~

There are no known issues with this release.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.21-community...v3.22-community>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.21-community...v3.22-community>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.21-community...v3.22-community>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.21-community...v3.22-community>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.21-community...v3.22-community>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.21-community...v3.22-community>`__

v3.21 (candidate) - 10 February 2017
------------------------------------

New features and bug fixes in v3.21
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Version v3.21 is primarily a bug fix release.

For everyone:
 - FIX: Failure when installing packages should abort deployment.
 - FIX: Fix missing dependency for pricing and ranking service that
   caused the service not to start.
 - FIX: Problem with user interface changes that caused deployments to
   fail.

For application developers [Clara]:
 - Move Riemann server package, used for autoscaling applications, to
   the Community Edition.

For SlipStream administrator [Dave]:
 - Simplify the organization of Community and Enterprise releases to
   make building and deploying SlipStream easier.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is required.

Known issues
~~~~~~~~~~~~

The packages for the OTC and Azure connectors to not upgrade cleanly.
You can work around this by deleting the connector packages and then
installing the new packages after the rest of the system has been
updated.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.20-community...v3.21-community>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.20-community...v3.21-community>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.20-community...v3.21-community>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.20-community...v3.21-community>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.20-community...v3.21-community>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.20-community...v3.21-community>`__

v3.20 (candidate) - 28 January 2017
-----------------------------------

New features and bug fixes in v3.20
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Version v3.20 allows better management of SlipStream from other
services as well as bug and security fixes.

For everyone:
 - Add m2.2xlarge instance type for the Amazon cloud service.
 - Add checkbox to highlight option for multi-cloud deployment.

For application developers [Clara]:
 - Allow managers to create and to manage a group of users.
 - FIX: Default is now taken into account when saving nodes in
   deployment

For SlipStream administrator [Dave]:
 - Bug and security fixes.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is required.

Known issues
~~~~~~~~~~~~

No known issues.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.19-community...v3.20-community>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.19-community...v3.20-community>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.19-community...v3.20-community>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.19-community...v3.20-community>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.19-community...v3.20-community>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.19-community...v3.20-community>`__

v3.19 (candidate) - 16 January 2017
-----------------------------------

New features and bug fixes in v3.19
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Version v3.19 is a maintainence release that incorporates dependency
upgrades with bug and security fixes.

Migration
~~~~~~~~~

No migration is required.

Known issues
~~~~~~~~~~~~

No known issues.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.18-community...v3.19-community>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.18-community...v3.19-community>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.18-community...v3.19-community>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.18-community...v3.19-community>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.18-community...v3.19-community>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.18-community...v3.19-community>`__
