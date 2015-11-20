Optimizing Applications
=======================

Being able to build an image allows the installation steps to be done
only once and reduces the startup latency for the image and application.

This should only be considered as a optimization after the deployment is
debugged and working because:

-  Building an image can take a significant amount of time (20+ minutes)
-  Not all clouds support user-generated images
-  Some clouds require additional configuration to share the generated
   images with others

On the other hand the additional effort can significantly speed the
application deployment for frequently deployed applications, improving
the customer's experience and reducing their costs.

Reducing Startup Latencies
--------------------------

TO BE COMPLETED!!!

Trouble Points
--------------

TO BE COMPLETED!!!

 - Persistent network configuration
 - Privacy, credential leakage
 - Kernel upgrades
 - Consistency between clouds with and without user images
   - "duplicated" updates between scripts
   - rebooting for kernel updates

.. admonition:: EXERCISES

   1. Optimize an image and verify that it works the same on both clouds.
   2. Create a data appliance.

