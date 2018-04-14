
Metadata
========

ExternalObject resources support the common CIMI attributes, such as
``name``, ``description``, and ``property``, as well as a
``bucketName`` and ``objectName``. These attributes can be used to
provide descriptive metadata for the underlying data objects.  The
standard CIMI filtering mechanisms can then be used to select
ExternalObject resources based on that metadata.  These limited
attributes are sufficient for many use cases.

Some use cases, however, will require a richer set of metadata.
SlipStream already provides a resource that allows for rich metadata
to be provided for other managed resources--the ServiceOffer.  In the
same way that ServiceOffers can describe Virtual Machines offers, they
can provide metadata for ExternalObjects as well.  In this way, the
CIMI filtering capabilities can be used with the richer metadata to
provide full-featured search of data sets.

As the schema for the ServiceOffer is completely open, all metadata
associated with an ExternalObject, both general and domain-specific,
can be tied to the underlying data object.  The relationship between
these resources is shown below.

.. figure:: images/diagrams/data-management-resources.png
   :width: 70%
   :align: center

   SlipStream Data Management Resources

Once the ServiceOffer and ExternalObject resources have been
registered in the system, users can find data objects of interest by
doing the following:

 1. Using the standard CIMI search and filtering capabilities to find
    ServiceOffer resources that describe data objects of interest.
 2. Follow the "href" links to ExternalObject resources that provide a
    proxy for the underlying data object.
 3. Request a presigned, read URL from the ExternalObject resources to
    get direct access to the data via the HTTPS protocol.

This process combines high-level filtering capabilities with
efficient, direct access to data.
