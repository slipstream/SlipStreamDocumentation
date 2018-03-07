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

**This guide does not cover the SlipStream API.** If you want to use
SlipStream programmatically, you can find the `complete API
documentation <http://ssapi.sixsq.com>`__ on a separate, dedicated
site.

The procedures (and API) are identical for the **Enterprise Edition**,
except that modules for additional cloud connectors for public cloud
services must be included.

The primary programming languages for SlipStream are `Clojure
<http://clojure.org>`__, `ClojureScript
<https://github.com/clojure/clojurescript>`__, and `Python
<https://www.python.org>`__.  Other languages such as `Java
<https://www.java.com>`__, `JavaScript
<https://developer.mozilla.org/en-US/docs/Web/JavaScript>`__, bash,
etc. are also used.

`Maven <https://maven.apache.org/>`__ and `Leiningen
<https://leiningen.org/>`__ are used to build the software and various
language-specific frameworks are used for testing.

