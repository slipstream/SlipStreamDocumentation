
.. include:: ../links.txt

Using the NuvlaBox
------------------

Here are the first things to do with the NuvlaBox:

1. Remove the packaging
2. Attach the WiFi antennas
3. Connect the NuvlaBox’s power cord to the mains and to the NuvlaBox
4. Push the power button
5. Keep credentials prospectus in a safe place

.. figure:: images/prospectus-example.png
   :scale: 80 %
   :alt: Credentials prospectus example
   :align: center

   Example of credentials prospectus for the NuvlaBox named after
   Albert Einstein

Using another device such as laptop, smartphone or tablet (not
included) connect to the NuvlaBox WiFi or LAN network.  This
connection give you access to a local SlipStream and allows you later
on to access your running virtual machines.

.. note:: Please follow :doc:`Module II </tutorials/ss/module-2>` of
          the SlipStream tutorial to learn the necessary basis about
          SlipStream.

You can treat the NuvlaBox as your private *mini* IaaS_ cloud.  As
with any IaaS Cloud you want a friendly SaaS_ or PaaS_ service to help
you with building and deploying applications on IaaS.  This is where
SlipStream comes into the picture.  SlipStream can be used to manage
your applications on your NuvlaBox(es) just like you can do for other
cloud infrastructures.


Manage the NuvlaBox from the Local SlipStream
`````````````````````````````````````````````

Using another device such as laptop, smartphone or tablet (not
included) connect to the NuvlaBox WiFi or LAN network.

Then connect to the URL: https://nuvlabox. This URL corresponds to the
SlipStream service.

Choose ``local`` in NuvlaBox welcome page and login into SlipStream with
the "nuvlabox" user account.

Manage the NuvlaBox from a Remote SlipStream
````````````````````````````````````````````

By default, NuvlaBoxes are pre-configured to connect to a remote
SlipStream named Nuvla_ managed by SixSq.  Connect the NuvlaBox's WAN
port to a network with an Internet access and where a DHCP/DNS
services are available.

.. HINT:: If no DHCP is available in your network, you can connect to
   your LAN, access NuvlaBox admin UI and set a static IP for the
   NuvlaBox WAN interface.

Then connect to Nuvla with following URL: https://nuv.la.

To be able to manage applications on NuvlaBoxes from SlipStream one
has to configure credentials of the corresponding Nuvlabox in the
SlipStream's user profile.  Please follow "Accounts" section of the
:doc:`SlipStream Prerequisites </tutorials/ss/prerequisites>` to
achieve this.

Deploying Applications
----------------------

The preferred way to manage applications on NuvlaBox is through
SlipStream.  There is no difference between deploying applications on
clouds or the NuvlaBox when using SlipStream.  Please follow
:doc:`SlipStream Module III </tutorials/ss/module-3>` of the
SlipStream tutorial to learn how to create, deploy and manage your
applications on a NuvlaBox.

Accessing VMs
-------------

Use an SSH client to connect to your VM by using default SSH ``port
22`` and by using the ``displayed IP`` in your deployment on
SlipStream.
