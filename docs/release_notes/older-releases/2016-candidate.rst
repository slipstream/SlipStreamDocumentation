2016 Candidate Releases
=======================


v3.18 (candidate) - 17 december 2016
------------------------------------

New features and bug fixes in v3.18
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

v3.18 is a maintenance release.

Migration
~~~~~~~~~

No migration is required.

Known issues
~~~~~~~~~~~~

Instance type chosen by placement and ranking service (based on the component
global CPU/RAM/Disk definition) and displayed in the component Deploy dialog is
ignored, and the instance type defined for the cloud on the component is used
instead.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.17-community...v3.18-community>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.17-community...v3.18-community>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.17-community...v3.18-community>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.17-community...v3.18-community>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.17-community...v3.18-community>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.17-community...v3.18-community>`__

v3.17 (candidate) - 09 december 2016
------------------------------------

New features and bug fixes in v3.17
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Version v3.17 brings new connector for Open Telecom Cloud
https://cloud.telekom.de/ named OTC, a number of improvements to editing of
Application module and JSON rendering of all module types and run.

For application developers [Clara]:
 - Improved modification of application component.
 - Now it's possible to edit the description and category of input/output
   parameters on components.
 - Added JSON rendering for module type resources (project, component,
   application) and run.
 - CIMI filter can now handle "!=" operator.
 - Various minor improvements in the code organization for OpenStack connector
   and SlipStream Client.
For organization manager and SlipStream administrator [Bob and Dave]:
 - New connector named OTC for Open Telecom Cloud.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is required.

Known issues
~~~~~~~~~~~~

Instance type chosen by placement and ranking service (based on the component
global CPU/RAM/Disk definition) and displayed in the component Deploy dialog is
ignored, and the instance type defined for the cloud on the component is used
instead.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.16-community...v3.17-community>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.16-community...v3.17-community>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.16-community...v3.17-community>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.16-community...v3.17-community>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.16-community...v3.17-community>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.16-community...v3.17-community>`__

v3.16 (candidate) - 21 november 2016
------------------------------------

New features and bug fixes in v3.16
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The main features of the release v3.16 are addition of the support of CPU/RAM/Disk
server side as module parameters and introduction of new Python CLI and API to
SlipStream service like `nuv.la <https://nuv.la>`_.  Service Catalog was made
available in the community version.

For application users and application developers [Alice, Clara]:
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

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

Upgrading to v3.16 requires each connector to be described by a corresponding service offer.
To insert the service offer for a new connector, use the REST API to post on this resource.
For example, for a connector named `connector-name1`, if ssh access to API server is available:
- `curl -X POST -H "slipstream-authn-info: username role" -H "content-type: application/json" http://localhost:8201/api/service-offer -d@service-offer.json`

The service-offer.json should have the following structure::

    #
    {
      "connector" : {
        "href" : "connector-name1"
      },
      "schema-org:flexible" : "true",
      "acl" : {
        "owner" : {
          "type" : "ROLE",
          "principal" : "ADMIN"
        },
        "rules" : [ {
          "principal" : "USER",
          "right" : "VIEW",
          "type" : "ROLE"
        }, {
          "principal" : "ADMIN",
          "right" : "ALL",
          "type" : "ROLE"
        } ]
      },
      "resourceURI" : "http://sixsq.com/slipstream/1/ServiceOffer"
    }
    #

Without SSH access to the API, the same command can be re-written with

- `curl -X POST -H "content-type: application/json" http[s]://slipstream-endpoint/api/service-offer -d@service-offer.json` -b token.txt

(see SlipStream API documentation on how to obtain an authentication token).

It is possible to check that a given connector named `connector-name-x` is described by a service offer by querying the Service offer resource with the following command:
`curl -H "slipstream-authn-info: super ADMIN" "http://localhost:8201/api/service-offer?\$filter=connector/href='connector-name-x'"`


Known issues
~~~~~~~~~~~~

