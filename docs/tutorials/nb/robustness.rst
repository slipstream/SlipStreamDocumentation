Robustness
==========

Goals
-----

- Security
 
  - All communication with the box are encrypted
  - Only needed port should be exposed
  - Default credentials for each box is different from another

- Privacy

  - It's all yours, keep your data within your network

- Connectivity

  - Try hard to keep and restore networking when plugged to a network
  - When NuvlaBox is connected to the Internet, it would try to connect to remote SlipStream
   
- Resiliency

  - If a power cut occur, NuvlaBox try to restore existing VMs when power is restored
  - To avoid system performance deterioration, all non necessary system data are erased at each reboot
  - Firmware persist only some configuration files, logs and used services databases. System corruption after a power cut is thereby limited
  - Watchdog is configured to restart the system in case of kernel crash

