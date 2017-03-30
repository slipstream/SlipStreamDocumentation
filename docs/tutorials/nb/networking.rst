
Networking
==========

NuvlaBox acts as a wireless or wired access point.
The clients connect to that access point to access the running services and virtual machines.
The clients are allocated IP addresses in the subnet 172.17.0.0/24.

A bridge (br0) is defined that attaches to the eth0 interface.
The WAN interface has no IP address.  The bridge obtains its IP address through DHCP.
Packets from the wireless card (WLAN) are forwarded to the bridge; only DHCP requests from WLAN are filtered out.

A bridge alias (br0:vm) for br0 is also defined and is assigned the address 172.16.0.1 (note the separate subnet 172.16.0.0/24).
All of the services that require a domain name are running on the 172.16.0.1 address.
This is also the subnet on which the virtual machines run.

Wireless clients can access all services on the NuvlaBox as well as any running virtual machines.
They can also access the internet (via NAT) through the bridge/eth0 if the machine is connected to a network.

People on the external network should not be able to access the services running on the NuvlaBox.

Confined Networking
-------------------

.. image:: images/nb-network-confined.png
   :scale: 90 %
   :align: center

Corp Net
--------
copnet

VPN
---
vpn

Overview of Services
--------------------

Unix Services
`````````````

- DNS: named, ports 172.\*.0.1:53, 127.0.0.1:53, 127.0.0.1:953
- DHCP: dhcpd, port 67
- SSH: sshd, port \*:22

OpenNebula Services
```````````````````

- HTTP  OpenNebula endpoint: port 127.0.0.1:2633
- HTTPS OpenNebula endpoint proxy: port \*:2634
- HTTP  OpenNebula Sunstone 127.0.0.1:9869
- HTTPS OpenNebula Sunstone proxy: \*:9870

SlipStream Services
```````````````````

- HSQLDB: port \*:9001
- ElasticSearch: port 127.0.0.1:9200-9300
- SlipStream: port 127.0.0.1:8201
- SlipStream proxy: port \*:443
- SSCLJ port: port 127.0.0.1:8182

