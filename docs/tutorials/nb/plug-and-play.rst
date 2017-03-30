
Plug And Play
=============

Here are the first things to do with the NuvlaBox:

1. Remove the packaging
2. Screw the Wi-Fi antenna in place
3. Connect the box’s power cord to the mains and NuvlaBox
4. Push the power button

How to use the NuvlaBox
-----------------------

Using another device such as laptop, smartphone or tablet (not included) connect to the NuvlaBox Wi-Fi or LAN network.
This connection give you access to local SlipStream and allow you later to your running VMs/deployment.

From the local SlipStream
`````````````````````````

Then connect to the URL: https://nuvlabox. This URL corresponds to the SlipStream service.

Login into local SlipStream with the default user account named "nuvlabox".

From a remote SlipStream
````````````````````````

By default, NuvlaBox are configured to connect to a remote SlipStream named Nuvla managed by SixSq.

Connect the box's WAN port to a local network with an Internet access and a DHCP/DNS services available.

TODO If no DHCP is available in your network please refer to advanced configuration

Then connect to the URL: https://nuv.la.

TODO (What about cloud config on Nuvla, user should configure his account to access his box)

Deploying Applications
-----------------------
There is no differece between running on a cloud or NuvlaBox. Link to SS tutorial.

Accessing VMs
-------------

Use an SSH client to connect to your VMs by using default port 22 and using IP displayed in your run in SlipStream.

To advanced access via tunnel VPN or remote tunnels or via Nuvla redirection please refer to Networking section