Instance type chosen by placement and ranking service (based on the component
global CPU/RAM/Disk definition) and displayed in the component Deploy dialog is
ignored, and the instance type defined for the cloud on the component is used
instead.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.15-community...v3.16-community>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.15-community...v3.16-community>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.15-community...v3.16-community>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.15-community...v3.16-community>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.15-community...v3.16-community>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.15-community...v3.16-community>`__

v3.15 (candidate) - 24 october 2016
-----------------------------------

New features and bug fixes in v3.15
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Version v3.15 changes the approach to the service configuration bringing
SlipStream closer to an ability to run the service in a distributed mode by
decoupling the service state (including service's bootstrap configuration) from
the processes running the business logic.

For application users and application developers [Alice, Clara]:
 - Fixes and improvements in displaying placement and pricing information in
   application Deploy dialog.
 - Improved retrieval of VM instance ID and IP to provide VM to run mapping in
   failed runs.
 - Fixed issue with linking to output parameter of parent image.
 - Consistently display prices in Service Catalog in EUR.

For application developers [Clara]:
 - Enabled editing of Pre/Post-Scale scripts in `Application Workflows` tab of
   components. For details, please see `Scalability Workflow Hooks
   <http://ssdocs.sixsq.com/en/v3.8/advanced_tutorial/scalable-applications.html#scalability-workflow-hooks-scripts>`_
   section of the SlipStream tutorial on running scalable applications.

For administrators [Dave]:
 - New way of managing the service configuration via configuration files and
   `ss-config` utility.  See `documentation
   <http://ssdocs.sixsq.com/en/draft/developer_guide/configuration_files.html>`_.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

Migration is needed from v3.14 to v3.15. As the result of the migration the
service and cloud connectors configuration information will be moved from
HSQLDB to Elasticsearch.

1. Declare downtime.

2. Let SlipStream service running.

3. Download the service configuration as XML::

    $ curl -k -s -D - https://<slipstream>/auth/login -X POST -d \
        "username=super&password=<PASS>" -c cookie-user.txt
    $ curl -k -b cookie-user.txt 'https://<slipstream>/configuration?media=xml' \
        -H "Accept: application/xml" -o configuration.xml

4. Update ssclj and connector packages::

    $ yum update slipstream-ssclj-enterprise
    $ yum update slipstream-connector-*

5. Perform the migration of service configuration::

    $ export ES_HOST=localhost
    $ export ES_PORT=9300
    $ ss-config-migrate -x configuration.xml -m 3.14=3.15
    $ # Use -m old=new to update values of the parameters if needed.
    $ # Example: -m localhost=127.0.0.1 -m smtp.gmail.com=smtp.example.com

Now you are ready to upgrade other SlipStream packages::

    $ yum update --disablerepo=* --enablerepo=SlipStream-<release>-<kind>

Substitute ``<release>`` and ``<kind>`` according to your installation.


Check ``/opt/slipstream/server/etc/default.slipstream.rpmsave`` file for your
custom configurations and merge them with the new ones coming with
``/opt/slipstream/server/etc/default.slipstream``.

Restart services::

    $ systemctl restart hsqldb elasticsearch ssclj slipstream

Known issues
~~~~~~~~~~~~

On enterprise edition, due to a bug in the UI part of the deployment
placement and ranking, the Deploy dialog (for application or component)
may display a certain choice of the cloud/price offer, but after clicking
the Deploy button, the application/component may be deployed to a
different cloud.  This was fixed in 3.16.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.14-community...v3.15-community>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.14-community...v3.15-community>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.14-community...v3.15-community>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.14-community...v3.15-community>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.14-community...v3.15-community>`__
 -  `SlipStreamClientAPI <https://github.com/slipstream/SlipStreamClientAPI/compare/v3.14-community...v3.15-community>`__

v3.14 (candidate) - 7 october 2016
----------------------------------

New features and bug fixes in v3.14
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Version v3.14 adds the delete all versions for a module, and fixes some issues related to connectors.

For application users [Alice]:
 - Add the delete all versions for a module

