Getting Started
===============

Introduction
============

SlipStream™, by SixSq, is a framework for the automatic deployment and
testing of n-tier and distributed software systems. It makes extensive
use of cloud computing technologies to provide dynamic near-production
environments for realistic runtime creation of systems, permitting
software stakeholders to assert their ability to release the software
into production on a continuous basis. SlipStream™ relies on
virtualization for deploying machines and uses a cloud computing
back-end to manage the life-cycle of virtual images. SlipStream™ can use
several cloud backends, simultaneously. Please refer to the SixSq
website for the list of supported clouds. For this tutorial, we assume
that you are using a [StratusLab](http://stratuslab.eu) cloud.
Therefore, if you are using a different cloud, the configuration
parameters might be slightly different. SlipStream will continue to
support more cloud back-ends, as needed and requested.

SlipStream™ is available as public [hosted
service](https://slipstream.sixsq.com), our hosted service supports a
number of clouds. Before you can successfully use these clouds, you will
need to have valid accounts with them.

This tutorial document is composed of several tutorials of increasing
complexity, designed to get you started on SlipStream™ as fast and
simply as possible. The first [Simple Client/Server
Tutorial](#chap-client-server) uses the Apache2 web server to
demonstrate a "hello world" of distributed system tests using
SlipStream™. In this first tutorial, we show you how to use existing
base images to create a deployment to test a simple client/server pair
running on two different virtual machines in the cloud.

Reusing the first tutorial, we then move to a slightly more complex
scenario where we show you how with a few button clicks the first
tutorial can be turned into a powerful performance system test. This
second case deploys several clients in parallel to show how to produce
increased load on the web server.

We execute the tutorials in this document daily to make sure that the
fundamentals of these tutorials are sound. However, if you experience
problems going through these tutorials, you'll find a special appendix
to this document with troubleshooting tips. If you think that any of
these tutorials are not clear, confusing, missing insights or could
simply be made better, please help us improving them by sending your
feedback to <support@sixsq.com>.

Tutorial Solutions
==================

You can find the solutions to the SlipStream™ tutorials on the server in
the `Public/Tutorials` project area. All of the required projects are
publicly readable, you therefore only need a standard SlipStream™
account to view them.

Key Concepts
============

Before we start the tutorial, here are a few important SlipStream™
concepts that will come up often. SlipStream™ is accessed via a web
application. SixSq runs a public [SlipStream™ hosted
service](https://slipstream.sixsq.com/). Your organization may run it's
own SlipStream™ service; if so, contact your administrator to find the
address of the server. If you have your own SlipStream™ instance and you
want to use it for this tutorial, please make sure that your instance of
SlipStream™ includes the Tutorial SlipStream™ Projects, which ships with
the product by default.

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

We also have three main workflows in SlipStream™: *Image Creation* and
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

Access Control
==============

Access control can be defined for each module in SlipStream™. Further,
three levels of control are available: *User*, *Group* and *Public*. For
each level, different actions can be granted (e.g. read, execute).
Groups are dynamically defined, as a simple list of users and can be
inherited.

User Setup
==========

SlipStream™ is a secure web application requiring a personal account. To
register for an account, fill in the [registration
form](https://slipstream.sixsq.com/register). Make sure you provide a
valid email address as it will be used to validate your account. Once
you've received the email, hit the confirmation link to activate your
account. From that point-on, you are good to go on SlipStream™.

To start with SlipStream™, on the welcome page, click on Start or the
Start button, or the login link at the top right of the screen. Once
logged in, go to you account. Once there, click the Edit button and
select the "Properties" tab. Each available cloud has a corresponding
section (see the comments next to the fields for guidance). Configure
each cloud section you plan to use and save changes. Now you should be
good to go!
