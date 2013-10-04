# Introduction

Developed by SixSq, SlipStream™ is a multi-cloud, coordinated
provisioning and image factory engine. In other words, it is an
engineering Platform as a Service (PaaS) solution, supporting
production deployment in the cloud, as well as development, testing,
certification and deployment processes using Infrastructure as a
Service (IaaS) cloud environments.

## Main Features

**Multi-machine Provisioning System**: SlipStream™ allows users to
define and execute deployments, based on high-level recipes,
independently from the cloud on which the recipes will be applied.
Deployments include coordination and orchestration of virtual
machines, including ordering and synchronisation of services.

For example, users can deploy, in a single action, on-demand, entire
mutli-tier software systems. With SlipStream™, this operation takes a
few minutes, often compared to hours if not days using custom
solutions.

**Multi-cloud Provisioning**: SlipStream™ supports multi-cloud
deployments. This means users have the choice of a number of cloud
service providers and technologies (public and/or private) when
deploying virtual machines, from within the same SlipStream™
service. Furthermore, users can choose to deploy different parts of a
deployment on different cloud services or regions, such that redundant
and resilient behaviour is reached. SlipStream™ supports different
clouds using a connector design.  The available connectors are listed
below.

To illustrate, users can deploy applications (e.g. computing clusters,
load balanced applications, multi-media processing pipelines) across
several cloud providers, in order to improve data proximity &
resilience, while reducing costs.

**Support continuous integration processes with continuous
deployment**: SlipStream™ encourages users to parameterise image
creation and deployment recipes, such that key parameters
(e.g. software version, package location, dependencies,
inter-relationships) can be provided at runtime. This means that it is
easy to integrate SlipStream™ with continuous integration servers to
provide a full deployment chain.
	
For instance, users can provision complete server-side systems in a
single action in order to test and certify a specific version of the
system.

**Independence from specific IaaS interfaces and hypervisors**: the
SlipStream™ recipes are independent of specific IaaS interfaces,
therefore avoiding vendor lock-in, allowing you to focus on
configuration and deployment, instead of the specifics of each IaaS.

For example, users can seamlessly apply the same image construction
recipes and multi-machine deployments to different cloud providers,
yielding the same results every time.

**Community sharing platform**: the SlipStream™ data model permits
users to decide to share their image and deployment recipes with other
users, thus contributing to a community effort, something dear to
agile and DevOps principles.

## Supported Clouds

SlipStream™ communicates to IaaS clouds services via a connector
architecture. A growing number of connectors are available. The
connectors talking to open source IaaS implementations are released
under the same open source license as the SlipStream™ core, while
connectors to proprietary solutions are closed source and available
via a commercial license.  The following table shows the availability
of the cloud connectors.

The following is the latest update on availability of cloud connectors:

------------------------------ --------------------------
Connector                      Availability
------------------------------ --------------------------
StratusLab (incl. OpenNebula)  open source, available

OpenStack                      open source, available

Abiquo                         proprietary, available

CloudSigma                     proprietary, available

Amazon EC2                     proprietary, available

VMWare vCloud                  proprietary, available

OCCI                           open source, available

Physical/Fixed                 open source, available

CloudStack                     proprietary, coming soon

IBM Smart Cloud Entry          proprietary, coming soon

Microsoft IaaS Azure           proprietary, coming soon
------------------------------ --------------------------