For application developers [Clara]:
 - Fix ssh private key management to build image on StratusLab connector
 - Selection of specific network for opennebula connector

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is needed from v3.13 to v3.14.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.13-community...v3.14-community>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.13-community...v3.14-community>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.13-community...v3.14-community>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.13-community...v3.14-community>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.13-community...v3.14-community>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.13-community...v3.14-community>`__

v3.13 (candidate) - 28 September 2016
-------------------------------------

New features and bug fixes in v3.13
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Version v3.13 fixes a bug in build image creation, and brings minor improvement in REST API.

For application users and developers [Alice, Clara]:

For application users [Alice]:
 - Fix a bug for Safari users that prevented display of some pages with pagination
 - Fix a bug in StratusLab connector that prevented the build of an image

For application developers [Clara]:
 - Add USER and ANON roles for logged in users (used to query REST api)
 - Refactor the parsing of running instances

For administrators [Dave]:

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.


Migration
~~~~~~~~~

No migration is needed from v3.12 to v3.13.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.12-community...v3.13-community>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.12-community...v3.13-community>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.12-community...v3.13-community>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.12-community...v3.13-community>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.12-community...v3.13-community>`__
 -  `SlipStreamClientAPI <https://github.com/slipstream/SlipStreamClientAPI/compare/v3.12-community...v3.13-community>`__


v3.12 (candidate) - 13 September 2016
-------------------------------------

New features and bug fixes in v3.12
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Version v3.12 improves build system and fixes some stability issues.

For application users and developers [Alice, Clara]:
 - Improves readability of failing unit tests
 - Increase the allowed maximum size of a report
 - Fix incorrect identifier for configuration resources
 - Fix: Use namespaced attributes for Riemann monitoring of connectors
 - Pass SNI information to backend services


For administrators [Dave]:
 - Unify build system with boot for clojure code
 - Fix usage consolidations (adaptation of build configuration following boot adoption)
 - Fix collector async job when only users with no connectors configures online

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is needed from v3.11 to v3.12.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.11-community...v3.12-community>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.11-community...v3.12-community>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.11-community...v3.12-community>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.11-community...v3.12-community>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.11-community...v3.12-community>`__
 -  `SlipStreamClientAPI <https://github.com/slipstream/SlipStreamClientAPI/compare/v3.11-community...v3.12-community>`__

v3.11 (candidate) - 26 August 2016
----------------------------------

New features and bug fixes in v3.11
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Version v3.11 is a preparatory release that provides much of the
groundwork for future improvements.  The emphasis has been on
preparing new server-side resources for cloud connectors and service
configuration; these will improve the management of these resources in
the future.  There has also been significant work done to streamline
the code organization, packaging, and release process.  This should
speed development of new features.

For application users and developers [Alice, Clara]:
 - Fix issue with pricing server that prevented prices from being
   calculated.
 - Alpha versions of connector and configuration resources.  These are
   available through the API and will be integrated into the web
   interface in a future release.

For administrators [Dave]:
 - Upgrade to the latest production libraries for all server
   dependencies, improving the robustness of the server (in particular
   Aleph, Buddy, and ClojureScript).
 - Correct the systemd configuration for the ssclj service so that
   successful shutdowns are not marked as failures.
 - Clean up and reorganize the packaging for the pricing service.
   Logging information will now appear in the standard OS directory.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is needed from v3.10 to v3.11.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.10-community...v3.11-community>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.10-community...v3.11-community>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.10-community...v3.11-community>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.10-community...v3.11-community>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.10-community...v3.11-community>`__
 -  `SlipStreamClientAPI <https://github.com/slipstream/SlipStreamClientAPI/compare/v3.10-community...v3.11-community>`__

v3.10 (candidate) - 13 August 2016
----------------------------------

New features and bug fixes in v3.10
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Version v3.10 provides a complete set of resources for the Service
Catalog (Enterprise Edition), allowing policy (and priced) based
placement of virtual machines.  This release also provides a complete
Clojure and ClojureScript API for the SlipStream CIMI resources.

