---
title: Developer Guide
---

# SlipStream

[SlipStream][ss-product] is a multi-cloud application management
platform.  The core of SlipStream and many of the cloud connectors are
open-source and released under the Apache 2 License; collectively this
version is called the "SlipStream Community Edition".

This guide describes how to obtain the source code for the **Community
Edition**, how to build it and how to run the server locally for
development.

If you have access to the **Enterprise Edition** sources, the
procedures are identical but the URLs need to be changed to those for
the Enterprise Edition repositories.

SlipStream is written primarily in [Java], [Clojure], [Python],
[ClojureScript] and [JavaScript].  It uses [Maven] to build the
software and the standard xUnit suites for unit testing.

[Java]: https://www.java.com
[Clojure]: http://clojure.org
[Python]: https://www.python.org
[ClojureScript]: https://github.com/clojure/clojurescript
[JavaScript]: https://developer.mozilla.org/en-US/docs/Web/JavaScript
[Maven]: https://maven.apache.org/

[ss-product]: http://sixsq.com/products/slipstream.html
