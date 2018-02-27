
Data Management Model
=====================

The data management model adopted by SlipStream was designed to
provide: 

 - An abstraction that allows uniform access across multiple clouds
 - Rich search capabilities to find appropriate data objects
 - Direct access to data within objects to maximize performance
 - The ability to cache and to replicate data objects effectively

Together, these features satisfy the data management requirements for
applications from a wide range of domains.

In detail, the model contains three entities that interact to provide
all the data management features:

 - S3 object storage on the supported cloud infrastructures,
 - "ExternalObject" resources within SlipStream that provide links to
   the real data objects in the S3 object storage, and
 - ServiceOffer resources that optionally provide metadata describing
   a data object or a set of data objects.

The model follows a "write-once, read many" policy to allow for easier
reasoning about caching and replication in a distributed, multi-cloud
environment.

For reading and writing (once) a data object, users will be referred
to the S3 object store for direct access. However, the management
functions, like creating, updating properties, and deleting, are
handled through SlipStream via the standard CRUD actions on the data
object's ExternalObject resource.

For simple use cases, the limited, common metadata of CIMI resources
can be used to search the list of ExternalObject resources
directly. For most use cases, richer filtering functionality is
required.  To support this, ServiceOffer resources can be created that
describe one or many ExternalObject resources.  The open schema of the
ServiceOffer resource allows any general or domain-specific attributes
to be associated with the data objects.