For application users and developers [Alice, Clara]:
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

For administrators [Dave]:
 - Modify service dependencies to ensure cleaner start up of all
   SlipStream services on boot.
 - Improve the collection of virtual machine state information (used
   in the dashboard) to make it more efficient and reliable.  Put in
   additional logging to make debugging easier.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

 No migration is needed from v3.9 to v3.10.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.9-community...v3.10-community>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.9-community...v3.10-community>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.9-community...v3.10-community>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.9-community...v3.10-community>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.9-community...v3.10-community>`__
 -  `SlipStreamClientAPI <https://github.com/slipstream/SlipStreamClientAPI/compare/v3.9-community...v3.10-community>`__

v3.9 (candidate) - 3 August 2016
--------------------------------

New features and bug fixes in v3.9
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Version v3.9 is an incremental release that further improves the
functionality of the placement and ranking service.  This is an
alpha-level Enterprise feature.  This release also contains
improvements and fixes for both the Community and Enterprise Editions.

For application users and developers [Alice, Clara]:
 - Provide pricing along with a filtered set of connectors on the run
   dialog. (Enterprise Edition, alpha)
 - Resolve an issue with the CIMI filter grammar that caused the
   parsing to take several seconds.  After the fix, the parsing takes
   a few milliseconds.
 - Improve the bootstrapping process to avoid having the process hang
   on CentOS 6 systems.
 - Fix a regression that prevented run tags from being saved.
 - Fix an issue where ghost nodes would appear in the run if their
   names matched the regex for a node instance.
 - Fix an issue with redirects on authentication that prevented
   logging in.

For application users [Alice]:
 - Provide a better message when a cloud quota has been exceeded.  The
   message now includes the quota, number of running VMs, and number
   of requested VMs.

For application developers [Clara]:
 - Allow application developers to specify a placement policy for
   application components, for example, limiting the places where a
   component can run. (Enterprise Edition, alpha)
 - Improve the error messages reported to users of the SlipStream
   client API, providing more information about the underlying cause
   of a problem.

For administrators [Dave]:
 - Streamline the installation of SlipStream with a packaged version
   of PhantomJS and with a package for the Elasticsearch
   repositories.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Known Issues
~~~~~~~~~~~~

- The process that collects information abouts users' virtual machines
  can become saturated, resulting in the loss of this information for
  most users.  When this issue appears, the slipstream service can be
  restarted to return it to a normal state.

Migration
~~~~~~~~~

 No migration is needed from v3.8 to v3.9.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.8-community...v3.9-community>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.8-community...v3.9-community>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.8-community...v3.9-community>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.8-community...v3.9-community>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.8-community...v3.9-community>`__
 -  `SlipStreamClientAPI <https://github.com/slipstream/SlipStreamClientAPI/compare/v3.8-community...v3.9-community>`__

v3.8 (stable) - 15 July 2016
----------------------------

New features and bug fixes in v3.8
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Version v3.8 is a consolidation release that fixes some issues
regarding packaging and installation. It also brings some enhancements
to bootstrap mechanism.

For application users and developers [Alice, Clara]:
 - Inherited output parameters are visible to the users, allowing
   an input parameter to be mapped to an inherited output parameter.
 - The SlipStream bootstrap process is now able to run on operating
   system  with only Python 3 installed. The robustness of the
   bootstrapping process has also been improved.
 - Display prices for running components and applications and certain
   clouds in the run dialog.
 - Exoscale: Add support for Mega and Titan instances.
 - OpenStack: Added support for Floating IPs.
 - OpenNebula: Added default values for image parameters

For application developers [Clara]:
 - Allow the client API to be used for test instances of SlipStream
   that use a self-signed certificate.

For administrators [Dave]:
 - Fix an issue with the SlipStream installation process where
   connector installations would fail because of package name matching
   in the yum repository.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Known Issues
~~~~~~~~~~~~

- The process that collects information abouts users' virtual machines
  can become saturated, resulting in the loss of this information for
  most users.  When this issue appears, the slipstream service can be
  restarted to return it to a normal state.

