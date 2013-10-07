# Key Concepts

SlipStream™ is a web application that can be accessed easily from any
modern browser.  SixSq runs a public [SlipStream™ hosted
service](https://slipstream.sixsq.com/) but you may also have access
to another SlipStream™ server run your organization.  If so, contact
your local administrator for the server's address.

## Finding Your Way Around

Metadata about your images and deployments are organized into projects
in SlipStream™. Each project consists of a number of modules. The
modules may be *Project*, *Machine Image* or *Deployment* modules. Here
is a short description of these module types:

Project
:   A container of modules used to provide logical grouping. A project
    may contain other projects allowing a hierarchical organization for
    large projects.

Machine image
:   A module that contains information about machine images, including
    cloud specific unique identifier and/or recipes to create the
    machine image. The recipe information consists of a set of packages
    to install and a script for configuring the machine. Unique
    identifiers are specific to the corresponding cloud they belong to.
    This module also includes input/output parameters such that the
    machine can be synchronized as part of a deployment.

Deployment
:   A module that describes nodes to which machine images are
    associated, as well as synchronization and coordination between
    these.

The web interface allows the parameters for each of these modules to be
defined, edited, versioned and saved.

## Workflows

We also have two main workflows in SlipStream™: *Image Creation* and
*Deployment*. Here is a short explanation of what they are:

Image Creation
:   Creation of a new machine image at the cloud service level, such
    that it can be reused in deployments. This means that SlipStream™
    instantiates a reference (i.e. already existing) image, from which
    it will add software and configuration, before saving it as a new
    image for further reuse.

Deployment Execution (or Run)
:   Deployment of several machines together, synchronizing their setup
    such that the software in each machine fires in the right order,
    automatically.

It is also possible to run a single image, without deployment support,
for convenience.

These terms will be referred to throughout this document.

## Access Control

Access control can be defined for each module in SlipStream™. Further,
three levels of control are available: *User*, *Group* and *Public*. For
each level, different actions can be granted (e.g. read, execute).
Groups are dynamically defined, as a simple list of users and can be
inherited.
