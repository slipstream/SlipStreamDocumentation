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

### Amazon EC2 Connector

The following instructions will guide you through the procedure of
installing and configuring a SlipStream Amazon EC2 connector, such that
you can add EC2 to the list of clouds your SlipStream can talk to.

#### License

This connector is distributed by SixSq under a commercial license and
is available via various pricing plans. You can check it out with a **free**
trail via our [SaaS service][saas].
Feel free to contact the [SlipStream Support team](mailto:support@sixsq.com)
with any questions about how the SlipStream Amazon EC2 connector can be
beneficial to you and your business.

Once you have purchased a new commercial connector, SixSq will provide
you with a specific yum configuration.

#### Installation

Once your yum configuration is in place, you can install the connector
executing the following command:

	$ yum install slipstream-connector-ec2-enterprise

With the software installed, you need to restart the SlipStream service
in order for it to take the new connector into account:

	$ service slipstream restart

Now we need to configure SlipStream to take advantage of the new connector.

#### Load the connector in SlipStream

Once the connector software is installed, you can configure SlipStream to
load this connector
by either setting the parameter in the configuration file
(i.e. `/etc/slipstream/slipstream.conf`) or via the web interface.

**Configuration file**

The list of connector instances SlipStream uses is defined by the
`cloud.connector.class` configuration parameter:

	$ cat /etc/slipstream/slipstream.conf
	# SlipStream(tm) Server configuration file
	...

	cloud.connector.class = ec2
	
	...

By default, the connector instance will be named *ec2*.
You can change the name of the connector by prepending the name followed by
a semi colon (i.e. `:`). Here is an example:

	cloud.connector.class = my-ec2:ec2

You can also instantiate the connector several times (in compliance with your
license) by comma separating the connector string. Here is an example:

	cloud.connector.class = my-ec2-1:ec2, my-ec2-2:ec2, ...

Once the configuration file is set, login to SlipStream as a privileged user
and load the configuration. The configuration page is available by clicking
on the spanner icon at the top right of the screen. To load the changes made
in the configuration file, simply click on the **Reload Configuration File**
button.
You should then see the changed value in the *SlipStream Basics* section.

**Configuration page**

You can also define which connector to load, as per the Configuration file
section above, using the web user interface.
Once logged-in with a privileged user (e.g. *super*), open the configuration
page by clicking on the spanner icon at the top right of the screen.
Then open the *SlipStream Basics* section and drop in the value of the
configuration, as per described in the section above. Here is a screenshot
of the parameter to define:

![SlipStream Configuation - Basics section]

**Don't forget to save the configuration!** Now that the connector is loaded,
you need to configure it.


**Super/privileged user**

By default, SlipStream configures a privileged user called *super*, with the
default password `supeRsupeR`.
**Please make sure you change this default password.**


#### Configure the connector instance in SlipStream

Once the connector is loaded, you need to configure it.  While you can also
define these parameters using the configuration file, we only show here how to
do it using the web user interface.

With the connector loaded in SlipStream, a new section in the configuration
page will appear, allowing you to configure how the connector is to communicate
with the IaaS cloud endpoint.

![SlipStream Configuation - EC2 section]

**EC2 region**

The EC2 region defines where your EC2 instances will be deployed.
Some parameters may be different between regions (e.g. image id: ami-...).
If you want to use multiple regions concurrently, you will need to instantiate
this connector multiple times.

**Cloud Client Connector**

This field corresponds to the URL where the Orchestrator will download the
tarball of the connector for the SlipStream Client.
In a default installation the URL will be
`https://ip_or_hostname/downloads/ec2client.tgz` where `ip_or_hostname`
corresponds to the IP or the hostname of your SlipStream Server.

**Orchestrator security group**

The EC2 security group should allow TCP connexions from the Orchestrator itself
to the SlipStream server and to the EC2 API.
The default security group named `default` should normally work perfectly.

**Image Id of the Orchestrator**

