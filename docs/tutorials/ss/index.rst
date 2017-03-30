
.. include:: ../global.rst

SlipStream Tutorial
===================

This hands-on tutorial demonstrates the core features of SlipStream by
building a number of example applications through a series of exercises.  The
tutorial will show how SlipStream:

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

The tutorial starts with a short description of the cloud ecosystem
and SlipStream's place within it.  It then describes the prerequisites
for following the tutorial before jumping into the development of the
example applications.

The tutorial consists of five modules. One of the options is to follow them in
order (see `Table of Contents`_).  The exercises provided in the tutorial build
on one another starting from a simple single machine web server and ending with
an auto-scalable distributed multi-component application.  However, if you are
familiar with Cloud technologies and had already used SlipStream, the
modularization allows you to enter the tutorial at the desired level / topics.

.. _module-1:

Module I - Overview of Cloud and SlipStream
-------------------------------------------

To get an overview of Cloud technology and SlipStream we recommend reading
the following sections. They don't include any exercises and provide high level
view on the technologies and their usage by different types of users.

 - `Cloud Technology <cloud-technology.html>`_
 - `SlipStream Ecosystem <slipstream-ecosystem.html>`_
 - `Key Concepts <key-concepts.html>`_

After you've got an overview of Cloud technology, SlipStream and key
concepts around it, the next module to take is :ref:`Module II <module-2>`.

.. _module-2:

Module II - SlipStream Web Interface Tour
-----------------------------------------

You will be presented with prerequisites for using SlipStream and acquire the
first experience of working with it by going through the online guided tour of
SlipStream in SlipStream itself.  You'll be guided through most all the parts
of SlipStream and explained how to use them, and as part of it, you will deploy
your first application on Cloud with SlipStream.  Also, you'll get an overview
of the User Profile.  This module assumes you are familiar with Cloud
technologies and the key concepts of SlipStream.  If not, then :ref:`Module I
<module-1>` can help you with this.

 - `Prerequiseites <prerequisites.html>`_
 - `Web Interface Tour <web-interface-tour.html>`_
 - `User Profile <user-profile.html>`_
 - `Multi-tier Demo Application - LAMP <lamp-demo.html>`_. Optional. Advanced.
   Deploy multi-tier demo application. Check its topology on Run page. Go
   through exercises around the application runtime.

In this module you've acquired enough knowledge about SlipStream and its basic
capabilities.  Now you are ready to proceed to :ref:`Module III <module-3>`,
where you will learn how to build, deploy and manager your own applications
with SlipStream on multiple clouds.

.. _module-3:

Module III - Building, Deploying and Managing Applications with SlipStream
--------------------------------------------------------------------------

This module goes in depth about creation, deployment and management of
applications.  After passing it you'll be able to build, share and deploy your
own applications of different complexity on clouds of your choice.  The mode
builds on the knowledge acquired about Slipstream in the main sections of the
:ref:`Module II <module-2>`. It assumes that your User Profile is configured
with at least one Cloud (see `Prerequiseites <prerequisites.html>`_ in
:ref:`Module II <module-2>`).

 - `Workspace <workspace.html>`_
 - `Images <images.html>`_
 - `Components Part I <components-1.html>`_
 - `Components Part II <components-2.html>`_
 - `Applications <applications.html>`_
 - `Debugging <debugging.html>`_.  Optional. Advanced. Part of :ref:`Module V
   <module-5>`.
 - `Faster Deployments (Build image) <faster-deployment.html>`_.  Optional.
   Advanced.  Building your own images to speedup application deployment
   process.  Part of :ref:`Module V <module-5>`.

From now on, building, deploying and managing Cloud applications should no
longer be a problem for you, especially when you have such powerful tool as
SlipStream in your DevOps_ tool belt.  Now you can proceed to advanced topics
in modules :ref:`Module IV <module-4>` and :ref:`Module V <module-5>`.  They
will teach you now to (auto-)scale your cloud applications (:ref:`Module IV
<module-4>`), automate your interaction with SlipStream via its API and better
optimize your deployments via building your own application images on clouds
(:ref:`Module V <module-5>`).

.. _module-4:

Module IV - Advanced topics: Scalable Applications
--------------------------------------------------

In this module you will learn how to: deploy an application that can be scaled
horizontally and vertically; scale the application through the API; respond to
resource changes to update configurations; automate the scaling process by
using auto scaling approach available in SlipStream.  The module requires a
good knowledge of application development and management with SlipStream, which
one can obtain by going through :ref:`Module III <module-3>` (and its
prerequisites).

 - `Scalable Applications <scalable-applications.html>`_
 - `Autoscalable Applications <autoscalable-applications.html>`_

Discover more interesting and advanced stuff in :ref:`Module V <module-5>`
around SlipStream automation and application deployment optimization and
troubleshooting .

.. _module-5:

Module V - Advanced topics: Automation and Optimization
-------------------------------------------------------

Working with SlipStream via SlipStream CLI or directly with its API via pure
REST calls.  This module gives an overview of **SlipStream API** and shows for
example how to authenticate with SlipStream, start and terminate applications.
It gives references to SlipStream API documentation to other actions available
through the API.  The module as well covers SlipStream **build image** feature,
which provides optimization of deployments.  While developing or running your
applications things can go wrong, see the section on **debugging of
applications** to gain an experience in using SlipStream tools on
troubleshooting your applications and fixing issues in your deployment scripts.

 - `Automating SlipStream <automating-slipstream.html>`_
 - `Debugging Applications <debugging.html>`_.
 - `Faster Deployments (Build image) <faster-deployment.html>`_.

This 5th module is the last one in the series of teaching modules about
SlipStream.  If you passed all the sections in all the modules, you've mastered
everything required to independently build, deploy and manage your own multi
Cloud portable applications on virtually any Cloud.  And all this -- thanks to
SlipStream_ -- without needing to know much about Clouds and especially write
any code to interact with them -- they are just *somewhere there* to run your
applications for you.

.. important::

   The command line examples throughout the tutorial use Linux bash
   syntax.  If you're using a different shell (csh, PowerShell, etc.),
   you'll need to adjust the syntax accordingly.

   Similarly, the example applications developed in the tutorial are
   uniformly built over the Ubuntu operating system.  This is to
   reduce distractions and make the tutorial as uniform as possible.
   SlipStream supports a wide range of different operating systems,
   including Windows.

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
