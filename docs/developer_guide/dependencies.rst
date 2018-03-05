Dependencies
============

To build SlipStream, you need to have a variety of languages, tools,
and libraries installed on your system.

**The target production platform is CentOS 7.** However, the software
should build without problems on any Unix-like environment (Linux,
FreeBSD, MacOS, etc.). Binary packages will only be built on platforms
supporting RPM. The core developers primarily use MacOS.

.. note::
   
   The SlipStream build is **not** supported on Windows and will
   **not** work.

The following sections describe how to configure your development
environment on CentOS 7 and MacOS. If you are using another Unix-like
platform, use the CentOS 7 instructions as a guide.

There is also a Docker container that has the entire SlipStream build
environment preconfigured. See the :ref:`build-container` section for
details.


System Packages
---------------

CentOS 7
~~~~~~~~

CentOS 7 is the target platform for production deployments of
SlipStream. Builds on CentOS 7 are the only ones that are officially
supported.

These instructions assume that you are building the software on an
**up-to-date, minimal CentOS 7 system**.  You should upgrade your
system to ensure you have the latest versions of dependencies.

Several of the packages required for the build are not available in the
core CentOS 7 distribution. You will need to configure your machine to
use the `EPEL 7 package
repository <http://fedoraproject.org/wiki/EPEL>`__::

    $ yum install -y yum-utils epel-release
    $ yum-config-manager --enable epel

If you're not using a CentOS release, you'll need to find and install
the RPM for EPEL configuration on their website. You can find the URL
and package name via the information in the "How can I use these extra
packages?" section on the `EPEL welcome
page <http://fedoraproject.org/wiki/EPEL>`__.

All of the packaged dependencies can be installed directly with
``yum``.  The following table lists the RPM packages that must be
installed and describes how those packages are used within the build.

The command::

    $ yum install -y \
          git \
          java-1.8.0-openjdk-devel \
          python \
          python-devel \
          python-pip \
          rpm-build \
          createrepo \
          bzip2 \
          fontconfig \
          gcc \
          docker \
          which

will install all of the listed packages.

+----------------------------+-----------------------------------------+
| Package                    | Comment                                 |
+----------------------------+-----------------------------------------+
| git                        | Download sources from GitHub            |
+----------------------------+-----------------------------------------+
| java-1.8.0-openjdk-devel   | Compile and run the server              |
+----------------------------+-----------------------------------------+
| python                     | Client CLI build and testing            |
+----------------------------+-----------------------------------------+
| python-devel               | Needed for python module dependencies   |
+----------------------------+-----------------------------------------+
| python-pip                 | Needed for dependencies installation    |
+----------------------------+-----------------------------------------+
| rpm-build                  | Creates binary distribution packages    |
+----------------------------+-----------------------------------------+
| createrepo                 | Create local yum repository             |
+----------------------------+-----------------------------------------+
| fontconfig                 | Clojurescript testing (via phantomjs)   |
+----------------------------+-----------------------------------------+
| bzip2                      | Clojurescript testing (phantomjs dep.)  |
+----------------------------+-----------------------------------------+
| fontconfig                 | Clojurescript testing (phantomjs dep.)  |
+----------------------------+-----------------------------------------+
| gcc                        | Needed for building python dependencies |
+----------------------------+-----------------------------------------+
| docker                     | Needed to build containers              |
+----------------------------+-----------------------------------------+
| which                      | Needed for maven configuration          |
+----------------------------+-----------------------------------------+

MacOS
~~~~~

The primary platform used by the SlipStream developers is Mac OS X.
Consequently, this is a well-understood and well-supported SlipStream
development environment. We're going to assume you're running MacOS
with `Homebrew <http://brew.sh/>`__.

Your default locale settings may conflict with some of the programs we’ll
need. If you want to be on the safe side, add these lines to your
**.bash_profile** file::

    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8

Most of the necessary dependencies are already installed by default in
recent versions of MacOS.

**You must install the Java Development Kit on your system.** Download
and install the JDK 8 package from Oracle's `Java download page
<https://www.java.com/en/download/manual.jsp>`__.

**You must also install Docker.** You can find the DMG package from
 the `Docker website
 <https://docs.docker.com/docker-for-mac/install/>`__.


