
Links to Data Objects
=====================

Data objects can be very large and often contain binary data.  To
avoid capacity, performance, and security issues, the data objects are
not directly managed within the SlipStream database.  Instead,
SlipStream manages "links" to these data objects, providing "actions"
that facilitate creating, reading, writing, and deleting the objects.

Create
------

The ExternalObject resource is a templated CIMI resource.  This means
that the creation request must reference an ExternalObjectTemplate
(which will then require a reference to a cloud credential and a
bucket name) when creating a new ExternalObject resource.

When the server creates the resource, it:

 - Checks that the bucket exists, creating it if necessary using the
   referenced credentials,
 - Creates the ExternalObject resource with the provided information,
   and
 - Sets the state of the resource to "created" in preparation of
   having the data uploaded to the object.

If the bucket doesn't exist and can't be created, an error will be
returned.  The name of the object within the bucket is the same as the
identifier of the created ExternalObject resource.


Write Data
----------

When the ExternalObject resource is in the "created" state, anyone
with "modify" access to the resource can request a presigned write URL
for the S3 object via the CIMI action "getWriteURL" on the resource.
A lifetime can be specified for the returned URL to limit security
concerns with a presigned URL.

The returned presigned URL can be used to directly upload the contents
of the object directly on the S3 object store via HTTPS.  This is
convenient because it does not require 1) direct authentication or 2)
special software to be installed by the client uploading the data.

Once the presigned, write URL has been provided, the state of the
ExternalObject resource will be changed to "ready" and no further
write URLs can be requested. 

Read Data
---------

When the ExternalObject resource is in the "ready" state, anyone with
"view" access to the resource can request a presigned read URL for the
S3 object via the CIMI action "getReadURL" on the resource. A lifetime
can be specified for the returned presigned URL.

Similarly to the write URL, the returned URL allows access to the data
object directly on S3.  It does not require direct authentication or
special software by the client reading the data.

Delete
------

Deleting an ExternalObject, using the standard CIMI delete pattern,
will delete the referenced object as well as the ExternalObject
resource itself. ServiceOffer resources that reference that
ExternalObject must be manually kept synchonized to the change.

Sequence Diagram
----------------

The following sequence diagram provides a graphical description of
each of the above actions.

.. figure:: images/diagrams/external-object-sequence-diagram.png
   :width: 70%
   :align: center

   Sequence Diagram of ExternalObject Actions
