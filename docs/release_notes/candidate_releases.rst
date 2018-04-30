Candidate Releases
==================

Results from each development cycle are packaged into candidate
releases. We welcome feedback on these releases; however, these are
**not** supported and **not** recommended for production deployments.

v3.50 (candidate) - 30 April 2018
---------------------------------

This is primarily a bug fix release that makes improvements for
SlipStream administrators.

For Everyone:

 - Fix Usage page regarding how numbers are calculated
 - Allow displaying more than 10 cloud names in WebUI
 - Improved searching against list of connectors
 - BugFix on states when uploading from ObjectStore
 - BugFix on Reports ACL
 - Extended external objects templating
 - Improved documentation regarding data management

For Dave:

 - Ensured presence of Python 2 in built images.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is necessary.

Known issues
~~~~~~~~~~~~

No known issues.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.49...v3.50>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.49...v3.50>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.49...v3.50>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.49...v3.50>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.49...v3.50>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.49...v3.50>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.49...v3.50>`__
 -  `SlipStreamJobEngine <https://github.com/slipstream/SlipStreamJobEngine/compare/v3.49...v3.50>`__


v3.49 (candidate) - 13 April 2018
---------------------------------

External Object now has two types: generic and report.  The latter one is used
for storing the deployment reports. The ``generic`` one can be used by anyone
willing to store data on clouds' Object Store.  For details `see
<http://ssdocs.sixsq.com/en/latest/tutorials/ss/data-management-model.html>`_.

For Everyone:
 - Fix access to a metering resource details by its identifier
 - CIMI connector collection is now searchable by users
 - Fix User interface issues related to long usernames in logout button, breadcrumbs,
   and session information panel.
 - CIMI filter interface : fix cursor position into input when using controlled value
 - Usage page : default period,  sorting of results
 - Login button : separated from dropdowns for federated logins

For Dave:
 - Fix number of taken entries in zookeeper which should always be equal to
   number of threads used by job executors
 - Fix deletion of api key/secret
 - Fix User registration callback when validating an email
 - Service configuration is dynamically refreshed on Configuration singleton from backend
 - Specify the version of nginx to be installed (in order to prevent a conflict
   with configuration files)

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

This release moves the configuration of the S3 backend for reports from
``/opt/slipstream/server/.credentials/object-store-conf.edn`` file to the
``configuration/slipstream`` resource.

The following migration steps are required.  

1. After the upgrade of the packages make sure that elasticsearch service is
   running: ``systemctl start elasticserach``

2. Create the following JSON file::

    # cat configuration-slipstream.edn
    {
      :id "configuration/slipstream"
      :slipstreamVersion "3.49"
      :reportsObjectStoreBucketName "<bucket-name>"
      :reportsObjectStoreCreds      "credential/<CHANGE-ME-UUID>"
      }

    
  The value for ``<bucket-name>`` should either be taken from your previous
  configuration file
  ``/opt/slipstream/server/.credentials/object-store-conf.edn`` (where it is
  defined as ``:reportsBucketName``) or you can define a new name.  Note, that
  according to the S3 standard, the bucket name should be unique on the S3
  endpoint.
  
  The value for ``:reportsObjectStoreCreds`` should be the URI of the
  credential that you intend to be used for storing the reports of the
  SlipStream users.  Because each credential refers to a connector, you have to
  make sure that the connector (and, hence, IaaS cloud) behind the credential
  implements and actually exposes S3 endpoint.  All the connectors were updated
  to provide an extra configuration option ``:objectStoreEndpoint``.  It has to
  be set to a valid S3 endpoint before the persistence of the user deployment
  reports can be done.

3. After the configuration file is ready, run the following command to actually
   configure the service::

   # ss-config configuration-slipstream.edn
   #
  
4. Delete the previous configuration file::

   # rm -f /opt/slipstream/server/.credentials/object-store-conf.edn
   #

The configuration can always be updated via web UI by going to
``https://<ss-host>/webui/cimi/configuration/slipstream`` resource and editing
the configuration document there.


Known issues
~~~~~~~~~~~~

Due to this `bug <https://github.com/slipstream/SlipStreamServer/issues/1480>`_,
the credential chosen for persisting the user reports should be shared with
all the users of the SlipStream instance. This should be avoided though. 
Thus, either do not upgrade to v3.49 or apply the patch as describe below.

How to patch SS instance: Check this patch release 
https://github.com/slipstream/SlipStreamServer/releases/tag/v3.49.1.
It provides a patched jar with the issue #1480 fixed.  Please see the details 
on how to patch your instance there.