Python Dependencies
-------------------

CentOS 7
~~~~~~~~

The correct version of Python will have been installed with the system
packages described above.  Nonetheless, it is recommended that you
install and use ``pyenv``::

  $ curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash 

You should also add the following to you bash login script::

  export PATH="/username/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"

This wil configure your Python environment and let you choose between
different Python versions.  **Be sure to change the path to match your
username.**

You must also install some Python dependencies via ``pip``.  See the
common configuration below.

MacOS
~~~~~

It is strongly recommended that you install and use ``pyenv``.  This
provides a more flexible and consistent Python environment on MacOS.

From an account with administrator access, install ``pyenv``::

  $ brew update
  $ brew install pyenv

Then from your normal account (if different from the administrator
account), adjust your bash login::

  export PATH="/Users/username/.pyenv:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"

This will allow you to change dynamically the version of Python being
used. **Be sure to change the path to match your username.**

If you have errors related to the ``virtualenv-init`` command, then
run the command::

  git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

which will install the missing plugin.

If Python plugin executables are not visible, then you may also need
to add the path ``/Users/username/.local/bin`` to your PATH variable.

Next install the latest 2.7 release of Python and set this as the
default::

  $ pyenv install 2.7.13
  $ pyenv global 2.7.13

Note the the download, compilation, and installation of Python will
take some time.

Verify that you are using the correct version of Python with::

  $ pyenv versions

and verify with ``pip -V`` that ``pip`` works and comes from the
Python installation that you just performed.

Proceed with the installation of the Python package dependencies
described in the next section.


All Platforms
~~~~~~~~~~~~~

Install the following dependencies that are needed to run the unit tests for
the python code::

    $ pip install tox

You can verify that ``tox`` is available with ``which``.


Build Tools
-----------

Maven
~~~~~

The overall SlipStream build is controlled through
`Maven <https://maven.apache.org/>`__.

Download and install the **latest**
`Maven <https://maven.apache.org/>`__ release from the Apache Maven
website. You will need to download the `Maven
distribution <https://maven.apache.org/download.html>`__ (choose the
most recent binary distribution), unpack the distribution and modify the
environment to make the ``mvn`` command visible.

.. warning::

    The Maven version supplied by most operating systems is too old to
    work with the SlipStream build. You must have at least version
    3.3.

Once you have downloaded and unpacked Maven, you can setup the
environment with::

    $ export MAVEN_HOME=<installation directory>/apache-maven-3.3.9
    $ export PATH=$PATH:$MAVEN_HOME/bin

The ``mvn`` command should now be visible. The software will build with
any maven version later than 3.3.

Leiningen
~~~~~~~~~

The clojure SlipStream server (ssclj) and its components are built
using `Leiningen <https://leiningen.org/>`__. Leiningen (``lein``) is
triggered via Maven to allow for an integrated build process.

To install ``lein``, follow its `installation instructions
<https://leiningen.org/#install>`__.  After installation you must make
sure that the ``lein`` command is in your path by executing::

    $ lein -v

This will download the most recent version of Leiningen and provide
you with the version number.  The download will only happen on the
first invocation of the command.

PhantomJS
~~~~~~~~~

PhantomJS is a headless Javascript environment that is used to test
the clojurescript-compatible client API.  It must be installed if the
the unit tests are run during the SlipStream build.

Linux
$$$$$

On **Linux** machines, you must download the PhantomJS binary tarball
and then move the static executable into the path.  The tarball can be
found on the `PhantomJS download webpage
<http://phantomjs.org/download.html>`__.  Usually the binary is copied
to ``/usr/local/bin/phantomjs``, but any location available on the
PATH will work.  The name of the executable must be ``phantomjs``.

The dependencies you installed above for CentOS 7 or Ubuntu include
the dependencies for phantomjs. You can test the installation with
``phantomjs --version``.

.. warning::

   The latest version of PhantomJS does not work correctly on
   CentOS 7.  Use instead version 2.1.1, which can be found from
   https://bitbucket.org/ariya/phantomjs/downloads/.

MacOS
$$$$$

On **Mac OS X**, it can be installed easily with ``brew``.  Just run
the command::

  $ brew install phantomjs

As above, you can test that it works by doing ``phantomjs --version``.