The image id of the Orchestrator needs to match a Linux image with `wget` and
`python` installed.
An Ubuntu 12.04 or 14.04 will do the job perfectly (at the time or writing, for
the region `eu-west-1` the image id is `ami-a0dd3dd7`).
EC2 image ids start with `ami-`.
You can found them in the EC2 web interface.

**Quota**

The quota is a SlipStream feature which enables the SlipStream administrator to
set a default quota for all users of a specified connector.
You can also override this value for each user in the user profile.
If this feature is disabled in the *SlipStream Advanced* section of this page,
you can leave this field blank.

**Orchestrator instance type**

The instance type is a name which is linked to a hardware specification defined
by EC2.
You can find the list of all possible values [here][ec2-instance-types].
The Orchestrator doesn't need a big amount of resources so you can choose a
small instance type (like `t2.micro` or `t2.small`).

#### Configure native images for this connector isnstance

Now you need to update SlipStream native images to add the image id and some
parameters specific to EC2.

Please go on a SlipStream base image (e.g. Ubuntu 12.04) and click on the
*Edit* button.
Add the image id for EC2 in the section named
*Cloud Image Identifiers and Image Hierarchy*.

And then configure the default amount of CPU and RAM on the tab *ec2* (or the
name you gave your EC2 connector earlier) of the section *Cloud Configuration*.

#### User credentials

Now that the connector is configured and the native images updated, inform your
users that they need to configure their credentials for EC2 in their user
profile to take advantage of your new connector.


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
or more instances of this connector in the *SlipStream Basics* section
of the server configuration.

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

The following instructions will guide you through the procedure of configuring
a SlipStream OpenStack connector, such that you can add your OpenStack cloud
to the list of clouds your SlipStream can talk to.

##### Load the connector in SlipStream

Once the connector software is installed, you can configure SlipStream to load
this connector by either setting the parameter in the configuration file (i.e.
`/etc/slipstream/slipstream.conf`) or via the web interface.


##### Configuration file

The list of connector instances SlipStream uses is defined by the
`cloud.connector.class` configuration parameter:

    $ cat /etc/slipstream/slipstream.conf
    # SlipStream(tm) Server configuration file
    ...

    cloud.connector.class = openstack

    ...

By default, the connector instance will be named *openstack*. You can change
the name of the connector by prepending the name followed by a semi colon
(i.e. `:`).
Here is an example:

    cloud.connector.class = my-openstack:openstack

You can also instantiate the connector several times (in compliance with your
license) by comma separating the connector string. Here is an example:

    cloud.connector.class = my-os-1:openstack, my-os-2:openstack, ...

Once the configuration file is set, login to SlipStream as a privileged user
and load the configuration. The configuration page is available by clicking on
the spanner icon at the top right of the screen. To load the changes made in
the configuration file, simply click on the **Reload Configuration File**
button.  You should then see the changed value in the *SlipStream Basics*
section.


##### Configuration page

You can also define which connector to load, as per the Configuration file
section above, using the web user interface.  Once logged-in with a privileged
user (e.g. *super*), open the configuration page by clicking on the spanner
icon at the top right of the screen.  Then open the *SlipStream Basics*
section and drop in the value of the configuration, as per described in the
section above. Here is a screenshot of the parameter to define:

![SlipStream Configuation - OpenStack section]

**Don't forget to save the configuration!**

Now that the connector is loaded, you need to configure it.


**Super/privileged user**

By default, SlipStream configures a privileged user called *super*, with the
default password `supeRsupeR`. **Please make sure you change this default
password.**


##### Configure the connector instance in SlipStream

Once the connector is loaded, you need to configure the connector.  While you
can also define these parameters using the configuration file, we only show
here how to do it using the web user interface.

With the connector loaded in SlipStream, a new section in the configuration
page will appear, allowing you to configure how the connector is to
communicate with the IaaS cloud endpoint.

**Type name of the service which provides the instances functionality**

This field should always be `compute`. If it doesn't work with this value,
please ask your OpenStack provider/administrator for the correct value.


