How to attach sensors
=====================

Edit the image in SlipStream and add an `Additional custom tesxtual VM template`:

In the following example, we have added the most common USB controllers on which we attach the usb devce.
For USB 2.0 or USB 3.0 devices, use the following template to attach it to your virtual machine.
You should only update the ``vendo id`` value and the ``product id`` with values corresponding to your device.

.. code:: xml

   RAW = [ TYPE = "kvm", 
           DATA = "<devices> <controller type='usb' index='1' model='piix3-uhci'/> <hostdev mode='subsystem' type='usb' managed='yes'> <source> <vendor id='0x046d'/> <product id='0x0826'/> </source> <address type='usb' bus='0' port='1'/> </hostdev> </devices>"
         ]

.. HINT::
   In NuvlaBox admin UI, you can easily get ``vendor id`` and ``product id`` of attached devices.

To attach other host devices, please refer to `libvirt documentation`_.


SixSq is participating in an European Union’s Horizon 2020 project named `SCISSOR`_. 
The aim of this project is to designs a new generation SCADA security monitoring framework. 

.. figure:: images/scissor-architecture.png
   :scale: 80 %
   :align: center
   :alt: Credentials prospectus example

   Scissor 4 layers SCADA security monitoring framework

The edge computing in above figure are NuvlaBoxes. Till now following devices have been connected to the NuvlaBox:
  
  - IP camera
  - USB microphone
  - Serial communication to exchange with RFIDs sensors 
  - Network activity IDS analysers
  - Logging

.. _libvirt documentation: https://libvirt.org/formatdomain.html#elementsHostDev

.. _SCISSOR: https://scissor-project.com/ 