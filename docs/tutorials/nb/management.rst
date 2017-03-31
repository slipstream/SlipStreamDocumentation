Manageability
=============

Configuration of the NuvlaBox
-----------------------------

An administration UI is available and accessible from the local SlipStream.
To access it, login with "super" account in local SlipStream, click on **Configuration** in the menubar and choose **NuvlaBox**.

Available actions in NuvlaBox UI admin:

- System activity (CPU usage, RAM usage, partition usage)
- USB status. This is the listing of plugged USB devices in the NuvlaBox.
- Remote SSH SlipStream tunnel settings
- Network configuration (WAN, LAN, WLAN)
- System actions (restart, poweroff or Factory reset)

All this actions are also available from the NuvlaBox console by using a CLI tool named ``nuvlabox-admin``.


Updating a NuvlaBox
--------------------

Using a USB key with last version, or by using a migration script.
An update through the admin UI should be possible check the roadmap.

Installation from Scratch
-------------------------

There is 2 different way to install NuvlaBox:
   
- Flash directly NuvlaBox firmware through USB key (Hardware specific)
- Install scripts (Hardware generic)

Flash NuvlaBox Firmware
```````````````````````
If you have a NuvlaBox USB flash key for your specific NuvlaBox, you need a screen and a keyboard to be able to flash your NuvlaBox. 

.. HINT::
   There is a contextualization file in the USB key, which contain specific credentials for your box (private key, WiFi password, etc.).

Here is the procedure to boot on a USB key:

* Start the NuvlaBox
* Enter bios boot device menu selection. You have to quickly hit following key until the menu appear:
   
   * Hit <F11> key for NuvlaBox Standard v2 
   * Hit <F7> key for NuvlaBox Mini v2
* Choose USB key in the list to boot from it
* Follow instruction on screen

The flash of the firmware should take about 10 minutes.

NuvlaBox will reboot 3 times after the end of installation:

* 1st reboot - End of firmware installation
* 2nd reboot - Configuration of the system in concordance with your hardware

  * Notice the update of the CLI prompt => nuvlabox
* 3rd reboot - Contextualization of your NuvlaBox with appropriate credentials 

  * Notice the update of the CLI prompt => nuvlabox-<nobel-prize-name>

Your NuvlaBox is now ready to be used. Remove the flash USB key.

Install Scripts
```````````````
Contact SixSq if you are interested in installing NuvlaBox Firmware on specific hardware.
This is often the case when you need a more powerfull NuvlaBox which is able to run more than 8 VMs.