**Service endpoint**

The service endpoint is the URL SlipStream will use to communicate with the
OpenStack. This url needs to match the OpenStack identity service (Keystone).
You can find it in the OpenStack dashboard under *Access & Security* in the
tab *API Access*. Most of the time this value will match the following
pattern: `https://OpenStack_ip:5000/v2.0`

![Openstack web interface - Access & Security - API Access]

**Quota**

The quota is SlipStream feature which enable the SlipStream administrator to
set a default quota for all users of a specified connector. You can also
override this value per user in the user profile. If this feature is disabled
in the *SlipStream Advanced* section of this page, you can leave this field
blank.


**Image Id of the Orchestrator**

The image id of the Orchestrator needs to match a Linux image with `wget` and
`python` installed. An Ubuntu 12.04 or 14.04 will do the job perfectly.

To find an image id go on the OpenStack web interface and click on the link
named *Images & Snapshots* and then click on the image you want. The *ID*
value is what you need to paste in.

![Openstack web interface - Image details]

**Region**

Check this value in the OpenStack documentation or ask your OpenStack
administrator.  The default region is `RegionOne` or `regionOne` depending of
the OpenStack version.

**Name of the service which provides the instances functionality**

Most of time the value of this field will be `nova` and sometime `compute`. If
it doesn't work with these values, please ask your OpenStack administrator for
the correct value.

**Flavor of the Orchestrator**

The flavor (instance type) is a name which is linked to a hardware
specification defined by the Cloud. To find the list of all possible values,
please go on the OpenStack web interface and find a link called *Flavor* or
*Instance type*. The Orchestrator doesn't need a big amount of resources so
you can choose a small flavor (like 1 CPU and 512 MB of RAM).

##### Configure native images for this connector instance

Now you need to update SlipStream native images to add the image id and some
parameters for OpenStack.

Please go on a SlipStream base image (e.g. Ubuntu 14.04) and click on the
*Edit* button. Add the image id for OpenStack in the section named *Cloud
Image Identifiers and Image Hierarchy*.

And then configure the default amount of CPU and RAM on the tab *OpenStack*
(or the name you gave your OpenStack connector earlier) of the section *Cloud
Configuration*.

![SlipStream Image - edit mode]

##### User credentials

Now that the connector is configured and the native images updated, inform
your users that they need to configure their credentials for OpenStack in
their user profile to take advantage of your new connector.


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
or more instances of this connector in the *SlipStream Basics* section
of the server configuration.


### CloudStack Connector

#### Installation

You can install the OpenStack connector with:

    $ yum install slipstream-connector-cloudstack

You will need to restart the SlipStream server to make this connector
visible.

#### Configuration

The following instructions will guide you through the procedure of configuring
a SlipStream CloudStack connector, such that you can add your CloudStack cloud
to the list of clouds your SlipStream can talk to.

#### Load the connector in SlipStream

Once the connector software is installed, you can configure SlipStream to load
this connector by either setting the parameter in the configuration file (i.e.
`/etc/slipstream/slipstream.conf`) or via the web interface.

##### Configuration file

The list of connector instances SlipStream uses is defined by the
`cloud.connector.class` configuration parameter:

    $ cat /etc/slipstream/slipstream.conf
    # SlipStream(tm) Server configuration file
    ...

    cloud.connector.class = cloudstack

    ...

By default, the connector instance will be named *cloudstack*. You can change
the name of the connector by prepending the name followed by a semi colon
(i.e. `:`). Here is an example:

    cloud.connector.class = exoscale-ch-gva:cloudstack

You can also instantiate the connector several times (in compliance with your
license) by comma separating the connector string. Here is an example:

    cloud.connector.class = my-cs-1:cloudstack, my-cs-2:cloudstack, ...

Once the configuration file is set, login to SlipStream as a privileged user
and load the configuration. The configuration page is available by clicking on
the spanner icon at the top right of the screen. To load the changes made in
the configuration file, simply click on the **Reload Configuration File**
button.  You should then see the changed value in the *SlipStream Basics*
section.


