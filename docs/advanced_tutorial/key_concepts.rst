Key Concepts
============

There are a few key concepts that are important to understand so that
you can get the most out of the service.

Application Model
-----------------

Image: Encapsulates cloud-specific parameters such as number of CPU,
available RAM, and network security groups.  

<-- transformed into components via user-defined "recipes" or scripts --> 

Component: A parameterized, single-VM service that can be deployed
individually or as part of a more complex application. 

<-- bundled into applications, linking component parameters and
defining a topology --> 

Application: A complete service containing one or more individual
components.  Each component can have multiple instances and an
application can span cloud infrastructures. 


Vocabulary
----------

Image
    A virtual machine image that encapsulates cloud-specific
    information, such as image identifiers, sizes of a machine, and
    associated security groups.  The referenced, native images in each
    cloud are expected to be effectively identical.

Component
    A single virtual machine definition that references an Image and
    may contain scripts for the installation and configuration of
    additional services.  These components can be parameterized and
    can often be run as standalone applications. 

Application
    An application brings together one or more components into a
    coordinated deployment of cooperating virtual machines.  This
    allows complex (potentially multi-cloud) applications to be
    defined and managed as a single entity.

Project
    A "folder" that allows Image, Component, and Application
    definitions to be organized hierarchically. 

Module
    A generic name for Image, Component, Application, and Project
    definitions.

Run
    A deployed (running) application or application component. A "run"
    encapsulates all of the runtime information of the application and
    acts as a resource by which the application is managed.


Finding Your Way Around
-----------------------

Metadata about your images and deployments are organized into projects
in SlipStream. Each project consists of a number of modules. The modules
may be *Project*, *Machine Image* or *Deployment* modules:

Project
    A container of modules used to provide logical grouping. A project
    may contain other projects allowing a hierarchical organization for
    large projects.
Machine image
    A module that contains information about a virtual machine image.
    One type of machine image is a *native image*. These contain a
    cloud-specific identifier for a particular cloud infrastructure. The
    other type of machine image, a *reference image*, references another
    image (which can be a native image or another reverence image) and
    includes a list of packages to install and/or recipes to configure
    the machine. These modules also include input/output parameters such
    that the machine can be synchronized as part of a deployment.
Deployment
    A module that describes a coordinated deployment of one or more
    nodes. The deployment associates a machine image to each node and
    defines the synchronizaton necessary for the coordinated deployment.

The web interface allows the parameters for each of these modules to be
defined, edited, versioned and saved.

Versioning
----------

The full history of all modules is always saved in the SlipStream
server. Each modified module has a unique version number allowing you to
deploy a specific version of a module or the latest.

Published modules always refer to a specific version of the module.

Workflows
---------

We also have two main workflows in SlipStream: *Deployment* and *Image
Creation*. Here is a short explanation of what they are:

Deployment Execution (or Run)
    The combined deployment of several machines, including the automatic
    synchronization of the machines' services. Essentially a "one-click"
    automated deployment of complex services.
Image Creation
    Builds an enhanced and customized machine image ("reference image")
    at the cloud service level, which can be then be a component in
    service deployments. SlipStream instantiates a virtual machine from
    a reference image, adds software packages, configures services, and
    then saves the new image for reuse.

For convenience, it is also possible to run a single image, without
deployment support. This is handy when you quickly want a new virtual
machine for interactive development.

