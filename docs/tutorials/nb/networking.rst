
Networking
==========

The NuvlaBox has been designed to be flexible and to support several
network scenarios.  By default, the NuvlaBox is configured with a
specific network scenario which doesn't need any configuration from
the operator.  The default network scenario used by the NuvlaBox is
named `Confined Network`.  This as well as other well tested network
scenarios are described in detail in the following sections.

Confined Network
----------------

In this scenario, all Virtual Machines (VMs) and all users are
connected to the network managed by the NuvlaBox.  The advantage of
this network scenario is that no configuration is needed to access and
to use the NuvlaBox. Specifically, 

- VMs are created in internal virtual networks inside the NuvlaBox.
- An internal DHCP allocates IP addresses to VMs and to users.
- Connected users in `LAN / WLAN network` and virtual machines in `VM
  network` have access to the company network and to the Internet
  through Network Address Translation (NAT).
- VMs are reachable through the `LAN / WLAN network`.

.. image:: images/nb-network-confined.png
   :scale: 80 %
   :align: center


Shared Network
--------------

In this scenario, all VMs are reachable from the `Company Network`
without being connected directly to the NuvlaBox.  The advantage of
this network scenario is that services running within VMs on the
NuvlaBox can be accessed directly through the `Company
Network`. Specifically,

- Virtual machines and users are bridged onto the `Company Network`.
- The company's DHCP server allocates users' IP addresses, but a range
  of IP addresses on the `Company Network` for VMs is allocatec to and
  managed by the NuvlaBox itself.

.. image:: images/nb-network-shared.png
   :scale: 80 %
   :align: center


VPN Network
-----------

The idea about this network scenario is to have running VMs on a
shared VPN network transparently to the VMs.  The advantage of this
network scenario is to have access to VMs from anywhere from the
internet by using a VPN connection.

Specificity:

- Virtual machines are bridged onto the `VPN Network`.
- If a local connection is available with access to the Internet, VMs
  use this connection to access internet and VPN connection to
  communicate with the `VPN Network`.

.. image:: images/nb-network-vpn.png
   :scale: 80 %
   :align: center


VM level VPN connection
-----------------------

This is not a real network scenario, because it use the `Confined
Network` scenario and SlipStream recipe configuration to make the VMs
connect to a remote VPN server.  The advantage of this network
scenario is to have access to VMs from anywhere from the internet
without changing the default network scenario of the NuvlaBox.

.. NOTE:: Contact SixSq if you need a custom network scenario.