Migration
~~~~~~~~~

 No migration is needed from v3.7 to v3.8.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.7-community...v3.8-community>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.7-community...v3.8-community>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.7-community...v3.8-community>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.7-community...v3.8-community>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.7-community...v3.8-community>`__
 -  `SlipStreamClientAPI <https://github.com/slipstream/SlipStreamClientAPI/compare/v3.7-community...v3.8-community>`__

v3.7 (candidate) - 1 July 2016
------------------------------

New features and bug fixes in v3.7
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Version v3.7 is a consolidation release that fixes some issues
regarding packaging. It also brings enhancement to bootstrap
mechanism.

For application users and developers [Alice, Clara]:
 - FIX: Correct a problem where components could not be selected
   during application creation
 - Make the bootstrap mechanism more reliable over low-quality networks
   (e.g. satellite connections)

For administrators [Dave]:
 - Avoid dependency version conflicts by removing hard-coded
   dependencies for the PRS-lib component.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

 No migration is needed from v3.6 to v3.7.

Commits
~~~~~~~

 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.6-community...v3.7-community>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.6-community...v3.7-community>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.6-community...v3.7-community>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.6-community...v3.7-community>`__
 -  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v3.5-community...v3.7-community>`__

v3.6 (candidate) - 21 June 2016
-------------------------------

New features and bug fixes in v3.6
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The primary goal of v3.6 is to fix known issues of v3.5. It also puts in place
the infrasture required for Placement and Ranking service.

For everyone [Alice, Bob, Clara, Dave]:

For application users and developers [Alice, Clara]:
 - FIX: Fix the mapping resolution between a VM and a Run
 - FIX: Cloud usages are now visible in the web server.
 - FIX: Consolidation and daily sending of usage emails.
 - FIX: Service catalog uses the service-offer resource.
 - Allow to define relative and absolute path for module logo

For application developers [Clara]:
 - FIX: CloudEntryPoint resource is now accessible.
 - FIX: Correct CIMI edit responses

For administrators [Dave]:
 - Rationalize logging and logging levels
 - Remove http-kit support
 - Cleanup unused libraries

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

 No migration is needed from v3.5 to v3.6.

Commits
~~~~~~~

 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.5-community...v3.6-community>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.5-community...v3.6-community>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.5-community...v3.6-community>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.5-community...v3.6-community>`__
 -  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v3.5-community...v3.6-community>`__

v3.5 (candidate) - 3 June 2016
------------------------------

New features and bug fixes in v3.5
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The primary feature for v3.5 is the introduction of Elasticsearch for
data persistency.  This should make the service more stable and
drastically improve response times for retrieving event and usage
information.

For everyone [Alice, Bob, Clara, Dave]:
 - Provide a top-level support link for users, if the system
   administrator has set a support email address.
 - In the Enterprise Edition, improve the visualization of the Service
   Catalog entries and allow more than one entry per cloud connector.
 - FIX: Community Edition dashboard no longer displays errors related
   to service catalog entries.
 - FIX: Ensure build execution scripts (pre-install, packages, and
   post-install) only run during the build phase.
 - FIX: Ensure OpenStack connector works correctly on cloud
   infrastructures that done use the "default" domain.

For application users and developers [Alice, Clara]:
 - Improve the retry mechanism for the SlipStream clients to make them
   behave more uniformly and to be more robust.

For application developers [Clara]:
 - Update API documentation for cookie authentication.  Cookie
   authentication is now the preferred method; basic authentication is
   deprecated.
 - Add a command to allow the reports from a run to be retrieved.

For administrators [Dave]:
 - Make the installation script more robust concerning RPM package
   names.
 - Improve the configuration of the nginx configuration to enhance the
   security of the service.
 - FIX: Ensure that all services are enabled in systemd so that they
   restart on reboot.
 - FIX: Missing file in Riemann service that caused startup to fail.
 - FIX: Mark ``/etc/hsqldb.cfg`` as a configuration file to avoid
   losing local changes.
 - FIX: Reducing reliance on hsqldb should reduce instabilities when
   running the ``ssclj`` service.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Known Issues
