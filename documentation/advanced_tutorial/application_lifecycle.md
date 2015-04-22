---
Title: Application Lifecycle
---

# Application Lifecycle in Clouds

The lifecycle for applications running within a cloud infrastructure
is very similar to the lifecycle of an application running within a
traditional data center.  The lifecycle involves:

1. Defining application components in the form of virtual machine
   images
2. Creating application by bringing together the individual components
3. Deploying the application on one or more cloud infrastructures
4. Validating the application to ensure that all the components are
   working correctly
5. Managing the application by monitoring the service and changing the
   allocated resources in response to load 
6. Terminating the application when it is no longer needed

The only cloud-specific parts of the lifecycle involve the use of
virtual machines and a cloud service. 

SlipStream facilitates the full application lifecycle by automating
the processes, capturing knowledge about the application, and
fostering reuse of that knowledge.

# Porting Applications

Although nearly any application can be run on a cloud infrastructure,
taking full advantage of the cloud's benefits, particularly
elasticity, often requires some level of architectural changes.

For elasticity there are two categories of scaling actions:

  1. **Horizontal Scaling**: Either adding or removing machines from
     an application deployment to match the application's capacity to
     the current load.
  2. **Vertical Scaling**: Increasing the resources allocated to an
     individual machine (CPU, RAM, Disk) within an application to
     respond to peaks in the application's load.

The more flexible scaling strategy is the horizontal scaling, which
allows both scaling-up and scaling down.  As this only involves adding
or removing machines, it is supported by all cloud infrastructures.
However, this has a larger impact on the application's architecture.
The application must allow the dynamic addition/removal of machines
and must be able to share state between the machines in the
deployment. 

Vertical scaling has less of an impact on the application.  The
services run without modification in the machines allocated to the
application.  They simply see more resources within an individual
machine.  However, this is less flexible because those resources
cannot typically be removed once allocated.  Moreover, not all
operating systems and/or cloud services support vertical scaling. 

SlipStream fully supports horizontal scaling.  Support for vertical
scaling is planned but not yet available.