Next release `v3.50` will contain the fix.


Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.48...v3.49>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.48...v3.49>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.48...v3.49>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.48...v3.49>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.48...v3.49>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.48...v3.49>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.48...v3.49>`__
 -  `SlipStreamJobEngine <https://github.com/slipstream/SlipStreamJobEngine/compare/v3.48...v3.49>`__



v3.48 (candidate) - 23 March 2018
---------------------------------

This is primarily a bug fix release that makes improvements for
SlipStream administrators.

For Everyone:
 - A `usage page <https://nuv.la/webui/usage>`_ is gradually replacing
   the automatic usage report email. The page is internationalized.

For Clara:
 - The CIMI externalObject resource has been extended to include an
   optional ``filename`` attribute, making downloads of the
   referenced objects easier.

For Dave:
 - Add compatibility with Python 2.6 to the SlipStream bootstapping
   code so that images like Centos6 can be deployed.
 - Fixed bug where the OpenStack connector always tried to get a
   floating IP even when the feature was disabled.
 - When logged in as an administrator, the pages now load much more
   quickly.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

Since reports are stored on S3, credentials should temporarily be set
manually in
``/opt/slipstream/server/.credentials/object-store-conf.edn`` file,
following the below format::

   {:key                 "<KEY>"
    :secret              "<SECRET>"
    :objectStoreEndpoint "<ENDPOINT>"
    :reportsBucketName   "<REPORTS_BUCKET_NAME>"}

Note that the location and format of the file have changed since the
previous release.


Known issues
~~~~~~~~~~~~

- When opening the usage page, the default time period will not be set
  until the ``filter`` is opened and the calendar objects are
  initialized.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.47...v3.48>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.47...v3.48>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.47...v3.48>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.47...v3.48>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.47...v3.48>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.47...v3.48>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.47...v3.48>`__
 -  `SlipStreamJobEngine <https://github.com/slipstream/SlipStreamJobEngine/compare/v3.47...v3.48>`__


v3.47 (candidate) - 9 March 2018
--------------------------------

This is primarily a bug fix release that makes improvements for
SlipStream administrators.

For Everyone:
 - The size of the application deployments are limited as described in
   the `scaling guidelines
   <http://hn-docs.readthedocs.io/en/latest/researcher/scaling-guidelines.html>`_.
 - Fixed a problem where new users had to edit their profiles before
   the account could be used.

For Clara:
 - The CIMI externalObject resource has been extended to include an
   optional ``content-type`` attribute, making downloads of the
   referenced objects easier.
 - The editing process for resources through the new browser interface
   has been improved.

For Dave:
 - The documentation has a new section about using a Docker container
   for SlipStream builds.
 - Fixed an issue with the Job executor where it would send large
   numbers of useless requests to the CIMI server.
 - The `Nashorn library <http://openjdk.java.net/projects/nashorn/>`_
   replaces the (now deprecated) PhantomJS for clojurescript unit
   tests.
 - User roles are added to the request for API key/secret generation
   when provisioning VMs.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is necessary.

Known issues
~~~~~~~~~~~~

No known issues.


Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.46...v3.47>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.46...v3.47>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.46...v3.47>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.46...v3.47>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.46...v3.47>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.46...v3.47>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.46...v3.47>`__
 -  `SlipStreamJobEngine <https://github.com/slipstream/SlipStreamJobEngine/compare/v3.46...v3.47>`__

v3.46 (candidate) - 23 February 2018
------------------------------------

This release contains a few foundational features have been added
(external objects, Docker connector, credential sharing) that will
improve cloud resource management in the future.  It also includes
changes to the way machines within a deployment access the server and
how deployment reports are stored.  Both require administrator
attention during upgrades. (See migration section.)  The release also
contains a number of bug fixes.

For Everyone:
 - User resource implementation was changed to allow credential
   sharing between users and groups with ACLs.
 - The login dialog was changed to avoid it being obscured on mobile
   devices. 
 - The default ACL for Connector resources was changed to allow all
   authentication users to see them.
 - The bootstrap script has been corrected to avoid an issue where
   machine deployments on Ubuntu 16 machines would fail.
 - The prototype for the new web browser UI has been improved to
   provide better editing capabilities with forms and JSON, to plot
   server metrics, and to render ``href`` attributes as links to other
   resources. 
 - Styles of cubic (new web browser UI) have been normalized to
   provide a consistent look and feel.

For Clara:
 - The login methods of the Python API have been improved to cache
   credentials to make managing access easier.
 - Improved the CIMI support in the Python API to allow CIMI actions
   to be called.
 - The Python API is now part of the SlipStream RPM packages.
 - A utility method was added to the Python API to retrieve deployment
   events.
 - A function was added to the Clojure(Script) API to allow the server
   metrics to be retrieved.
 - A prototype "cloud" connector (alpha) for Docker infrastructures is
   now available.
   
