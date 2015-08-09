---
title: Cloud Connectors
---

SlipStream supports a variety of different cloud providers through a
set of cloud connectors.  Generally the connectors for open source
cloud providers are also open source; those for commercial providers
are released under a proprietary license.

Doing the following:

    $ yum search slipstream-connector-

will list all of the available cloud connector packages.

## Activating a Cloud Connector

To activate a connector for a specific cloud provider, you must
install the appropriate cloud connector package and configure the
server to make the connector visible to users.

### Installing Cloud Connector Packages

All of the SlipStream cloud connectors are packaged separately.  You
must install the packages for the clouds that you want to support
through your SlipStream server.  See the sections below for detailed
installation instructions for each cloud connector.

> Note that the SlipStream server must be restarted after installing
> or removing a cloud connector.
{: .important}

### Making Connector Visible to Users

In the configuration page, under the *SlipStream Basics* section, you
specify which connectors you want the SlipStream server to load and
activate.

The value for this parameter is a comma-separated list of
`name:connector` pairs.  If the name is not supplied, the default will
be used.  The same connector can be used multiple times with different
names (and parameters).

For example, the value:

    StratusLab,CLOUD2:StratusLab,CLOUD9:CloudStack

will load the StratusLab connector twice (with names "StratusLab" and
"CLOUD2") and the CloudStack connector once (with name "CLOUD9").
    
The cloud and connector names are given in the following table.  Note
that the connector names are case insensitive. 

| Cloud        | Connector Name | License                 |
|:-------------|:---------------|:------------------------|
|Amazon EC2    | AWS            | proprietary             |
|CloudSigma    | CloudSigma     | proprietary             |
|CloudStack    | CloudStack     | open-source (Apache 2.0)|
|OCCI          | OCCI           | open-source (Apache 2.0)|
|OpenStack     | OpenStack      | open-source (Apache 2.0)|
|PhysicalHost  | PhysicalHost   | open-source (Apache 2.0)|
|StratusLab    | StratusLab     | open-source (Apache 2.0)|
|VMWare vCloud | vCloud         | proprietary             |

## Connector Licenses

The connectors are released under different licenses, depending on the
cloud solution with which they interface. Generally, connectors
talking to open source IaaS cloud solutions are released under an open
source license, while for proprietary IaaS solutions, the connectors
are released under a proprietary license.

To get details on the terms for proprietary licenses, please get in
touch with SixSq.

## Connector Installation

### StratusLab Connector

#### Preparation 

The StratusLab connector requires packages from the StratusLab cloud
distribution (notably the python API).  Configure your server to use
the StratusLab yum repository.

    $ cat > /etc/yum.repos.d/stratuslab.repo <<EOF
    [StratusLab-Releases]
    name=StratusLab-Releases
    baseurl=http://yum.stratuslab.eu/releases/centos-6/
    gpgcheck=0
    EOF
    
If the configuration was successful, a `yum search` for "stratuslab"
should provide a list of all of the StratusLab packages. 

#### Installation

Once the StratusLab packages are available, you install the SlipStream
connector for StratusLab:

    $ yum install slipstream-connector-stratuslab

You will need to restart the SlipStream server to make this connector
visible. 

#### Configuration

To allow users to take advantage of this connector, you must add one
or more instances of this connector by either:

 1. Using the UI, go to the *System* -> *Configuration* and in the
    *SlipStream Basics* add a new connector class declaration.
 1. Drop a configuration file and restart the service. See [Configuration
    from File](/documentation/developer_guide/configuration_files.html) documentation
    for details.

### OpenStack Connector

#### Preparation

No additional server configuration is required for the OpenStack
connector.

#### Installation

You can install the OpenStack connector with:

    $ yum install slipstream-connector-openstack

You will need to restart the SlipStream server to make this connector
visible. 

#### Configuration

To allow users to take advantage of this connector, you must add one
or more instances of this connector by either:

 1. Using the UI, go to the *System* -> *Configuration* and in the
    *SlipStream Basics* add a new connector class declaration.
 1. Drop a configuration file and restart the service. See [Configuration
    from File](/documentation/developer_guide/configuration_files.html) documentation
    for details.

### OCCI Connector

#### Preparation

The OCCI connector requires the configuration for the EGI certificate
infrastructure and access to the OCCI client.  You must add the
following repositories to the yum configuration:

    # packages from EPEL
    $ yum install -y yum-priorities libxslt libxml2 libyaml dos2unix

Setup the EGI software repository for yum:

    # EGI UMD Respository
    $ rpm -ivH http://repository.egi.eu/sw/production/umd/2/sl6/x86_64/updates/umd-release-2.0.0-2.el6.noarch.rpm

and also the repository for the rOCCI client:

    # Provider of rOCCI client -- occi-cli RPM.
    $ wget -O /etc/yum.repos.d/rocci.repo \
         http://repository.egi.eu/community/software/rocci.cli/4.2.x/releases/repofiles/sl-6-x86_64.repo

Install the OCCI client with:

    $ yum install -y occi-cli

To setup the trusted CA certificates used by EGI, you must do the
following: 

    # Trusted CA Certificates
    $ yum install -y lcg-CA 

    # Retrieval of certificate revocation lists (CRLs)
    $ yum install fetch-crl

    # run it immediately (it can take some time...)
    $ /usr/sbin/fetch-crl
    # enable the periodic fetch-crl cron job
    $ /sbin/chkconfig fetch-crl-cron on
    $ /sbin/service fetch-crl-cron start

The server must also be configured to support the virtual
organizations (VOs) of the cloud users.  The following shows the
configuration for the "fedcloud.egi.eu" VO. 

    $ mkdir -p /etc/grid-security/vomsdir/fedcloud.egi.eu
    $ cd /etc/grid-security/vomsdir/fedcloud.egi.eu

    $ cat > voms1.egee.cesnet.cz.lsc <<EOF
    /DC=org/DC=terena/DC=tcs/OU=Domain Control
    Validated/CN=voms1.egee.cesnet.cz
    /C=NL/O=TERENA/CN=TERENA eScience SSL CA
    EOF

    $ cat > voms2.grid.cesnet.cz <<EOF
    /DC=org/DC=terena/DC=tcs/OU=Domain Control
    Validated/CN=voms2.grid.cesnet.cz
    /C=NL/O=TERENA/CN=TERENA eScience SSL CA
    EOF

    $ cat >> /etc/vomses <<EOF 
    "fedcloud.egi.eu" "voms1.egee.cesnet.cz" "15002"
    "/DC=org/DC=terena/DC=tcs/OU=Domain Control
    Validated/CN=voms1.egee.cesnet.cz" "fedcloud.egi.eu" "24"
    "fedcloud.egi.eu" "voms2.grid.cesnet.cz" "15002"
    "/DC=org/DC=terena/DC=tcs/OU=Domain Control
    Validated/CN=voms2.grid.cesnet.cz" "fedcloud.egi.eu" "24"
    EOF

#### Installation

You can install the OCCI connector with:

    $ yum install slipstream-connector-occi

You will need to restart the SlipStream server to make this connector
visible. 

#### Configuration

To allow users to take advantage of this connector, you must add one
or more instances of this connector by either:

 1. Using the UI, go to the *System* -> *Configuration* and in the
    *SlipStream Basics* add a new connector class declaration.
 1. Drop a configuration file and restart the service. See [Configuration
    from File](/documentation/developer_guide/configuration_files.html) documentation
    for details.

