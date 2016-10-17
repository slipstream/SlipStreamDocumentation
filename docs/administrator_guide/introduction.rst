Introduction
============

SlipStream, developed by SixSq, is a multi-cloud, coordinated
provisioning and image factory engine. In other words, it is an
engineering Platform as a Service (PaaS) solution, supporting production
deployment in the cloud, as well as development, testing, certification
and deployment processes using Infrastructure as a Service (IaaS) cloud
infrastructures.

Main Features
-------------

**Multi-machine Provisioning System**: SlipStream allows users to define
and execute deployments, based on high-level recipes that are
independent of the cloud on which the deployment will run. SlipStream
coordinates the provisioning of virtual machines, synchonizing the
deployment and configuration of individual machines as defined in the
deployment recipe.

For example, users can deploy entire multi-tier software systems
on-demand and in a single action. With SlipStream, this operation takes
a few minutes, compared to hours (or days!) for manual installations.

**Multi-cloud Provisioning**: SlipStream supports multiple cloud
providers and multi-cloud deployments, through a plug-in connector
design. (See supported connectors below.) Users select the cloud service
providers and technologies when deploying virtual machines, from within
a single SlipStream service. Furthermore, users can place parts of a
deployment on different cloud services or regions, automating redundant
and error-resistent deployments.

To illustrate, users can deploy computing clusters, load-balanced
applications, and multi-media processing pipelines, for example, across
several cloud providers to improve the resilience of the service and to
reduce latencies by co-locating data and computing resources, while
reducing costs.

**Support continuous integration processes with continuous deployment**:
SlipStream encourages users to parameterise image creation and
deployment recipes, such that key parameters (e.g. software version,
package location, dependencies, inter-relationships) can be provided at
runtime. This means that it is easy to integrate SlipStream with
continuous integration servers to provide a full deployment chain.

For instance, users can provision complete server-side systems in a
single action in order to test and certify a specific version of the
system.

**Independence from specific IaaS interfaces and hypervisors**: the
SlipStream recipes are independent of specific IaaS interfaces, avoiding
vendor lock-in and allowing you to focus on configuration and deployment
of your application, instead of the specifics of each IaaS.

For example, users can seamlessly apply the same image construction
recipes and multi-machine deployments to different cloud providers,
yielding the same results every time.

**Community sharing platform**: the SlipStream data model permits users
to share their image and deployment recipes with other users,
encouraging collaboration within a community, something dear to agile
and DevOps principles.

Supported Clouds
----------------

SlipStream communicates to IaaS clouds services via a connector
architecture. In general, the connectors for open source IaaS
implementations are released under the same license (Apache 2) as the
SlipStream core; connectors for proprietary solutions are closed source
and available via a commercial license.

The following table shows the availability of the cloud connectors.

+-------------------------+---------------+----------------+
| Connector               | Type          | Availability   |
+-------------------------+---------------+----------------+
| Amazon EC2              | proprietary   | available      |
+-------------------------+---------------+----------------+
| CloudSigma              | proprietary   | available      |
+-------------------------+---------------+----------------+
| CloudStack              | proprietary   | available      |
+-------------------------+---------------+----------------+
| IBM Smart Cloud Entry   | proprietary   | coming soon    |
+-------------------------+---------------+----------------+
| Microsoft IaaS Azure    | proprietary   | available      |
+-------------------------+---------------+----------------+
| NuvlaBox                | proprietary   | available      |
+-------------------------+---------------+----------------+
| OCCI                    | open source   | available      |
+-------------------------+---------------+----------------+
| OpenNebula              | open source   | available      |
+-------------------------+---------------+----------------+
| OpenStack               | open source   | available      |
+-------------------------+---------------+----------------+
| Physical/Fixed          | open source   | available      |
+-------------------------+---------------+----------------+
| StratusLab              | open source   | available      |
+-------------------------+---------------+----------------+
| VMWare vCloud           | proprietary   | available      |
+-------------------------+---------------+----------------+

All open-source connectors are licensed with Apache 2.0.

SlipStream Edition
------------------

SlipStream is available in two editions, the **Community** one and the
**Enterprise** one.

Proprietary connectors (see above) are only available on the Enterprise
edition.

For each edition we maintain three repositories:

-  Snapshots (most recent code base but may be unstable)
-  Candidates (possibly stable releases but not yet validated for
   production)
-  Releases (stable releases for production)