For Dave:
 - The "machine" cookies that were used by VMs within a deployment to
   interact with SlipStream have been replaced by an API key/secret
   pair. These can be revoked if necessary.
 - An "external object" CIMI resource has been created to allow links
   to external files and resources, such as report, data files,
   etc. Reports are now handled with these resources.  (See migration
   below.) 
 - The server organization has been more finely segmented to allow for
   wider reuse of the servers and to make containerization easier.
 - Package dependencies have be rationalized and corrected (including
   the ``cheshire.jar`` verson in the pricing service). More work on
   this will occur in the future to reduce the servers' footprints.
 - SlipStream package dependency on ``slipstream-client-clojure`` (no
   longer created) has been removed.


Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

API key/secret pairs are now being used to manage access to the server
from deployed machines.  For non-scalable deployments, this change
will have no effect.  However, scalable deployments will lose access
to the server. They need to be terminated and restarted.

Below is the migration procedure to enable the view of the connector instances
by users of your SlipStream instance. From now on this is required for the
deployments to succeed.

 - login to SlipStream instance as super user
 - go to \https://\<slipstream\>/webui/cimi/connector
 - click on `magnifying glass` pictogram (this will fetch all connector config instances)
 - click on a connector name link
 - click on `update` button
 - in the edit window add the following into the list under `"acl" -> "rules"`::

   { "principal": "USER", "right": "VIEW", "type": "ROLE" }

 - click on `update` button to persist the configuration
 - repeat this for each connector.

The method of storing reports has changed with this release.  They are
now stored in S3 rather than on the server's disk. This requires that
the administrator have access to an S3 instance and migration of the
existing reports to S3.

You must provide an S3 configuration file
``/opt/slipstream/server/.aws/credentials`` with the following
contents::

  aws_secret_access_key=<KEY>
  aws_access_key_id=<SECRET>
  aws_endpoint=<S3ENDPOINT>

Note that the name of the bucket is not configurable.  It is set to
"slipstream-reports" and must be created before being used.


Known issues
~~~~~~~~~~~~

 - The switch to using API key/secret pairs will only have an effect
   on running scalable deployments. These will need to be stopped and
   redeployed.


Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.45...v3.46>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.45...v3.46>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.45...v3.46>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.45...v3.46>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.45...v3.46>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.45...v3.46>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.45...v3.46>`__
 -  `SlipStreamJobEngine <https://github.com/slipstream/SlipStreamJobEngine/compare/v3.45...v3.46>`__


v3.45 (candidate) - 4 February 2018
-----------------------------------

This is primarily a bug fix release, but also includes a prototype for
a new web interface.  Feedback on that prototype is welcome. 

For Everyone:
 - An SSH configuration bug that blocked SSH logins on machines
   without pre-existing ``.ssh`` directories was fixed.
 - A bug with the Exoscale connector that caused deployments to fail
   was corrected.
 - A prototype user interface has been included in the release, which
   is available by default on the ``/webui`` relative URL.

For Dave:
 - The configuration for the Job Engine has been added to the quick
   installation script.
 - CIMI resources for NuvlaBox registrations have been added.
 - Unnecessary dependencies have been removed from services and
   packages have been cleaned up.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is necessary.

Known issues
~~~~~~~~~~~~

 - When upgrading rename the ``/etc/default/ssclj`` file to
   ``/etc/default/cimi`` if you've made changes to the configuration
   file.
 - If you've made changes to the nginx configuration files, you will
   need to remove the reference to ``authn.block`` in
   ``/etc/nginx/conf.d/slipstream.params``.
 - The wrong version of ``cheshire.jar`` was included in the RPM
   package for the ``ss-pricing`` service.  Replace
   ``/opt/slipstream/ss-pricing/lib/cheshire.jar`` with version 5.8.0
   that can be found at ``clojars.org``.
 - The RPM package ``slipstream-client-clojure`` was not generated for
   this release. The v3.44 version works fine. 

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.44...v3.45>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.44...v3.45>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.44...v3.45>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.44...v3.45>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.44...v3.45>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.44...v3.45>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.44...v3.45>`__
 -  `SlipStreamJobEngine <https://github.com/slipstream/SlipStreamJobEngine/compare/v3.44...v3.45>`__


v3.44 (candidate) - 24 January 2018
-----------------------------------

This is primarily a bug fix release that makes improvements for
SlipStream administrators.

For Everyone:
 - Fix bug in the deployment garbage collection that caused the clean
   up to fail.

For Dave:
 - Extend OpenNebula and NuvlaBox connectors to allow the vCPU/CPU
   ratio to be defined.  The default value is 0.5.
 - Correct Logstash and Filebeat configurations when using the
   installation script to avoid having Logstash logs fill with
   errors. 

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is necessary.

