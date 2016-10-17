Cloud Connectors
================

SlipStream supports a variety of different cloud providers through a set
of cloud connectors. Generally the connectors for open source cloud
providers are also open source; those for commercial providers are
released under a proprietary license.

Doing the following:

::

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
your SlipStream server. See the sections below for detailed installation
instructions for each cloud connector.

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

For example, the value:

::

    StratusLab,CLOUD2:StratusLab,CLOUD9:CloudStack

will load the StratusLab connector twice (with names "StratusLab" and
"CLOUD2") and the CloudStack connector once (with name "CLOUD9").

The cloud and connector names are given in the following table. Note
that the connector names are case insensitive.

+-----------------+------------------+----------------------------+
| Cloud           | Connector Name   | License                    |
+-----------------+------------------+----------------------------+
| Amazon EC2      | EC2              | proprietary                |
+-----------------+------------------+----------------------------+
| CloudSigma      | CloudSigma       | proprietary                |
+-----------------+------------------+----------------------------+
| CloudStack      | CloudStack       | open-source (Apache 2.0)   |
+-----------------+------------------+----------------------------+
| Microsoft Azure | Azure            | proprietary                |
+-----------------+------------------+----------------------------+
| OCCI            | OCCI             | open-source (Apache 2.0)   |
+-----------------+------------------+----------------------------+
| OpenNebula      | OpenNebula       | open-source (Apache 2.0)   |
+-----------------+------------------+----------------------------+
| OpenStack       | OpenStack        | open-source (Apache 2.0)   |
+-----------------+------------------+----------------------------+
| PhysicalHost    | PhysicalHost     | open-source (Apache 2.0)   |
+-----------------+------------------+----------------------------+
| StratusLab      | StratusLab       | open-source (Apache 2.0)   |
+-----------------+------------------+----------------------------+
| VMware vCloud   | vCloud           | proprietary                |
+-----------------+------------------+----------------------------+

Connector Licenses
------------------

The connectors are released under different licenses, depending on the
cloud solution with which they interface. Generally, connectors talking
to open source IaaS cloud solutions are released under an open source
license, while for proprietary IaaS solutions, the connectors are
released under a proprietary license.

To get details on the terms for proprietary licenses, please get in
touch with SixSq.
