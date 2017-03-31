Connection to a remote SlipStream
=================================

NuvlaBox connect to remote SlipStream (mothership) by using SSH tunneling. 
When an Internet access is available, the NuvlaBox try to contact the remote SlipStream and register in it.
You can check if your NuvlaBox is connected in the remote SlipStream by checking the status of the box in the corresponding gauges in the dashboard.

.. figure:: images/gauges-nb-states.png
   :scale: 50 %
   :align: center

   Gauges of a NuvlaBox when disconnected vs when connected

From remote SlipStream, a remote tunnels ports are opened and allow remote SlipStream to access NuvlaBox endpoints:

- SlipStream
- OpenNebula
- SSH

.. NOTE:: Contact SixSq if you are interested in installing your own on permise remote SlipStream

.. HINT:: Check how to change to remote SlipStream in NuvlaBox Admin UI

By default the SSH tunnel to the remote SlipStream is enabled. 
You can disable it from the NuvlaBox Admin UI or from the NuvlaBox console.

Run following commands from the console of the NuvlaBox to disable SSH tunneling to remote SlipStream:

.. code:: bash
   
   systemctl stop nuvlabox-ssh-tunnel.service
   systemctl disable nuvlabox-ssh-tunnel.service

The username and host to use for the tunnels can be configured in the
following file ``/etc/default/nuvlabox-tunnels``. 
The most likely parameters to be needed are HOST and remote ports to use.