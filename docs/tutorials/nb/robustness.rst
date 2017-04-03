Reliability & Security
======================

The NuvlaBox software has been designed to make the machines as
reliable and secure as possible, while keeping the flexibility and
remote management features of cloud technologies.

- Security
 
  - All communications with the NuvlaBox are encrypted
  - Only needed ports are exposed over the local and wide area
    networks
  - Default credentials are unique for each NuvlaBox

- Privacy

  - The NuvlaBox lets you keep your data within your network, making
    maintaining privacy and confidentiality easier

- Connectivity

  - The NuvlaBox offers many ways to connect to the local or wide area
    network
  - Multiple layers try hard to maintain network connectivity once
    established
  - When the NuvlaBox is connected to the Internet, it tries to
    connect to a remove SlipStream instance to allow for remote
    operation 
   
- Resiliency

  - In the case of a power outage, the NuvlaBox will restore existing
    VMs when power is restored
  - To ensure consistency and to avoid system performance
    deterioration, all unnecessary system data are erased at each
    reboot; VM data and user configurations are maintained across
    reboots 
  - The firmware persists only some configuration files, logs, and
    services databases. The possibility of system corruption after a
    power cut is extremely small.
  - A watchdog is configured to restart the system in case of kernel
    crash, ensuring high availability of the system

