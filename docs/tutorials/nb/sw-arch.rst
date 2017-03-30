
Software Architecture
=====================

Software Stack
--------------

NuvlaBox is built on top of a robust Open Source foundation:

- Operating System: CentOS
- Cloud layer - Infrastructure as a Service (IaaS): OpenNebula
- App Store - Platform as a Service (PaaS): SlipStream

Virtualisation is performed using KVM. No other cloud appliance provides this level of functionality and integration.

Other Services
--------------

A bunch of services are being used to make the NuvlaBox system easy to use and highly configurable:

Nginx - Hsqldb - ElasticSearch - Hostapd - Dnsmasq - Iptables - Collectd - Graphite - Carbon-cache - Chrony
- OverlayFS - Watchdog - Custom utilities - etc.

Accessible Services Endpoints
-----------------------------

When your are connected to the Wifi or the LAM port of the NuvlaBox, you should use following endpoint:
- nuvlabox (172.16.0.1)

If you are not connected to the box, you can connect to those services by using the IP of the NuvlaBox in your network.

===================  ================
Services Names       Listening Ports
===================  ================
SlipStream           443
OpenNebula Sunstone  9870
SSH                  22
===================  ================