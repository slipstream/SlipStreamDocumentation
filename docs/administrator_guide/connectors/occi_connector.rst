OCCI
====

Preparation
-----------

The OCCI connector requires the configuration for the EGI certificate
infrastructure and access to the OCCI client. You must execute the
following script to install all required dependencies:

::

    # EPEL release
    echo "Installing EPEL release..."
    yum install -y yum-utils epel-release
    yum-config-manager --enable epel

    # Install dependencies
    echo "Installing dependencies..."
    yum install -y yum-priorities libxslt libxml2 libyaml dos2unix

    # Install EGI UMD release
    echo "Installing EGI UMD 3 release (check for other updates) ..."
    rpm -ivH http://repository.egi.eu/sw/production/umd/4/centos7/x86_64/base/umd-release-4.0.0-1.el7.noarch.rpm

    # Install FedCloud CA Certificates
    echo "Installing FedCloud CA Certificates release..."
    yum install -y lcg-CA &>/dev/null

    # NB! Disable UMD 3 repositories.
    # MyProxy and VOMS in UMD are too far out of date and do not work!!!
    sed -i -e 's/^enabled.*/enabled=0/g' /etc/yum.repos.d/UMD-3-*

    # Install CRL renewal
    yum install -y fetch-crl
    # run it immediately (it can take some time...)
    /usr/sbin/fetch-crl
    # enable the periodic fetch-crl cron job
    systemctl enable fetch-crl-cron
    systemctl start fetch-crl-cron

    # Provider of rOCCI client -- occi-cli RPM.
    wget -O /etc/yum.repos.d/rocci.repo http://repository.egi.eu/community/software/rocci.cli/4.3.x/releases/repofiles/sl-7-x86_64.repo
    yum install -y occi-cli

The server must also be configured to support the virtual organizations
(VOs) of the cloud users. The following shows the configuration for the
"fedcloud.egi.eu" VO.

::

    mkdir -p /etc/grid-security/vomsdir/fedcloud.egi.eu
    cd /etc/grid-security/vomsdir/fedcloud.egi.eu

    cat > voms1.egee.cesnet.cz.lsc <<EOF
    /DC=org/DC=terena/DC=tcs/OU=Domain Control Validated/CN=voms1.egee.cesnet.cz
    /C=NL/O=TERENA/CN=TERENA eScience SSL CA
    EOF

    cat > voms2.grid.cesnet.cz <<EOF
    /DC=org/DC=terena/DC=tcs/OU=Domain Control Validated/CN=voms2.grid.cesnet.cz
    /C=NL/O=TERENA/CN=TERENA eScience SSL CA
    EOF

    cat >> /etc/vomses <<EOF
    "fedcloud.egi.eu" "voms1.egee.cesnet.cz" "15002" "/DC=org/DC=terena/DC=tcs/OU=Domain Control Validated/CN=voms1.egee.cesnet.cz" "fedcloud.egi.eu" "24"
    "fedcloud.egi.eu" "voms2.grid.cesnet.cz" "15002" "/DC=org/DC=terena/DC=tcs/OU=Domain Control Validated/CN=voms2.grid.cesnet.cz" "fedcloud.egi.eu" "24"
    EOF

Installation
------------

You can install the OCCI connector with:

::

    $ yum install slipstream-connector-occi

With the software installed, you need to restart the SlipStream service
in order for it to take the new connector into account:

::

    $ systemctl restart slipstream

Now we need to configure SlipStream to take advantage of the new
connector.

Configuration
-------------

To allow users to take advantage of this connector, you must add one or
more instances of this connector by either:

1. Using the `UI <#with-the-ui>`__.
2. Add a connector instance defined via `configuration file
   <#with-a-configuration-file>`__ using `ss-config` utility and restart
   the service.

With the UI
-----------

Instanciate one or more instances of the connector
--------------------------------------------------

Once logged-in with a privileged user (e.g. *super*), open the
configuration page by clicking on *Configuration -> System* at the top
of the page. Then open the *SlipStream Basics* section and define a new
instance of the connector with the following format:

::

    <connector-instance-name>:<connector-name>

Here is an example:

::

    fedcloud-egi-eu:occi

You can also instantiate the connector several times (in compliance with
your license) by comma separating the connector string. Here is an
example:

::

    occi-a:occi, occi-b:occi, ...

Here is a screenshot of the parameter to define:

.. figure:: images/screenshot-cloud-config-param.png
   :alt: SlipStream Configuation - Basics section

   SlipStream Configuation - Basics section

**Don't forget to save the configuration!**

Now that the connector is loaded, you need to configure it.

Configure the connector instance
--------------------------------

With the connector loaded in SlipStream, a new section in the
configuration page will appear, allowing you to configure how the
connector is to communicate with the IaaS cloud endpoint.

[SlipStream Configuation - OCCI section]

You can find a detailed description of each parameter as well as an
explaination of how to find the right value of them in the
```Parameters`` <#parameters>`__ paragraph below.

With a configuration file
-------------------------

Please see :ref:`dg-cfg-files` for details about this method of
configuration.

Here is an example, which will configure the OCCI connector to interact
with fedcloud-egi-eu cloud site:

::

    {
    :id "connector/fedcloud-egi-eu"
    :cloudServiceType "occi"

    <TODO>
    }

You can find a detailed description of each parameter as well as an
explaination of how to find the right value of them in the
`Parameters <#parameters>`__ paragraph below.

Parameters
----------

TODO

Configure native images for this connector instance
---------------------------------------------------

Now you need to update SlipStream native images to add the image id and
some parameters specific to OCCI.

This can be done via the UI or via configuration file. Documentation
about how to do it via configuration file can be found here
:ref:`dg-cfg-files-unique-cloud-identifier`.

Please go on a SlipStream base image (e.g. Ubuntu 12.04) and click on
the *Edit* button. Add the image id for the OCCI Cloud in the section
named *Cloud Image Identifiers and Image Hierarchy*.

And then configure the default amount of CPU and RAM on the tab
*fedcloud-egi-eu* (or the name you gave your OCCI connector earlier) of
the section *Cloud Configuration*.

User credentials
----------------

Now that the connector is configured and the native images updated,
inform your users that they need to configure their credentials for the
OCCI Cloud in their user profile to take advantage of your new
connector.
