.. _dg-cfg-files:

Configuration Files
===================

At this point you have a naked SlipStream instance running on your
system. This is great, but you probably want a few basic configuration
items loaded for your instance to be useable and useful.

The following instructions describe how you can drive the entire
configuration of SlipStream by using ``ss-config`` utility with
configuration files and restarting the service.

.. warning::

    If your SlipStream server is already started, don't forget to
    restart it after the configuration was updated with ``ss-config``.


.. _dg-cfg-ss-config:

SlipStream configuration utility
--------------------------------

Below is the help message printed by the SlipStream configuration utility ``ss-config``.

::

    $ ss-config -h

    Adds or updates different parts of the SlipStream service configuration in DB.

    Usage: [options] <list-of-files>

    Options:
      -t, --template TEMPLATE       Prints out registered template by name.
      -l, --list                    Lists available templates.
      -p, --persisted               Lists resources persisted in DB.
      -r, --resource RESOURCE  #{}  Prints out persisted resource document(s) by name.
      -h, --help

    Arguments:
      <list-of-files>    list of edn files with configurations.


      Ensure :id key with a corresponding resource name is present in each configuration.
      Connector configuration must contain :cloudServiceType key, which corresponds to
      the connector name.

      ES_HOST and ES_PORT should be exported in the environment for the utility
      to be able to connect to Elasticsearch.

The utility works the way that it takes as input specific resource(s)
configuration file(s), validates them and adds or updates the respective
entries in the DB.  Currently the backend used as DB is Elasticsearch.
It is required to provide its coordinates via exporting ``ES_HOST`` and
``ES_PORT`` environment variables.

The configuration files that the utility expects are in so called ``edn``
format (see `<https://github.com/edn-format/edn>`__).  Here is an example
to show a valid syntax of such file

::

    {
     ; Comment.
     ; Commas separating key/value pairs are optional and can be omitted.
     :keyString  "value",
     :keyInteger 123
     :keyVector  ["a" "b" "c"]
    }

Each configurable resource has a template associated with it.  Templates,
available for ``ss-config``, can be printed with ``-l`` option

::

    $ ss-config -l
    List of accessible templates.
    - templates for 'connector'
    connector-template/openstack
    - templates for 'configuration'
    configuration-template/slipstream

The availability of template for a particular resource is a prerequisite
for ``ss-config`` to be able to work with the resource's configuration
due to the requirement for the utility to be able to validate the provided
configuration against a predefined schema that comes with the template.

Running with ``-t configuration-template/slipstream`` prints out the
service configuration template with all available parameters and their
respective types.

::

    $ ss-config -t configuration-template/slipstream
    {:reportsLocation "/var/tmp/slipstream/reports",
     :prsEndpoint "http://localhost:8203/filter-rank",
     :service "slipstream",
     :connectorOrchPrivateSSHKey "/opt/slipstream/server/.ssh/id_rsa",
     :clientBootstrapURL "https://localhost/downloads/slipstream.bootstrap",
     :cloudConnectorClass "",
     :meteringEndpoint "http://localhost:2005",
     :mailHost "smtp.example.com",
     :mailPort 465,
     :registrationEnable true,
     :mailSSL true,
     :registrationEmail "register@sixsq.com",
     :prsEnable true,
     :serviceURL "https://localhost",
     :meteringEnable false,
     :supportEmail "support@example.com",
     :clientURL "https://localhost/downloads/slipstreamclient.tgz",
     :connectorLibcloudURL "https://localhost/downloads/libcloud.tgz",
     :slipstreamVersion "3.15-SNAPSHOT",
     :id "configuration-template/slipstream",
     :quotaEnable true,
     :mailDebug true,
     :connectorOrchPublicSSHKey "/opt/slipstream/server/.ssh/id_rsa.pub",
     :mailUsername "mailer",
     :serviceCatalogEnable false,
     :mailPassword "change-me"}

The printed out template can serve as a basis for creating edn configuration
file.  Please see :ref:`dg-cfg-main-config` and
:ref:`dg-cfg-files-connector` for documentation on service and
connector configuration files respectively.

File System Structure
---------------------

Initially, SlipStream will look for some of the configuration files in
the file system to load. Typically, the loader will look for files in the
following locations, stopping at the first occurrence:

