Sources
=======

All of the SlipStream source code is stored in
`GitHub <https://github.com>`__ repositories. The open-source
**Community Edition** repositories are under the the `SlipStream
Organization <https://github.com/slipstream>`__. You can browse the
source code through the GitHub web interface or clone the repositories
with a `git <http://git-scm.com>`__ client.

Prerequisites
-------------

The fastest way to checkout all of the source code is through the
"bootstrapping" process described below. To use that process, you'll
need to have the following installed on your development machine:

-  A `git <http://git-scm.com>`__ client,
-  A java development environment (JDK), version 1.8 or later, and
-  `Maven <https://maven.apache.org/>`__, version 3.2.0 or later.

Ensure that all of these are installed and working correctly before
proceeding.

Bootstrapping
-------------

The major SlipStream components are stored in separate repositories on
GitHub. To build the entire system, all of the component repositories
must be cloned locally. To make this process easier, we've created a
"bootstrap" repository that automates the process.

Using the git command line (or your graphical git client), clone the
bootstrap repository. The command for this is:

::

    $ git clone https://github.com/slipstream/SlipStreamBootstrap

This is a public GitHub URL, so you should be able to clone the
repository from here either with or without a GitHub account.

Obtaining SlipStream Components
-------------------------------

Once you've checked out the SlipStreamBootstrap repository, descend into
the root of that repository. From there (assuming that you have a GitHub
account), you can then use maven to clone all of the SlipStream
repositories.

::

    $ cd SlipStreamBootstrap
    $ mvn generate-sources

All of the SlipStream component repositories will be cloned in the same
directory. The checkout by default will be at the HEAD of the master
branch. The repository names all start with "SlipStream".

Public GitHub URLs
------------------

The above procedure will use the GitHub developer URLs, which require a
GitHub account. **If you do not have a GitHub account**, then use the
command:

::

    $ mvn -P public generate-sources

instead. This uses the public URLs for the repositories.

Branches or Tags
----------------

By default, the **master** branch will be checked out. If you want a
different branch or tag, then use the following command:

::

    $ mvn -Dslipstream.version.default=master generate-sources

setting the value of "master" to the desired branch or tag. This will
consistently use the same branch or tag for all components.

The tags for releases follow the pattern: "v2.5-community". Look at the
release notes to determine which tags correspond stable or candidate
releases.

Although not recommended, it is sometimes useful to mix and match
versions of different components. Look at the ``pom.xml`` file for the
properties to set from the command line if you want to do this.
