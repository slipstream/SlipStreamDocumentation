Cloud Connectors
================

SlipStream supports a variety of different cloud providers through a set
of cloud connectors. Generally the connectors for open source cloud
providers are also open source; those for commercial providers are
released under a proprietary license.

Doing the following::

    $ yum search slipstream-connector-

will list all of the available cloud connector packages.

Activating a Cloud Connector
----------------------------

To activate a connector for a specific cloud provider, you must install
the appropriate cloud connector package and configure the server to make
the connector visible to users.

Installing Cloud Connector Packages
-----------------------------------

All of the SlipStream cloud connectors are packaged separately. You must
install the packages for the clouds that you want to support through
your SlipStream server.

See the connector-specific sections for detailed installation
instructions for each cloud connector.  If the documentation for your
connector is not present, then get in touch with SixSq Support.

.. important::

    Note that the SlipStream server must be restarted after installing
    or removing a cloud connector.

Making Connector Visible to Users
---------------------------------

In the configuration page, under the *SlipStream Basics* section, you
specify which connectors you want the SlipStream server to load and
activate.

The value for this parameter is a comma-separated list of
``name:connector`` pairs. If the name is not supplied, the default will
be used. The same connector can be used multiple times with different
names (and parameters).

For example, the value::

    cloudstack,cloud2:cloudstack,cloud9:openstack

will load the CloudStack connector twice (with names "cloudstack" and
"cloud2") and the CloudStack connector once (with name "cloud9").  The
names given to the connecto instances should be in kebab-case.

The cloud and connector names are given in the following table. Note
that the connector names are case insensitive.

+--------------------+------------------+----------------------------+
| Cloud              | Connector Name   | License                    |
+====================+==================+============================+
| Amazon EC2         | aws              | proprietary                |
+--------------------+------------------+----------------------------+
| CloudStack         | cloudstack       | open-source (Apache 2.0)   |
+--------------------+------------------+----------------------------+
| Exoscale           | exoscale         | proprietary                |
+--------------------+------------------+----------------------------+
| OpenNebula         | opennebula       | open-source (Apache 2.0)   |
+--------------------+------------------+----------------------------+
| OpenStack          | openstack        | open-source (Apache 2.0)   |
+--------------------+------------------+----------------------------+
| Open Telekom Cloud | otc              | proprietary                |
+--------------------+------------------+----------------------------+
| NuvlaBox           | nuvlabox         | proprietary                |
+--------------------+------------------+----------------------------+
| VMware vCloud      | vcloud           | proprietary                |
+--------------------+------------------+----------------------------+

Connector Licenses
------------------

The connectors are released under different licenses, depending on the
cloud solution with which they interface. Generally, connectors talking
to open source IaaS cloud solutions are released under an open source
license, while for proprietary IaaS solutions, the connectors are
released under a proprietary license.

To get details on the terms for proprietary licenses, please get in
touch with SixSq Support.
