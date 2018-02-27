
Gotchas
=======

The data management system involves several resources and a couple of
services. Although the model tries to keep everything synchronized
there are a few gotchas with the system:

 1. Do not share buckets that are managed by SlipStream and those that
    you manage directly. You risk corrupting data objects managed by
    SlipStream.  SlipStream will also not "autodiscover" any new
    objects that appear, outside of its control.
 2. Do not modify objects, unless it is through a URL requested from
    SlipStream. You rish corrupting the data managed by the system.
 3. You must ensure that the ACLs for the ServiceOffer and
    ExternalObject resources are consistent.  If they are not, you may
    leak information to unauthorized people or lose visibility over
    data objects that you manage.
