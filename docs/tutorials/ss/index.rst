
.. include:: ../global.rst

SlipStream Tutorial
===================

This hands-on tutorial demonstrates the core features of SlipStream by
building a number of example applications through a series of exercises.  The
tutorial shows how SlipStream:

 - Abstracts away differences between clouds, making **cloud portability**
   possible,
 - Speeds application development by **promoting reuse** of parameterized
   application components,
 - Ensures **consistent, fast, and error-free deployment** of
   applications through automation,
 - Coordinates the configuration of an application's component
   services to ensure **reliable initialization**,
 - Improves reliability through geo-redundant services in
   **multi-cloud deployments**,
 - Provides **universal access** through a web-base UI, command line
   interface, and a REST API, and
 - Optimizes resource use though **horizontal and vertical scaling**.

The tutorial is divided into a number of modules that treat specific
topics (see `Table of Contents`_).  The first two provide an overview
of the cloud ecosystem and SlipStream concepts.  These provide a good
foundation for understanding the core SlipStream functionality that is
presented in Module III.  The subsequent modules treat more advanced
topics and can be followed in any order.

The exercises provided in the tutorial build on one another starting
from a simple, single machine web server and ending with an
auto-scalable distributed multi-component application. Solutions to
the exercises can be found on Nuvla.

.. _module-1:

Module I - Overview of Cloud and SlipStream (Basic)
---------------------------------------------------

To get an overview of cloud technology and SlipStream, we recommend
reading the following sections. They provide a high-level view on the
technologies and how different users can benefit from them.

 - `What is SlipStream <slipstream-defined.html>`_
 - `Cloud Technology <cloud-technology.html>`_
 - `SlipStream Ecosystem <slipstream-ecosystem.html>`_
 - `Key Concepts <key-concepts.html>`_

These sections do not contain any exercises and can be read without
needing access to a SlipStream server.

Once you understand the technologies and key concepts, follow
:ref:`Module II <module-2>` that provides a tour of the SlipStream
cloud application management platform.

.. _module-2:

Module II - SlipStream Web Interface Tour (Basic)
-------------------------------------------------

This module lists the prerequisites for working with SlipStream and
then guides you through the core features via the embedded SlipStream
tour.  As part of this tour, you will deploy your first application on
a cloud with SlipStream.  You will also learn to view and edit your
user profile, allowing you to set important parameters and provide
credentials for the cloud infrastructures you want to use.

This module presumes familiarity with cloud technologies and the key
concepts of SlipStream.  Review :ref:`Module I <module-1>` if this is
not the case.

 - `Prerequisites <prerequisites.html>`_
 - `Web Interface Tour <web-interface-tour.html>`_
 - `User Profile <user-profile.html>`_

In this module you've acquired enough knowledge about SlipStream and
its basic capabilities.  After working through this module, you will
be ready to proceed to :ref:`Module III <module-3>`, where you will
learn how to build, deploy, and manage your own applications with
SlipStream on multiple clouds.

.. _module-3:

Module III - Creating, Deploying, and Managing Cloud Applications (Basic)
-------------------------------------------------------------------------

This module provides detailed information about the creation,
deployment and management of applications.  Once you've completed it,
you'll be able to build, deploy, and share your own applications on
clouds of your choice.

This module builds on the knowledge acquired about Slipstream in the
previous module :ref:`Module II <module-2>`. Your user profile must
contain credentials for at least one cloud.  If necessary, review the
`Prerequisites <prerequisites.html>`_ from the previous module.

 - `Workspace <workspace.html>`_
 - `Images <images.html>`_
 - `Components Part I <components-1.html>`_
 - `Components Part II <components-2.html>`_
 - `Applications <applications.html>`_

After finishing this module, building, deploying and managing cloud
applications should no longer be a problem for you, especially with
such a powerful tool as SlipStream in your DevOps_ tool belt.

You are now prepared for the remaining advanced modules.  Choose those
that interest you.  See :ref:`Module IV <module-4>` for (auto-)scaling
your cloud applications or :ref:`Module V <module-5>` for interacting
with SlipStream via its API and optimizing your deployments.

.. _module-4:

Module IV - Scalable Applications (Advanced)
--------------------------------------------

In this module you will learn how to: deploy an application that can
be scaled horizontally and vertically; scale an application through
the API; respond to resource changes to update configurations; and
automate the scaling process.

The module requires a good knowledge of the core application creation
and management features of SlipStream.  If necessary, review the
material in :ref:`Module III <module-3>`.

 - `Scalable Applications <scalable-applications.html>`_
 - `Autoscalable Applications <autoscalable-applications.html>`_

From here you may want to learn more about SlipStream automation,
application optimization, and debugging in :ref:`Module V <module-5>`.

.. _module-5:

Module V - Automation and Optimization (Advanced)
-------------------------------------------------

Instead of working with SlipStream via web browser interface, you may
want to use the SlipStream Command Line Interface (CLI) or the
SlipStream REST API. These are useful for scripting or interacting
with SlipStream via another service.

This module provides an overview of **SlipStream API** and
demonstrates how to authenticate with SlipStream and manage the full
lifecycle of applications.  The module also covers the SlipStream
**build image** feature, which optimizes application deployments by
minimizing start up latencies.

Cloud applications, like all things in the universe, break or go
wrong. See the section on **debugging of applications** to understand
how to troubleshoot problems efficiently.

 - `Automating SlipStream <automating-slipstream.html>`_
 - `Debugging Applications <debugging.html>`_.
 - `Faster Deployments (Build image) <faster-deployment.html>`_.

If you've not done so already, you might want to follow :ref:`Module
IV <module-4>` to learn about scalable applications.

Finish Line
-----------

If you've worked through all the modules, you've acquired all the
skills required to build, deploy and manage your own multi-cloud
applications independently.  With SlipStream_ you can do all of this
without needing to understand the differences between cloud services;
they are just interchangable resources you can use to get your job
done.

Table of Contents
-----------------

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
