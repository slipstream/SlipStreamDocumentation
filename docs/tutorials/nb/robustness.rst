Robustness
==========

After a power cut, the NB should restart if configured in bios to last state. Existing VMs should be restarted after the reboot.
Firmware is read-only filesystem, just configuration files, logs and databases of services OpenNebula and SlipStream are persisted.
Watchdog should make the NuvlaBox restart if there is a kernel crash.