Known issues
~~~~~~~~~~~~

No known issues.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.43...v3.44>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.43...v3.44>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.43...v3.44>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.43...v3.44>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.43...v3.44>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.43...v3.44>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.43...v3.44>`__
 -  `SlipStreamJobEngine <https://github.com/slipstream/SlipStreamJobEngine/compare/v3.43...v3.44>`__


v3.43 (candidate) - 22 January 2018
-----------------------------------

For Everyone:
 - Remove deprecated basic authentication and related parameters from
   the Python API and Command Line Client.
 - Fix concurrency issue with cookie handling in the Python API and
   Command Line Client.

For Dave:
 - Mark ``/etc/default/slipstream`` as a configuration file to avoid
   having the configuration overwritten on upgrades.
 - Improve template handling for the Exoscale connector so that the
   most recent templates are used by default.  Avoids a problem with
   running in the DK region.
 - Rationalize and reduce the default logging of the services to allow
   for better discovery and debugging of problems.
 - Optimize the loading of the user resources from the database and
   provide metrics.
 - Minimize connections requests from connectors on initialization.
 - Refactor the deployment garbage collector to reduce object creation
   and database churn.

Alice, Bob, Clara, and Dave can be found
`here <http://sixsq.com/personae/>`_.

Migration
~~~~~~~~~

No migration is necessary.

Known issues
~~~~~~~~~~~~

 - Missing dependency for the ssclj server blocks start of service.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.42...v3.43>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.42...v3.43>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.42...v3.43>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.42...v3.43>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.42...v3.43>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.42...v3.43>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.42...v3.43>`__
 -  `SlipStreamJobEngine <https://github.com/slipstream/SlipStreamJobEngine/compare/v3.42...v3.43>`__


v3.42 (candidate) - 12 January 2018
-----------------------------------

This release brings the following changes.

The persistence of the user entities was moved from HSQLDB to Elasticsearch and
from now on will be managed through CIMI server.  On already deployed systems
this assumes that a migration is required.  Check *Migration* section below.

The following connectors were removed and are no longer supported

* StratusLab
* Azure
* NativeSoftlayer
* VCloud

Fixes and improvements:

* fixed and improved VMs information collection service.

Migration
~~~~~~~~~

The steps below perform migration of users from HSQLDB to Elasticsearch (via
CIMI server).

Download migration script::
   
   $ wget https://raw.githubusercontent.com/slipstream/SlipStreamServer/master/rpm/src/main/migrations/020_migrate_users_to_cimi.py
   $ chmod +x 020_migrate_users_to_cimi.py
   $ yum install python-lxml
   $ # or
   $ pip install lxml

Dump users with::

   $ export SLIPSTREAM_USERNAME=super
   $ export SLIPSTREAM_PASSWORD=<password>
   $ ss-login --endpoint https://<slipstream>
   $ ./020_migrate_users_to_cimi.py --endpoint https://<slipstream> --get users-3.41/

Perform the upgrade::

   $ yum upgrade -y
   $ systemctl restart hsqldb ss-pricing ssclj slipstream \
        slipstream-job-distributor@vms_collect \
        slipstream-job-distributor@vms_cleanup \
        slipstream-job-distributor@jobs_cleanup \
        slipstream-job-executor \
        elasticsearch logstash filebeat kibana


In *https://<slipstream>/configuration -> SlipStream Basics -> java class
names* remove any instances of the following connectors: nativesoftlayer,
stratuslab, stratuslabiter, azure, vcloud. Save the configuration.

Push users back to SlipStream::

   $ ./020_migrate_users_to_cimi.py --endpoint https://<slipstream> --put users-3.41/

Known issues
~~~~~~~~~~~~

 - No known issues.

Commits
~~~~~~~

 -  `SlipStream <https://github.com/slipstream/SlipStream/compare/v3.41...v3.42>`__
 -  `Server <https://github.com/slipstream/SlipStreamServer/compare/v3.41...v3.42>`__
 -  `UI <https://github.com/slipstream/SlipStreamUI/compare/v3.41...v3.42>`__
 -  `Connectors <https://github.com/slipstream/SlipStreamConnectors/compare/v3.41...v3.42>`__
 -  `Client <https://github.com/slipstream/SlipStreamClient/compare/v3.41...v3.42>`__
 -  `SlipStreamClojureAPI <https://github.com/slipstream/SlipStreamClojureAPI/compare/v3.41...v3.42>`__
 -  `SlipStreamPythonAPI <https://github.com/slipstream/SlipStreamPythonAPI/compare/v3.41...v3.42>`__
 -  `SlipStreamJobEngine <https://github.com/slipstream/SlipStreamJobEngine/compare/v3.41...v3.42>`__


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
