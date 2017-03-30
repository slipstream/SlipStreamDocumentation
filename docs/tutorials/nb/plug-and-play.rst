.. include:: ../global.rst

Plug And Play
=============

Here are the first things to do with the NuvlaBox:

1. Remove the packaging
2. Screw the Wi-Fi antenna in place
3. Connect the box’s power cord to the mains and NuvlaBox
4. Push the power button

How to use the NuvlaBox
-----------------------

<<<<<<< HEAD
Using another device such as laptop, smartphone or tablet (not included) connect to the NuvlaBox Wi-Fi or LAN network.
This connection give you access to local SlipStream and allow you later to your running VMs/deployment.
=======
NuvlaBox is your private *mini* IaaS_ Cloud.  And as with any IaaS Cloud you
want a friendly SaaS_ or PaaS_ service to help you with building and deploying
applications on IaaS.  This is where SlipStream comes into the picture.  As with
any onther Clouds, SlipStream can be used to manage your applications on your
NuvlaBox(s).
>>>>>>> 5a7aef9db7d28ebe133a5062b55652856645c140

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

<<<<<<< HEAD
Use an SSH client to connect to your VMs by using default port 22 and using IP displayed in your run in SlipStream.

To advanced access via tunnel VPN or remote tunnels or via Nuvla redirection please refer to Networking section
=======
Here is the easiest method to access VMs.  To advanced access via tunnel VPN or
remote tunnels or via Nuvla redirection please refer to Networking section


.. _IaaS: https://en.wikipedia.org/wiki/Cloud_computing#Infrastructure_as_a_service_.28IaaS.29

.. _PaaS: https://en.wikipedia.org/wiki/Platform_as_a_service

.. _SaaS: https://en.wikipedia.org/wiki/Software_as_a_service
>>>>>>> 5a7aef9db7d28ebe133a5062b55652856645c140
