.. _build-container:

Docker Container for Builds
===========================

There is a Docker container available from the Docker Cloud/Hub that
contains the entire environment for the complete build of SlipStream.
You can start this container with the command::

  $ docker run -it sixsq/slipstream:build bash

You can then follow the instructions on checking out the SlipStream
sources and then perform the build.  The container obviously does not
contain any credentials, so you will need to add credentials if you
want to check changes into the repositories.

.. warning::

   This is an **alpha feature** and not officially
   supported. Nonetheless, we would appreciate your feedback on the
   usefulness of providing a container and on the contents and
   configuration of the container itself.
