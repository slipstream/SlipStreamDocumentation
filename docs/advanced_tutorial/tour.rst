Tour
====



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
