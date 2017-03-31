How to attach sensors
=====================

Edit the image in SlipStream and add an `Additional custom tesxtual VM template`:

In the following example, we have added the most common USB controllers on which we attach the usb devce.
For USB 2.0 or 3.0 devices, use the following template to attach it to your virtual machine.
You should only update the ``vendo id`` value and the ``product id`` with values corresponding to your device.

.. code:: xml

   RAW = [ TYPE = "kvm", 
           DATA = "<devices> <controller type='usb' index='1' model='piix3-uhci'/> <hostdev mode='subsystem' type='usb' managed='yes'> <source> <vendor id='0x046d'/> <product id='0x0826'/> </source> <address type='usb' bus='0' port='1'/> </hostdev> </devices>"
         ]

.. HINT::
   In NuvlaBox admin UI, you can easily get ``vendor id`` and ``product id`` of attached devices.

To attach other host devices, please refer to `libvirt documentation`_.


.. _libvirt documentation: https://libvirt.org/formatdomain.html#elementsHostDev