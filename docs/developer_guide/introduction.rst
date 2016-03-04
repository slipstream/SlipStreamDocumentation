Introduction
============

`SlipStream <http://sixsq.com/products/slipstream.html>`__ is a
multi-cloud application management platform. The core of SlipStream and
many of the cloud connectors are open-source and released under the
`Apache 2 License <http://www.apache.org/licenses/LICENSE-2.0.html>`__.
Collectively this version is called the **SlipStream Community
Edition**.

This guide focuses on the **Community Edition**, providing information
on how to:

-  Obtain the source code from GitHub,
-  Build and package the software, and
-  Run SlipStream locally for development.

It also references the complete `SlipStream
API <http://ssapi.sixsq.com>`__ for those developers who want to
integrate SlipStream in their own application DevOps processes.

The procedures (and API) are identical for the **Enterprise Edition**,
which includes a number of additional cloud connectors for public cloud
services. You only need to change the URLs to those for this edition.

SlipStream is written primarily in `Java <https://www.java.com>`__,
`Clojure <http://clojure.org>`__, `Python <https://www.python.org>`__,
`ClojureScript <https://github.com/clojure/clojurescript>`__ and
`JavaScript
<https://developer.mozilla.org/en-US/docs/Web/JavaScript>`__.  It uses
`Maven <https://maven.apache.org/>`__ to build the software and
various frameworks for unit testing.