##### Configuration page

You can also define which connector to load, as per the Configuration file
section above, using the web user interface.  Once logged-in with a privileged
user (e.g. *super*), open the configuration page by clicking on the spanner
icon at the top right of the screen.  Then open the *SlipStream Basics*
section and drop in the value of the configuration, as per described in the
section above. Here is a screenshot of the parameter to define:

![SlipStream Configuation - Basics section]

**Don't forget to save the configuration!**

Now that the connector is loaded, you need to configure it.

**Super/privileged user**

By default, SlipStream configures a privileged user called *super*, with the
default password `supeRsupeR`. **Please make sure you change this default
password.**


##### Configure the connector instance in SlipStream

Once the connector is loaded, you need to configure the connector. While you
can also define these parameters using the configuration file, we only show
here how to do it using the web user interface.

With the connector loaded in SlipStream, a new section in the configuration
page will appear, allowing you to configure how the connector is to
communicate with the IaaS cloud endpoint.

![SlipStream Configuation - CloudStack section]

*Note: All the CloudStack API examples come from [cloudmonkey] configured with
[Exoscale Open Cloud API] endpoint.*

###### Zone

The availability zone where the virtual machines will be provisionned.

Use the `name` value from the [listZones] results:

    > list zones
    count = 1
    zone:
    name = ch-gva-2
    id = 1128bd56-b4d9-4ac6-a7b9-c715b187ce11
    [...]

###### Image Id of the Orchestrator

The image id of the Orchestrator needs to match a Linux image with `wget` and
`python` installed. An Ubuntu 12.04 will do the job perfectly.

Use the `id` value from the [listTemplates] results:

    > list templates templatefilter=featured
    count = 37
    template:
    id = 8c7e60ae-3a30-4031-a3e6-29832d85d7cb
    name = Linux Ubuntu 12.04 LTS 64-bit
    [...]

For Exoscale you can browse the [available templates] and choose the one that
suits your need.

###### Flavor of the Orchestrator

The flavor (instance type) is a name which is linked to a hardware
specification defined by the Cloud. The Orchestrator doesn't need a big amount
of resources so you can choose a small flavor (like 1 CPU and 512 MB of RAM).

Use the `name` value from the [listServiceOfferings] results:

    > list serviceofferings
    count = 7
    serviceoffering:
    name = Micro
    id = 71004023-bb72-4a97-b1e9-bc66dfce9470
    [...]

###### Quota

The quota is SlipStream feature which enable the SlipStream administrator to
set a default quota for all users of a specified connector. You can also
override this value per user in the user profile. If this feature is disabled
in the *SlipStream Advanced* section of this page, you can leave this field
blank.

###### Service endpoint

The CloudStack API Endpoint used by SlipStream to communicate with the
CloudStack Cloud.

Example: `https://api.exoscale.ch/compute`

##### Configure native images for this connector instance

Now you need to update SlipStream native images to add the image id and some
parameters for CloudStack.

Please go on a SlipStream base image (e.g. Ubuntu 12.04) and click on the
*Edit* button. Add the image id for CloudStack in the section named *Cloud
Image Identifiers and Image Hierarchy*.

And then configure the default amount of CPU and RAM on the tab *CloudStack*
(or the name you gave your CloudStack connector earlier) of the section *Cloud
Configuration*.

##### User credentials

Now that the connector is configured and the native images updated, inform
your users that they need to configure their credentials for CloudStack in
their user profile to take advantage of your new connector.


### vCloud Connector

#### License

The connector is distributed by SixSq under a commercial license and is
available via various pricing plans.
Feel free to contact the [SlipStream Support team][support-email]
with any questions about the SlipStream vCloud connector can be beneficial.

#### Installation

With each new commercial connector purchased, SixSq will provide you with a
specific yum configuration.
Once your yum configuration is in place, you can install the connector by
executing the following command:

	$ yum install slipstream-connector-vcloud-enterprise

