---
Title: Cloud Technology
head-title: SlipStream Advanced Tutorial&#58; Cloud Technology
---

Because of the hype surrounding cloud technologies, the term "cloud"
has been used to label and to sell a vast array of products that have
little or nothing to do with the "cloud".  This serves only to confuse
people about what features a cloud should have and how they could
benefit from a cloud.

To clarify things a bit, let's see how cloud technologies have emerged
from previous ideas and how to define typical jargon in the sector. 

# Cloud: An Emergent Technology

Cloud technologies bring together ideas and techniques that have
existing for quite some time, notably remote (networked) computing,
virtualization, and ease of access.

## Mature Virtualization Technologies

Virtualization of computing resources has existed for decades,
initially taking the form of software emulators with poor
computational performance and improving over the years.

In the past decade, virtualization techniques have been directly
integrated into mainstream operating systems and more importantly, the
support for these techniques has been added directly to all modern
CPUs.  The end result is that current virtualization techniques allow
segmentation of machine resources and customization of the running
operating system with a negligible impact on performance.

These mature machine virtualization technologies are widely available
from "hypervisors" provided by open source collaborations and major IT
software vendors alike.  They include KVM (RedHat), Xen (Citrix),
HyperV (Microsoft) and ESXi (VMware).  

However, virtualization is only one, critical component of a cloud.

## Simple, Universal APIs

Since machines have been networked together, there have been ways to
federate those machines (and their running services) into a larger
computing platform, with access to the federated or distributed
resources governed by an Application Programming Interface (API).

Examples of generic APIs include CORBA and Web Services (via WSDL and
co.).  These APIs and the associated computing platforms have been
adopted by industry, but are not popular with developers because of
their complexity and limited interoperability between different
implementations.

Recently there has been a backlash against such complex and
heavyweight APIs.  The current trend is towards Resource Oriented
Architectures and "REST" APIs that reuse the ubiquitous HTTP
protocol.  The result has been APIs with simple, uniform SCRUD
(Search, Create, Read, Update, Delete) actions for resources defined
by URLs.  Basing this on the HTTP protocol means that these simple
APIs are universally accessible from all programming languages.

The use of simple REST APIs for cloud services is the another key
component for the popularity of the cloud.

## Ubiquitous, Reliable Networking

Use of remote computing infrastructures for critical services is only
attractive when the clients of the services can reliably connect to
them.  Consequently, having a ubiquitous and reliable network
infrastructure is a prerequisite for the wide adoption of any remote
computing platform, the cloud included.

The current reality of phones, tablets, and computers connected by
cellular networks, wifi, and high-bandwidth, wired connections
provides universal, reliable, 24/7 access for the cloud.

## Bringing Them Together

Cloud technologies are the result of the marriage between mature
virtualization, reliable networking, and simple APIs.  The combination
enables cloud platforms to provide efficient, powerful computing
resources that consumers can access easily and reliably.

Cloud platforms provide resources that are more dynamic and more
flexible than has ever been possible before.  These are the core
benefits of a cloud platform.  Many cloud platforms also have
additional benefits:

  - Elasticity: the infrastructure is large enough that it contains
    essentially "infinite" resources compared to the need of any
    individual user. 
  - Pay-as-you-go: The dynamic nature of a cloud platform permits
    rapid provisioning, allowing billing to follow actual use of
    resources.  This shifts capital expenditures (CapEx) into
    operational expeditures (OpEx), especially attractive for small
    companies and individuals.
  - Multi-tenant: Cloud infrastructures can also reduce costs by
    allowing the resources to be shared between different users.
    These cost reductions may be passed onto the customer, making the
    cloud platform more attractive. 

In the end, cloud technologies combine some existing techniques and
ideas to create a platform that greatly benefits users in terms of
rapid provisioning and flexibility.

# Cloud Jargon

The preceding discussion has given no specifics concerning the type of
computing resources provided by the cloud or who are the customers of
those services.  Providing those specifics involves understanding some
of the jargon associated with the cloud.

The American standards institute ([NIST][nist]) provides [clear
definitions][nist-cloud-defs] of the service models and deployment
models for cloud infrastructures.  These definitions are the _de
facto_ standard for discussing cloud platforms.

## Service Models

The "service model" for a cloud answers the question: **What resources
are provided by the cloud?**  NIST and others define three general
service models:

- **Software as a Service (SaaS)**: Provides a complete application to
  a customer hosted on a cloud platform to provide lower latencies,
  better bandwidth, scaling, or other features.  Typically the
  customer will access the service through a web browser or another
  client on the customers computer.
- **Platform as a Service (PaaS)**: Provides a programming environment
  and cloud infrastructure featuring high-level capabilities like
  load-balancing, scaling, etc., relieving the programmer from having
  to construct those service from scratch in the application.
  Typically the customer is an application developer who accesses the
  service through a proprietary, language-specific API. 
- **Infrastucture as a Service (IaaS)**: Provides access to raw
  computing resources (virtual machines, storage, etc.) that can be
  provisioned (and released) rapidly.  Customers access these services
  either through a simple (usually REST) API or through a web
  interface. 

These service models are often presented as a hierarchy as a PaaS is
often built over a IaaS, as well as a SaaS over a PaaS.

Despite these clear-cut definitions, real services tend to be more
complicated, offering elements of the different service models from
the same cloud infrastructure.

## Deployment Models

The "deployment model" for a cloud answers the question: **Who will be
using the cloud infrastructure?**  NIST provides three deployment
models: 

- **Private**: These are infrastructures in which the computing
  resources are co-located with the primary users of the
  infrastructure.  The users typically pay for the computing resources
  directly and run them as a cloud for their own purposes.
- **Community**: These are infrastructures run for a group of
  collaborating institutes with similar aims.  The users usually pay
  for some fraction of the resources in the cloud and share those
  resources with others in the community.  Allocation of resources
  between people is usually done via "horse trading."
- **Public**: This is an infrastructure in which the resources are
  offered to the general public.  The customers pay for the resources
  directly usually via a credit card.  The computing resources are
  housed in data centers controlled by the owner of the cloud, not by
  the customer.

NIST actually defines a fourth deployment model, **Hybrid Cloud**,
which is really just a mix of the other deployment models.  This
usually comes up in the context of "cloud bursting", where remote
cloud resources (public clouds) are used when a local cloud resource
(private cloud) becomes saturated.

# Cloud Benefits

Despite the marketing hype, cloud technologies offer real benefits to
users.  With cloud infrastructures, people can rapidly deploy large
applications without associated large, up-front capital costs.
Moreover, they can optimize these applications easily, running them in
environments tuned to the application's requirements, deploying
services near clients to minimize latencies, and scaling resources to
match customer demand.


[nist]: http://www.nist.gov
[nist-cloud-defs]: http://csrc.nist.gov/publications/nistpubs/800-145/SP800-145.pdf