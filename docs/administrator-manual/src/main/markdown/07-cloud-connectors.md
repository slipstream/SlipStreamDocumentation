
# Cloud Connectors

SlipStream™ supports a variety of different cloud providers through a
set of cloud connectors.  Generally the connectors for open source
cloud providers are also open source; those for commercial providers
are released under a proprietary license.

## Activating a Cloud Connector

The StratusLab connector is configured by default.  All of the other
connectors must be activated.

In the configuration page, under the *SlipStream Basics* section, you
specify which connectors you want the SlipStream™ server to load and
activate.  The following table provides the names of the connector
classes you must use to activate the corresponding connector.

-------------  ---------------------------------------
Cloud          SlipStream Connector Class Name
-------------  ---------------------------------------
StratusLab     com.sixsq.slipstream.connector.stratuslab.StratusLabConnector 
                                                                             
Abiquo         com.sixsq.slipstream.connector.abiquo.AbiquoConnector         
                                                                             
OpenStack      com.sixsq.slipstream.connector.openstack.OpenStackConnector   
                                                                             
VMWare vCloud  com.sixsq.slipstream.connector.vcloud.VCloudConnector         
                                                                             
Amazon EC2     com.sixsq.slipstream.connector.aws.Ec2Connector               
                                                                             
CloudSigma     com.sixsq.slipstream.connector.cloudsigma.CloudSigmaConnector 
-------------  ---------------------------------------

Note that the default name of a connector can be overwritten.
Further, the same connectors can be loaded several times, such that
you can use several clouds using the same technology.  The following
example shows how to define the StratusLab connector multiple times
(value should be on one line):
    
    com.sixsq.slipstream.connector.stratuslab.StratusLabConnector, 
    lal:com.sixsq.slipstream.connector.stratuslab.StratusLabConnector, 
    grnet:com.sixsq.slipstream.connector.stratuslab.StratusLabConnector
    
The result of the above configuration will be to load the StratusLab
connector three times, the first one with the default *stratuslab*
name, while the second and third will be respectively called *lal* and
*grnet*.

## Connector Licenses

The connectors are released under different licenses, depending on the
cloud solution they are design to interface with. Generally,
connectors talking to open source IaaS cloud solutions are released
under an open source license, while for proprietary IaaS solutions,
the connectors are released under a proprietary license.

-----------------------  -------------------------
Cloud Solution/Service   License
-----------------------  -------------------------
StratusLab               open-source (Apache 2.0)
               
Abiquo                   proprietary
               
OpenStack                open-source (Apache 2.0)
               
VMWare vCloud            proprietary
               
Amazon EC2               proprietary
               
CloudSigma               proprietary
-----------------------  -------------------------

To get details on the terms for proprietary licenses, please get in
touch with SixSq.