With the software installed, you need to restart the SlipStream service
in order for it to take the new connector into account:

	$ service slipstream restart

Now we need to configure SlipStream to take advantage of the new connector.

#### Configuration

The following instructions will guide you through the procedure of configuring
a SlipStream VMWare vCloud connector, such that you can add your vCloud to
the list of clouds your SlipStream can talk to.

The connector is distributed by SixSq under a commercial license and is
available via various pricing plans. Feel free to contact the
[SlipStream Support team](mailto:support@sixsq.com) with any questions about
the SlipStream vCloud connector can be beneficial.

##### Load the connector in SlipStream

Once the connector software is installed, you can configure SlipStream to
load this connector by either setting the parameter in the configuration
file (i.e. `/etc/slipstream/slipstream.conf`) or via the web interface.


###### Configuration file

The list of connector instances SlipStream uses is defined by the
`cloud.connector.class` configuration parameter:

	$ cat /etc/slipstream/slipstream.conf
	# SlipStream(tm) Server configuration file
	...

	cloud.connector.class = vcloud
	
	...

By default, the connector instance will be named *vcloud*. You can change
the name of the connector by prepending the name followed by a semi colon
(i.e. `:`). Here is an example:

	cloud.connector.class = my-vcloud:vcloud

You can also instantiate the connector several times
(in compliance with your license) by comma separating the connector string.
Here is an example:

	cloud.connector.class = my-vcloud-1:vcloud, my-vcloud-2:vcloud

Once the configuration file is set, login to SlipStream as a privileged user
and load the configuration. The configuration page is available by clicking
on the spanner icon at the top right of the screen. To load the changes made
in the configuration file, simply click on the **Reload Configuration File**
button.
You should then see the changed value in the *SlipStream Basics* section.


##### Configuration page

You can also define which connector to load, as per the Configuration file
section above, using the web user interface.  Once logged-in with a privileged
user (e.g. *super*), open the configuration page by clicking on the spanner
icon at the top right of the screen.  Then open the *SlipStream Basics* section
and drop in the value of the configuration, as described in the section above.
Here is a screenshot of the parameter to define:

![SlipStream Configuation - Basics section]

**Don't forget to save the configuration!** Now that the connector is loaded,
you need to configure it.


**Super/privileged user**

By default, SlipStream configures a privileged user called *super*, with the
default password `supeRsupeR`.
**Please make sure you change this default password.**

##### Configure the connector instance in SlipStream

Once the connector is loaded, you need to configure it.  While you can also
define these parameters using the configuration file, we only show here how to
do it using the web user interface.

With the connector loaded in SlipStream, a new section in the configuration
page will appear, allowing you to configure how the connector should
communicate with the IaaS cloud endpoint.

![SlipStream Configuation - vCloud section]

###### *Service endpoint*

The service endpoint is the URL SlipStream will use to communicate with vCloud.
You should ask your vCloud adminitrator to give you this value.
But most of time this value corresponds to the root part of the URL you are
using to access vCloud web interface with `/api` appended.

###### *Virtual Cata Center*

The VDC name can be found on the vCloud web interface
(please see the image below).
First click on the *Administration* tab and on *Virtual Datacenters*.
Then you will see a list with all VDC your account has access to.
If you need to configure multiple VDC, you will have to instantiate multiple
connectors.

![vCloud web interface - Virtual Datacenters]

###### *Quota*

The quota is a SlipStream feature which enables the SlipStream administrator
to set a default quota for all users of a specified connector.
You can also override this value for each user in the user profile.
If this feature is disabled in the *SlipStream Advanced* section of this page,
you can leave this field blank.

###### *Cloud Client Connector*

This field corresponds to the URL where the Orchestrator will download the
tarball of the connector for the SlipStream Client.
In a default installation the URL will be
`https://ip_or_hostname/downloads/vcloudclient.tgz` where `ip_or_hostname`
corresponds to the IP or the hostname of your SlipStream Server.

