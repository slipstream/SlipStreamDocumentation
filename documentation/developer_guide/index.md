---
title: Developer Guide
---

# SlipStream

[SlipStream][ss-product] is a multi-cloud application management
platform.  The core of SlipStream and many of the cloud connectors are
open-source and released under the [Apache 2 License][apache2].
Collectively this version is called the **SlipStream Community
Edition**.

This guide focuses on the **Community Edition**, providing information
on how to:

 - Obtain the source code from GitHub,
 - Build and package the software, and
 - Run SlipStream locally for development.

It also references the complete [SlipStream API][ssapi] for those
developers who want to integrate SlipStream in their own application
DevOps processes.

The procedures (and API) are identical for the **Enterprise Edition**,
which includes a number of additional cloud connectors for public
cloud services.  You only need to change the URLs to those for this
edition.

SlipStream is written primarily in [Java], [Clojure], [Python],
[ClojureScript] and [JavaScript].  It uses [Maven] and [Leiningen] to
build the software and various frameworks for unit testing.

[Java]: https://www.java.com
[Clojure]: http://clojure.org
[Python]: https://www.python.org
[ClojureScript]: https://github.com/clojure/clojurescript
[JavaScript]: https://developer.mozilla.org/en-US/docs/Web/JavaScript
[Maven]: https://maven.apache.org/
[Leiningen]: http://leiningen.org

[ssapi]: http://ssapi.sixsq.com
[ss-product]: http://sixsq.com/products/slipstream.html
[apache2]: http://www.apache.org/licenses/LICENSE-2.0.html
