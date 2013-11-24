# Key Concepts

SlipStream™ is a web application that can be accessed easily from any
modern browser.  SixSq runs a public [SlipStream™ hosted
service](https://slipstream.sixsq.com/) but you may also have access
to another SlipStream™ server run by your organization.  If so,
contact your local administrator for the server's address.

## Finding Your Way Around

Metadata about your images and deployments are organized into projects
in SlipStream™. Each project consists of a number of modules. The
modules may be _Project_, _Machine Image_ or _Deployment_ modules:

Project
:   A container of modules used to provide logical grouping. A project
    may contain other projects allowing a hierarchical organization for
    large projects.

Machine image
:   A module that contains information about a virtual machine image.
    One type of machine image is a _native image_.  These contain a
    cloud-specific identifier for a particular cloud
    infrastructure. The other type of machine image, a _derived
    image_, references another image (which can be a native image or
    another derived image) and includes a list of packages to install
    and/or recipes to configure the machine.  These modules also
    include input/output parameters such that the machine can be
    synchronized as part of a deployment.

Deployment
:   A module that describes a coordinated deployment of one or more
    nodes.  The deployment associates a machine image to each node and
    defines the synchronizaton necessary for the coordinated
    deployment.

The web interface allows the parameters for each of these modules to be
defined, edited, versioned and saved.

## Workflows

We also have two main workflows in SlipStream™: *Image Creation* and
*Deployment*. Here is a short explanation of what they are:

Image Creation
:   Builds an enhanced and customized machine image ("derived image") at
    the cloud service level, which can be then be a component in
    service deployments. SlipStream™ instantiates a virtual machine
    from a reference image, adds software packages, configures
    services, and then saves the new image for reuse.

Deployment Execution (or Run)

:   The combined deployment of several machines, including the
    automatic synchronization of the machines' services.  Essentially
    a "one-click" automated deployment of complex services.

For convenience, it is also possible to run a single image, without
deployment support.  This is handy when you quickly want a new virtual
machine for interactive development.

## Access Control

SlipStream™ has a consistent access control model for all of the
modules.  Access control can be defined separately for the *User*,
*Group* and *Public* levels.  For each, different permissions for
module actions can be granted (e.g. read, execute).

Groups are dynamically defined, as a simple list of SlipStream™ users.
These groups can be inherited from a parent module or defined manually
for each module.