###### *Image Id of the Orchestrator*

For vCloud an image id corresponds to the (unique) name of a vApp with only
one VM inside.
The image id of the Orchestrator needs to match a Linux image with `wget` and
`python` installed. An Ubuntu 12.04 will do the job perfectly.

To find the image id go on the vCloud web interface and click on the *Catalogs*
tab and then browse catalogs to find an appropriate image.

![vCloud web interface - Catalog]

###### *Orchestrator instance size*

The instance size is a coma separated list of two elements.
The first is the number of CPU cores the Orchestrator instance will have.
The second is the amount of RAM in GB the Orchestrator will have.
The Orchestrator doesn't need a big amount of resources so 1 CPU and 1 GB of RAM
should be enough - e.g. `(1,1)`.

##### Configure native images for this connector instance

Now you need to update SlipStream native images to add the image id and some
parameters for vCloud.

Please go on a SlipStream base image (e.g. Ubuntu 12.04) and click on the
*Edit* button. Add the image id for vCloud in the section named
*Cloud Image Identifiers and Image Hierarchy*.

And then configure the default amount of CPU and RAM on the tab *vCloud*
(or the name you gave your OpenStack connector earlier) of the section
*Cloud Configuration*.

![SlipStream Image - edit mode]

##### User credentials

Now that the connector is configured and the native images updated, inform your
users that they need to configure their credentials for vCloud in their user
profile to take advantage of your new connector.



[support-email]: mailto:support@sixsq.com
[saas]: http://sixsq.com/products/slipstream-tryme.html
[ec2-instance-types]: https://aws.amazon.com/ec2/instance-types/
[SlipStream Configuation - Basics section]: http://sixsq.com/img/content/blogs/cloud-config-param-screenshot.png
[SlipStream Configuation - EC2 section]: http://sixsq.com/img/content/blogs/doc_EC2_ss_system_parameters.png
[SlipStream Configuation - OpenStack section]: http://sixsq.com/img/content/blogs/doc_OpenStack_ss_system_parameters.png
[Openstack web interface - Access & Security - API Access]: http://sixsq.com/img/content/blogs/doc_OpenStack_endpoint.png
[Openstack web interface - Image details]: http://sixsq.com/img/content/blogs/doc_OpenStack_imageId.png
[SlipStream Image - edit mode]: http://sixsq.com/img/content/blogs/doc_OpenStack_image_parameters.png
[SlipStream Configuation - Basics section]: http://sixsq.com/img/content/blogs/cloud-config-param-screenshot2.png
[SlipStream Configuation - CloudStack section]: http://sixsq.com/img/content/blogs/doc_cloudstack_ss_system_parameters.png
[cloudmonkey]: https://cwiki.apache.org/confluence/display/CLOUDSTACK/CloudStack+cloudmonkey+CLI
[Exoscale Open Cloud API]: https://community.exoscale.ch/api/compute/
[listZones]: https://cloudstack.apache.org/docs/api/apidocs-4.0.0/domain_admin/listZones.html
[listTemplates]: https://cloudstack.apache.org/docs/api/apidocs-4.0.0/domain_admin/listTemplates.html
[available templates]: https://www.exoscale.ch/open-cloud/templates/
[listServiceOfferings]: https://cloudstack.apache.org/docs/api/apidocs-4.0.0/domain_admin/listServiceOfferings.html
[SlipStream Configuation - Basics section]: http://sixsq.com/img/content/blogs/cloud-config-param-screenshot.png
[SlipStream Configuation - vCloud section]: http://sixsq.com/img/content/blogs/doc_vCloud_ss_system_parameters.png
[vCloud web interface - Virtual Datacenters]: http://sixsq.com/img/content/blogs/doc_vCloud_vdc.png
[vCloud web interface - Catalog]: http://sixsq.com/img/content/blogs/doc_vCloud_imageId.png
[SlipStream Image - edit mode]: http://sixsq.com/img/content/blogs/doc_vCloud_image_parameters.png



