Introduction
============

SlipStream, developed by SixSq, is an affordable, multi-cloud
application management platform that supports DevOps, Big Data and
Smart City strategies platform.

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
SlipStream encourages users to parameterize image creation and
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

The following table shows the production connectors.  Alpha and beta
connectors for other proprietary clouds may also be available; request
information via the SlipStream support.

+--------------------+---------------+
|   Connector        |   Type        |
+====================+===============+
| Amazon EC2         | proprietary   |
+--------------------+---------------+
| CloudStack         | open source   |
+--------------------+---------------+
| Exoscale           | proprietary   |
+--------------------+---------------+
| OpenNebula         | open source   |
+--------------------+---------------+
| OpenStack          | open source   |
+--------------------+---------------+
| Open Telekom Cloud | proprietary   |
+--------------------+---------------+
| NuvlaBox           | proprietary   |
+--------------------+---------------+
| VMWare vCloud      | proprietary   |
+--------------------+---------------+


SlipStream Edition
------------------

SlipStream is available in two editions, **Community** and
**Enterprise**. Commercial support and proprietary connectors (see
above) are only available on the Enterprise edition; otherwise the two
editions are identical.

For each edition, we maintain three repositories:

- **Snapshots**: most recent code base but software may be unstable
- **Candidates**: software releases that may be stable but not yet
  been validated for production
- **Releases**: stable releases verified for production

We create new candidate releases every two weeks and deploy those
candidates on our Nuvla service.
