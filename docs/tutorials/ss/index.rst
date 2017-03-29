
SlipStream Tutorial
===================

This hands-on training course demonstrates the core features of SlipStream by
building a number of example applications through a series of exercises.  The
tutorial will show how SlipStream:

 - Abstracts away differences between clouds, making **cloud portability**
   possible: `What is SlipStream? <slipstream-defined.html>`_, `Key Concepts
   <key-concepts.html>`_.
 - Speeds application development by **promoting reuse** of parameterized
   application components: `Components Part I <components-1.html>`_,
   `Components Part II <components-2.html>`_
 - Ensures **consistent, fast, and error-free deployment** of
   applications through automation,
 - Coordinates the configuration of an application's component
   services to ensure **reliable initialization**,
 - Improves reliability through geo-redundant services in
   **multi-cloud deployments**,
 - Provides **universal access** through a web-base UI, command line
   interface, and a REST API, and
 - Optimizes resource use though **horizontal and vertical scaling**.

The tutorial starts with a short description of the cloud ecosystem
and SlipStream's place within it.  It then describes the prerequisites
for following the tutorial before jumping into the development of the
example applications.

.. As the exercises build on one another, readers will want to follow the
   tutorial in order.


Module I - `Overview of Cloud and SlipStream`
---------------------------------------------

To get an overview of Cloud technology and SlipStream we recommend reading
the following sections. They don't include any exercises and provide high level
view on the technologies and their usage by different types of users.

 - `Cloud Technology <cloud-technology.html>`_
 - `SlipStream Ecosystem <slipstream-ecosystem.html>`_
 - `Key Concepts <key-concepts.html>`_

Module II - `SlipStream Web Interface Tour and User Profile.`
-------------------------------------------------------------

You'll be presented with prerequisites for using SlipStream and acquire the
first experience of working with it by going through the online guided tour of
SlipStream in SlipStream itself.  You'll be guided through most all the parts
of SlipStream and explained how to use them, and as part of it, you will deploy
your first application on Cloud with SlipStream.  Also, you'll get an overview
of the User Profile.  This module assumes you are familiar with Cloud
technologies and the key concepts of SlipStream.  If not, then Module I can
help you with this.

 - `Prerequiseites <prerequisites.html>`_
 - `Web Interface Tour <web-interface-tour.html>`_
 - `User Profile <user-profile.html>`_
 - `Multi-tier Demo Application - LAMP <lamp-demo.html>`_. Optional. Advanced.
   Deploy multi-tier demo application. Check its topology on Run page. Go
   through exercises around the application.

Module III - `Building, Deploying and Managing Applications with SlipStream`
----------------------------------------------------------------------------

This module goes in depth about creation, deployment and management of
applications.  After passing it you'll be able to build, share and deploy your
own applications of different complexity on clouds of your choice.  The mode
builds on the knowledge acquired about Slipstream in the main sections of the
Module II. It assumes that your User Profile is configured with at least one
Cloud (see `Prerequiseites <prerequisites.html>`_ in Module II).

 - `Workspace <workspace.html>`_
 - `Images <images.html>`_
 - `Components Part I <components-1.html>`_
 - `Debugging <debugging.html>`_
 - `Components Part II <components-2.html>`_
 - `Applications <applications.html>`_
 - `Faster Deployments (Build image) <faster-deployment.html>`_.  Optional.
   Advanced.  Building your own images to speedup application deployment
   process.

Module IV - `Advanced topics: Scalable Applications`
----------------------------------------------------

In this module you will learn how to: deploy an application that can be scaled
horizontally and vertically; scale the application through the API; respond to
resource changes to update configurations; automate the scaling process by
using auto scaling approach available in SlipStream.  The module requires a good
knowledge of application development and management with SlipStream, which one
can obtain by going through Module III (and its prerequisites).

 - `Scalable Applications <scalable-applications.html>`_
 - `Autoscalable Applications <autoscalable-applications.html>`_

Module V - `Advanced topics: Automation and Optimization`
---------------------------------------------------------

Working with SlipStream via SlipStream CLI or directly with its API via pure
REST calls.  This module gives an overview of SlipStream API and shows for
example how to authenticate with SlipStream, start and terminate applications.
It gives references to SlipStream API documentation to other actions available
through the API.  The module as well covers SlipStream **build image** feature,
which provides optimization of deployments.

 - `Automating SlipStream <automating-slipstream.html>`_
 - `Faster Deployments (Build image) <faster-deployment.html>`_.

.. important::

   The command line examples throughout the tutorial use Linux bash
   syntax.  If you're using a different shell (csh, PowerShell, etc.),
   you'll need to adjust the syntax accordingly.

   Similarly, the example applications developed in the tutorial are
   uniformly built over the Ubuntu operating system.  This is to
   reduce distractions and make the tutorial as uniform as possible.
   SlipStream supports a wide range of different operating systems,
   including Windows.

.. toctree::
   :maxdepth: 2

   slipstream-defined
   cloud-technology
   slipstream-ecosystem
   key-concepts
   prerequisites
   web-interface-tour
   user-profile
   lamp-demo
   workspace
   images
   components-1
   debugging
   components-2
   applications
   automating-slipstream
   scalable-applications
   autoscalable-applications
   faster-deployment
   roadmap
   appendix
