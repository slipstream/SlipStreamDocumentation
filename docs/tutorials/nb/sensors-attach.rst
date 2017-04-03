How to attach sensors
=====================

To attach a sensor, you have to edit your component in SlipStream and add an
`Additional custom textual VM template`.  Anything placed in this field is
transmited unmodified to KVM hypervisor.

First of all, we need to add a USB controller, on which we attach the USB
device.  To do so, for USB 2.0 or USB 3.0 devices, use the following template
to attach your device to your virtual machine at startup.

You should only update the ``vendo id`` value and the ``product id`` with
values corresponding to your device.

.. code:: xml

   RAW = [ TYPE = "kvm",
           DATA = "
           <devices>
             <controller type='usb' index='1' model='piix3-uhci'/>
             <hostdev mode='subsystem' type='usb' managed='yes'>
               <source>
                 <vendor id='0x046d'/>
                 <product id='0x0826'/>
               </source>
               <address type='usb' bus='0' port='1'/>
             </hostdev>
           </devices>"]

.. HINT::
   In NuvlaBox admin UI, you can easily get ``vendor id`` and ``product id`` of
   attached devices.


.. WARNING::
   You have to attach specified devices in `Additional custom textual VM
   template` to your NuvlaBox, otherwise deployed concerned Virtual machine
   can't boot.


To attach other host devices, please refer to `libvirt documentation`_.

Other examples
--------------

SixSq is participating in an European Union’s Horizon 2020 project named
`SCISSOR`_.  The aim of this project is to designs a new generation SCADA
security monitoring framework.

.. figure:: images/scissor-architecture.png
   :scale: 80 %
   :align: center
   :alt: Credentials prospectus example

   Scissor 4 layers SCADA security monitoring framework

The edge computing in above figure are NuvlaBoxes. Till now following devices
have been connected to the NuvlaBox:

  - IP camera
  - USB microphone
  - Serial communication to exchange with RFIDs sensors
  - Network activity IDS analysers
  - Logging

.. _libvirt documentation: https://libvirt.org/formatdomain.html#elementsHostDev

.. _SCISSOR: https://scissor-project.com/