::

    /etc/slipstream/
    ~/.slipstream/

Inside this structure of the expected configuration is as follows:

+---------------------------+------------------------------------------+
| Configuration file        | Meaning                                  |
+---------------------------+------------------------------------------+
| ``./modules/*.xml``       | Module definition files                  |
+---------------------------+------------------------------------------+
| ``./cloud-ids/*.conf``    | Unique cloud image identifiers           |
+---------------------------+------------------------------------------+
| ``./users/*.xml``         | User definition files                    |
+---------------------------+------------------------------------------+
| ``./passwords/*``         | User passwords                           |
+---------------------------+------------------------------------------+

Note that these files are not created by default during a standard
installation.

.. _dg-cfg-main-config:

Main Configuration File
-----------------------

When the standard installation is performed, the service is started with
a default configuration that gets persisted in the database.

When you want to override these defaults, a good place to start is to save
the output of ``ss-config -t configuration-template/slipstream`` to a file

::

    $ ss-config -t configuration-template/slipstream > slipstream-config.edn

update value of ``:id`` parameter and remove ``-template`` from it so that
it becomes ``configuration/slipstream```; edit the values of the parameters
you want to modify and run

::

    $ export ES_HOST=localhost; export ES_PORT=9300
    $ ss-config slipstream-config.edn

which will push the new configuration to the Elasticsearch backend.

When the configuration is already available in the database and your goal
is just to "edit" some parameters, it's enough to define only some of the
parameter in the configuration file.  E.g,:

::

    $ cat slipstream.edn
    {
     :id "configuration/slipstream"
     :prsEnable true
     :prsEndpoint "http://my-ranking.service/filter-rank"
     :quotaEnable false
     }
    $ ss-config slipstream-config.edn

.. warning::

    Do not forget to remove ``-template`` in the value of the ``:id``
    parameter.

To edit some parameters of an existing configuration, you can
save the current configuration to a file, edit it and then
commit the changes by following the steps below.

::

   $ ss-config -r configuration/slipstream > configuration-slipstream.edn
   $
   $ # edit and save configuration-slipstream.edn file
   $
   $ ss-config configuration-slipstream.edn

All this can be done without SlipStream service running.

.. warning::

    Make sure ``:id`` parameter is in the file.


.. _dg-cfg-files-connector:

Connector Configuration Files
-----------------------------

New connectors can be instantiated and configured by using ``ss-config``
utility.

To instantiate a new instance of a connector, one has to know the name
of the connector and make sure that it is installed.  It's possible to
find what connectors are installed and available for instantiation by
checking the list of templates known to ``ss-config`` with

::

    $ ss-config -l
    List of accessible templates.
    - templates for 'connector'
    connector-template/stratuslabiter
    connector-template/stratuslab
    connector-template/openstack
    connector-template/cloudstack
    connector-template/cloudstackadvancedzone
    - templates for 'configuration'
    configuration-template/slipstream
    $

Copy the name of the desired connector and get its template by

::

    $ ss-config -t connector-template/openstack > connector-openstack.edn
    $ cat connector-openstack.edn
    {:networkPrivate "",
     :serviceRegion "RegionOne",
     :identityVersion "v2",
     :securityGroups "slipstream_managed",
     :cloudServiceType "openstack",
     :orchestratorInstanceType "Basic",
     :floatingIps false,
     :networkPublic "",
     :updateClientURL "",
     :serviceType "compute",
     :quotaVm "20",
     :nativeContextualization "linux-only",
     :id "connector-template/openstack",
     :orchestratorSSHUsername "",
     :maxIaasWorkers 5,
     :serviceName "",
     :orchestratorImageid "",
     :endpoint "",
     :orchestratorSSHPassword ""}

Next step is to define an instance name for the connector and update
the values of the parameters.  Edit the file and modify ``:id`` parameter
by removing ``-template`` and writing the instance name after ``/``.  Keep
``:cloudServiceType`` unchanged.

::

    :id connector/my-openstack
    :cloudServiceType "openstack"

Then, change other parameters like ``:endpoint`` etc.  When finished, run

::

    $ export ES_HOST=localhost; export ES_PORT=9300
    $ ss-config connector-openstack.edn
    Adding connector connector/my-openstack for the first time.
    Updating :cloudConnectorClass parameter with - my-openstack:openstack
    Adding configuration for the first time.
    $

This will add a new instance of the connector and if the service
configuration was missing it will add the default one as well.

To edit some parameters of an existing connector instance, you can list
already persisted connector instances by

::

    $ ss-config -p
    List of persisted resources.
    - resources for 'configuration'
    configuration/slipstream
    - resources for 'connector'
    connector/my-openstack
    connector/stratuslab
    $

then, save the required for editing resource to a file by

::

    $ ss-config -r connector/my-openstack > connector-my-openstack.edn
    $  cat connector-my-openstack.edn
    ;;; Resource: connector/my-openstack
    {:networkPrivate "private",
     :serviceRegion "RegionOne",
     :identityVersion "v3",
     :securityGroups "slipstream_managed",
     :orchestratorInstanceType "Basic",
     :floatingIps false,
     :networkPublic "public",
     :updateClientURL "https://my-slipstream/downloads/openstackclient.tgz",
     :serviceType "compute",
     :quotaVm "20",
     :nativeContextualization "linux-only",
     :orchestratorSSHUsername "",
     :maxIaasWorkers 5,
     :serviceName "",
     :orchestratorImageid "",
     :endpoint "http://my-openstack/openstack",
     :orchestratorSSHPassword ""}

edit parameters in the file and commit the changes by running

::

    $ ss-config connector-my-openstack.edn

All this can be done without SlipStream service running.

.. warning::

    Make sure ``:id`` and ``:cloudServiceType`` keys are in the file.

.. warning::

    If you are using the enterprise edition, makes sure you have the
    license matching the number of connector instance configured.

Module Configuration Files
--------------------------

To load automatically module definitions (i.e. projects, images and
deployments), simply drop module files in the ``./modules``
configuration directory. These files (now in xml and soon in json) can
be retrieved from a live SlipStream instance by simply GETting the
module or appending ``?media=xml`` to the end of a URL, either using
your browser, curl or any other http tool.

**Loading Apps from Nuvla™**

`Nuvla™ <http://nuv.la>`__, a SlipStream service managed by SixSq,
contains a number of interesting apps you can take advantage of. You can
download these following a simple procedure. Once you have the xml
files, simply drop them in the ``modules/`` directory and restart your
SlipStream service.

.. warning::

    Modules will only be loaded from file if no modules already exist.

`More information about loading
apps <https://github.com/slipstream/apps>`__ is available.

.. _dg-cfg-files-unique-cloud-identifier:

Unique Cloud Identifier Configuration Files
-------------------------------------------

As you build a full SlipStream system configuration, you will also need
to provide unique cloud identifiers, especially for base images.
Typically, these files will be cloud service specific. Here is an
example of a unique cloud identifier file for Exoscale:

::

    apps/Minecraft/minecraft-server = exoscale-ch-gva:aaabbbccc

where the key is the module to set, and the value is composed of a ``:``
separated tuple, composed of the cloud service name and the unique cloud
identifier.

.. warning:: 

    Ensure the cloud service name part of the value matches the cloud
    service name defined via the ``cloud.connector.class`` configuration
    parameter.

.. _dg-cfg-files-user:

User Configuration Files
------------------------

The last piece of configuration required to have a fully functional
system is one or several users. By default, SlipStream will create a
privileged user during the first startup of the service. But you can add
more users to the system dropping files in the ``./users/``
configuration directory.

As for modules (see above), user configuration files can be created
GETting existing users.

For security reasons, since user passwords are never transmitted over
the wire once the user is registered, a second set of configuration file
is required to define the user password. Only a hashed version of the
password is kept in the database.

.. _dg-cfg-files-password:

User Password Configuration File
--------------------------------

As mentioned above, the password of each user must be defined using
separate files, located in the ``./passwords/`` directory. The file name
must match the username, without any extension. The file must only
contain the password in clear text.

Here is an example of the content of the password file for the user
``test``:

::

    $ cat ./passwords/test
    Change_Me

You can also, using such a password file change the password of the
``super`` user created automatically during the first execution of the
service. However, ensure that the file is in place before the first
execution, or that no user exist in the database.

.. warning::

    Ensure each password file has the exact same name as the user it
    corresponds to, without any extension.
