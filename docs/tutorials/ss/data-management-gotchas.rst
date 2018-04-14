
Gotchas
=======

The data management system involves a couple of CIMI resources and
potentially many S3 services. Nonetheless, the model is simple, and
managing data objects through SlipStream should be straightforward.

The one critical assumption is that **data objects in SlipStream are
managed only by SlipStream**.  Direct management of the objects on the
S3 storage may create inconsistencies in the SlipStream ExternalObject
and ServiceOffer resources.

In particular, data managers should be aware of the following:

 1. Do not share buckets that are managed by SlipStream and those that
    you manage directly. You risk corrupting objects' data or
    metadata.
 2. SlipStream will **not** "autodiscover" any new objects that appear
    in referenced buckets or update metadata based on changes in S3.
 3. Follow the write-once, read-mostly model.  Only modify objects
    through an upload URL provided by SlipStream.  Do not modify objects
    directly via the cloud storage API.
 4. If you use ServiceOffer resources, ensure that the ACLs for the
    ServiceOffer and ExternalObject resources are aligned.  If they
    are not, you may leak information to unauthorized people or lose
    visibility over data objects that you manage.
 5. When deleting ExternalObject resources, be sure to propagate
    changes to ServiceOffer resources that reference them.

In general, these guidelines boil down to not using the S3 API
directly and synchronizing changes between the ServiceOffer and
ExternalObject resources.  The synchronization is not difficult in
most cases. SlipStream may at some point in the future, provide a
higher-level API to further simplify the data management.