~~~~~~~~~~~~

 - Configuration files are required to build software. (`GitHub Issue
   277 <https://github.com/slipstream/SlipStreamClient/issues/277>`_)
 - Logs for the ssclj service are in the wrong location. (`GitHub
   Issue 737
   <https://github.com/slipstream/SlipStreamServer/issues/737>`_)
 - CloudEntryPoint resource is not accessible. (`GitHub Issue 738
   <https://github.com/slipstream/SlipStreamServer/issues/738>`_)
 - The ``/usage`` resource hangs. (`GitHub Issue 618
   <https://github.com/slipstream/SlipStreamUI/issues/618>`_)
 - The admin users ``/usage`` does not render on Safari (`GitHub Issue
   619 <https://github.com/slipstream/SlipStreamUI/issues/619>`_)


Migration
~~~~~~~~~

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

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.4-community...v3.5-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.4-community...v3.5-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.4-community...v3.5-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.4-community...v3.5-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v3.4-community...v3.5-community>`__

v3.4 (candidate) - 23 May 2016
------------------------------

New features and bug fixes in v3.4
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**NOTE**: This release provides a fix for v3.3 and introduces the
previously rolled back features and bug fixes of v3.3.  For the
details of v3.3 release please see the corresponding announcement
section below.

For everyone [Alice, Bob, Clara, Dave]:
 - The main feature of 3.4 release is introduction of on/off-line
   status reporting for `NuvlaBox
   <http://sixsq.com/products/nuvlabox/>`_.

For application users and developers [Alice, Clara]:
 - Fixed disk size unit in describe instance action in OpenNebula
   connector.

For application developers [Clara]:
 - Please follow the migration procedure on SlipStream Enterprise for
   NuvlaBox connectors.
 - DELETE on API resources now returns 200 instead of 204.
 - API documentation was updated to match the latest API
   implementation.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Known Issues
~~~~~~~~~~~~

 - Riemann service jar is missing ``service_offer.clj`` which causes
   startup to fail. (`GitHub Issue 5
   <https://github.com/SixSq/SlipStreamServerDeps/issues/5>`_)
 - Local changes to the file ``/etc/hsqldb.cfg`` will be lost because
   it isn't marked as a configuration file in the RPM
   package. (`GitHub Issue 37
   <https://github.com/slipstream/SlipStreamServerDeps/issues/37>`_)
 - Build execution scripts (pre-install, packages, and post-install)
   are re-executed even when an image has been built, causing
   deployment failures. (`GitHub Issue 274
   <https://github.com/slipstream/SlipStreamClient/issues/274>`_)
 - Instabilities when running the ``ssclj`` service with the hsqldb
   database.  This may cause the SlipStream service to stop responding
   and restart of the hsqldb database may not be possible. (`GitHub
   Issue 725
   <https://github.com/slipstream/SlipStreamServer/issues/725>`_)
 - OpenStack connector does not properly deploy applications on
   OpenStack cloud infrastuctures that do not use the "default"
   domain. (`GitHub Issue 107
   <https://github.com/slipstream/SlipStreamConnectors/issues/107>`_)
 - Community Edition dashboard displays errors when trying to access
   the (Enterprise-only) service catalog. (`GitHub Issue 615
   <https://github.com/slipstream/SlipStreamUI/issues/615>`_)
 - Configuration files are required to build software. (`GitHub Issue
   277 <https://github.com/slipstream/SlipStreamClient/issues/277>`_)

Migration
~~~~~~~~~

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

Commits
~~~~~~~

-  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.3-community...v3.4-community>`__
-  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.3-community...v3.4-community>`__
-  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.3-community...v3.4-community>`__
-  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.3-community...v3.4-community>`__
-  `Documentation <https://github.com/slipstream/SlipStreamDocumentation/compare/v3.3-community...v3.4-community>`__

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
