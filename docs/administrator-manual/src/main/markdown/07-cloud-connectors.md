
# Cloud Connectors

SlipStream™ supports a variety of different cloud providers through a
set of cloud connectors.  Generally the connectors for open source cloud
providers are also open source; those for commercial providers are
released under a proprietary license.

## Activating a Cloud Connector

The StratusLab connector is configured by default.  All of the other
connectors must be activated.

In the configuration page, under the *SlipStream_basics* section, you
specify which connectors you want the SlipStream™ server to load and
activate.  The following table provides the names of the connector
classes you must use to activate the corresponding connector:

-----------

StratusLab (activated by default)   com.sixsq.slipstream.connector.stratuslab.StratusLabConnector   open-source

Abiquo                              com.sixsq.slipstream.connector.abiquo.AbiquoConnector           proprietary

OpenStack                           com.sixsq.slipstream.connector.openstack.OpenStackConnector     open-source

VMWare vCloud                       com.sixsq.slipstream.connector.vcloud.VCloudConnector           proprietary

Amazon EC2                          com.sixsq.slipstream.connector.aws.Ec2Connector                 proprietary

CloudSigma                          com.sixsq.slipstream.connector.cloudsigma.CloudSigmaConnector   proprietary

-----------

Note that the default name of a connector can be overwritten.  Further,
the same connectors can be loaded several times, such that you can
use several clouds using the same technology.
The following example shows how to define the StratusLab connector multiple times:
    
    com.sixsq.slipstream.connector.stratuslab.StratusLabConnector, lal:com.sixsq.slipstream.connector.stratuslab.StratusLabConnector, grnet:com.sixsq.slipstream.connector.stratuslab.StratusLabConnector
    
The result of the above configuration will be to load the StratusLab connector
three times, the first one with the default *stratuslab* name, while the second and
third will be respectively called *lal* and *grnet*.

## Connector Configuration

The following sections provide details on how to configure the various
cloud connectors.

Before loading a connector ensure that it has been installed. All
connectors are normally installed using yum.

The following sections provide further configuration details on the
different connectors. 

### CloudSigma

### Amazon EC2

### OpenStack

### StratusLab

### VMWare vCloud

### Abiquo


