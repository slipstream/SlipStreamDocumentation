
Gotchas
=======

The data management system involves several resources and a couple of
services. The model is simple and straightforward, but this means that
managers of the system have to be careful with synchronization between
the different elements.

In particular, data managers should be aware of the following:

 1. Do not share buckets that are managed by SlipStream and those that
    you manage directly. You risk corrupting data objects managed by
    SlipStream.  SlipStream will also "autodiscover" any new objects
    that appear, outside of its control or update information for
    those that have changed.
 2. Follow the write-once, read-mostly model.  Only modify objects
    through a write URL provided by SlipStream.  Do not modify objects
    directly via the cloud storage API.  You risk corrupting the data
    managed by the system.
 3. Ensure that the ACLs for the ServiceOffer and ExternalObject
    resources are aligned.  If they are not, you may leak information
    to unauthorized people or lose visibility over data objects that
    you manage.
 4. When deleting ExternalObjects, be sure to propage these changes to
    ServiceOffer resources that reference them.

In general, these guidelines boil down to synchronizing changes
between the ServiceOffer and ExternalObject resources, which should
not be difficult in the majority of cases.

