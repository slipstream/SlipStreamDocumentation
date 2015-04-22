---
title: SlipStream Overview
---

Although cloud technologies provide real benefits to their users, they
can also pose challenges.  At the IaaS level for instance:

 - Cloud service providers use a variety of incompatible APIs
 - Virtual machine configurations are opaque making it hard to
   understand the actual state of an application
 - Users must manage individual virtual machines rather than an
   application as a whole which is tedious and error-prone

SlipStream is designed to overcome these challenges to make the
management of cloud applications easier.

- SlipStream is a **Multi-cloud Application Management Platform**.
- SlipStream remains **neutral** with respect to different cloud
  infrastructures.
- SlipStream captures **application knowledge** and **manages
  changes**.
- SlipStream permits optimization of applications through **VM
  placement**, **minimizing start-up latencies**, and **resource
  scaling**.

# Users and Benefits

A number of different types of people within an organization can
benefit from SlipStream.  We're created personas to describe those
people and how they benefit.

| ![alice]  | Alice is busy working on different projects.  She needs IT applications and resources, but has little patience for IT related issues.  She benefits from the SlipStream App Store where she can start the applications she needs with one click. |
| ![bob]    | Bob manages a number of workers taking advantage of cloud resources.  He wants an overview of their use of those resources to understand costs and their evolving needs.  SlipStream provides the ability to monitor resource utilization. |
| ![clara]  | Clara develops cloud applications for people within her organization.  She benefits from SlipStream be creating a rich catalog of services that can be automatically and reliably deployed. |
| ![dave]   | Dave manages the SlipStream installation.  He's able to integrate his own cloud infrastructure into SlipStream and control what external cloud resources are available to his users.  |

# Interacting with SlipStream

This tutorial focuses primarily on "Clara", showing how applications
can be brought into SlipStream and made available to the "Alices" in
her organization.

Most of the time, the SlipStream users will interact with the service
through the web browser interface.  This provides a graphical view of
the user's applications and makes it easy to control those
applications. 

However the core of SlipStream is its REST API.  SlipStream and its
API are resource-oriented and uses the standard HTTP verbs to
implement SCRUD (search, create, read, update, delete) actions for
those resources.  The REST API exposes the complete functionality of
the service and in fact, the web browser interface is built on top of
the API.

Clara may use the REST API directly to incorporate SlipStream in the
deployment and operation processes of the organization or to add or
remove machines from a running application. 

![ss-blocks]

# SlipStream Deployments

This tutorial uses the [SlipStream SaaS][saas], a SlipStream instance
operated by SixSq and free to use.  Individuals and organizations can
use this service to manage their applications on a large number of
supported cloud services.

SlipStream can also be installed on-premise allowing more control over
what clouds are available to an organization's users and permitting
access to its own private cloud infrastructures.  The organization
purchases a subscription or perpetual license and runs the service. 

Managed on-premise installations are also possible, where the
SlipStream service is deployed and maintained by SixSq, but is running
on a customer's IT infrastructure.


[alice]: media/alice.png
[bob]: media/bob.png
[clara]: media/clara.png
[dave]: media/dave.png

[ss-blocks]: media/slipstream-deployment-blocks.png

[saas]: https://slipstream.sixsq.com