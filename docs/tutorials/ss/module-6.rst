Module VI - Data Management
---------------------------

S3 (Simple Storage Service) object storage has become a `de facto`
standard since its introduction by Amazon Web Services in 2006.  IaaS
cloud infrastructures and cloud software provide S3-compatible object
storage nearly universally. SlipStream takes advantage of these
services and its own CIMI resource database to provide a **multi-cloud
object storage solution**.

Benefits of the SlipStream multi-cloud object storage include:

 - **Global queries/views** of your data across clouds, enabled by the
   centralized storage of object metadata in SlipStream.
 - **Uniform access control** across all clouds, using SlipStream
   users' identities and roles.
 - **Efficient IO** via direct access to the S3 storage service
   holding an object by any client.
 - All data access is via HTTPS, so **no special client software or
   APIs are required**.
 - Easy **replication and caching** strategies enabled by Write-Once,
   Read-Mostly (WORM) semantics.
 - Definition of **rich object metadata** via optional use of the
   SlipStream Service Catalog.
 - **Low complexity** to facilitate use.
 - **Scalable** architecture to handle large datasets.

With this solution, you can take advantage of cloud-native storage
from multiple providers without the pain of manual bookkeeping and
application-level authorization.
   
.. note::

   This functionality is in **active development**.  Feedback on all
   aspects of the multi-cloud object storage solution is welcome, but
   real-world feedback on the existing implementation is especially
   useful.

.. toctree::
   :maxdepth: 2

   data-management-model
   external-objects
   metadata
   data-management-gotchas
