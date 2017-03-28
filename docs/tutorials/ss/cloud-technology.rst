Cloud Technology
================

Cloud technologies have reached levels of maturity and market
penetration such that organizations have to justify why they are *not*
using cloud rather than the other way around.

This has occurred because cloud technologies offer real benefits to
users and organizations. With cloud infrastructures, people can easily
deploy large applications and can dynamically tune the allocated
resources to maximize responsiveness and reliability.  This flexibilty
has made the use of cloud technologies economically attractive by
reducing capital and/or personnel costs. 

Critical Components
-------------------

There are three critical components of cloud technologies that have
lead to its success:

- Mature Virtualization Technologies
    Virtualization techniques have been directly integrated into
    mainstream operating systems and modern CPUs. This integration
    allows use of virtualization with only a negligible impact on
    performance.

- Simple, Universal APIs
    Most clouds use Resource Oriented Architectures and "REST" APIs
    over the ubiquitous HTTP protocol.  Doing so makes the service
    universally accessible from all programming languages and reuses
    the well understood HTTP service model.

- Ubiquitous, Reliable Networking
    Robust, high-bandwidth cellular networks, wifi, and wired Internet
    connections provide universal, reliable, 24/7 access to critical
    services hosted in remote infrastructures like clouds.

By combining these components, cloud platforms provide efficient,
powerful computing resources that consumers can easily and reliably
access from anywhere.

Cloud Jargon
------------

The constant barrage of marketing using the term "cloud" can make it
difficult to develop a precise understanding of what cloud
technologies are.  Fortunately, the American standards institute
(`NIST <http://www.nist.gov>`__) provides `clear, precise definitions
<http://dx.doi.org/10.6028/NIST.SP.800-145>`__ that fit our
needs. These definitions are the *de facto* standard for discussing
cloud platforms.

Service Models
~~~~~~~~~~~~~~

**What resources (or services) are provided by the cloud?** In answer
to this question, NIST and others define three "service models":

- Software as a Service (SaaS)
    Provides a complete application to a customer hosted on a cloud
    platform to provide lower latencies, better bandwidth, scaling, or
    other features. Typically the customer will access the service
    through a web browser or another client on the customers computer.

- Platform as a Service (PaaS)
    Provides a programming environment and cloud infrastructure
    featuring high-level capabilities like load-balancing, scaling,
    etc., relieving the programmer from having to construct those
    services from scratch in the application. Typically the customer
    is an application developer who accesses the service through a
    proprietary, language-specific API.

- Infrastucture as a Service (IaaS)
    Provides access to raw computing resources (virtual machines,
    storage, etc.) that can be provisioned (and released)
    rapidly. Customers access these services either through a simple
    (usually REST) API or through a web interface.

These service models are often presented as a hierarchy as a PaaS is
often built over a IaaS, as well as a SaaS over a PaaS.

Despite these clear-cut definitions, real services tend to be more
complicated, offering elements of the different service models from the
same cloud infrastructure.

Deployment Models
~~~~~~~~~~~~~~~~~

The "deployment model" answers the question: **Who uses the cloud
infrastructure?** NIST defines three deployment models:

- Private
    These are infrastructures in which the computing resources are
    co-located with its primary users. The users (or their institute)
    buy the computing resources directly and run them as a cloud for
    their own purposes.

- Community
    These are infrastructures run by and for a group of collaborating
    institutes with similar aims. The users usually buy some fraction
    of the computing resources and share those resources with others
    in the community. Allocation of resources between people is
    usually done via "horse trading."

- Public
    Cloud infrastructures that offer their resources to the general
    public.  The customers pay for use of the computing resources
    directly (usually via a credit card). The computing resources are
    housed in data centers controlled by the owner of the cloud, not
    by the customer or the customer's institute.

NIST actually defines a fourth deployment model, **Hybrid Cloud**, which
is really just a mix of the other deployment models. This usually comes
up in the context of "cloud bursting", where remote cloud resources
(public clouds) are used when a local cloud resource (private cloud)
becomes saturated.
