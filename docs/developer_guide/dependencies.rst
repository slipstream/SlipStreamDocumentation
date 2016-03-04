Dependencies
============

To build SlipStream, you need to have a variety of languages, tools, and
libraries installed on your system.

The current supported target platform is CentOS 6; however, the software
should build without problems on any Unix-like environment (Linux,
FreeBSD, Mac OS X, etc.). Packages will only be built on platforms
supporting RPM.

SlipStream will **not** build on Windows.

Languages
---------

The core languages used in development are Java and Python. Make sure
that you have the development environments for those two languages
installed. You will need the versions:

-  Java 1.8+
-  Python 2.6+ (but not 3.0+)

See the appropriate installation instructions for your operating system.

Other languages used by the SlipStream code are either pulled in
automatically (e.g. Clojure) or are already installed on all machines by
default (e.g. bash).

Build Dependencies
------------------

There are a fairly sizable number of external libraries and tools that
must be installed for a full build of SlipStream. This section describes
how to install those dependencies on the primary systems we use. If you
want to use other systems, you will need to adapt the information below.

Mac OS X
--------

The primary platform used by the SlipStream developers is Mac OS X.
Consequently, this is a well-understood and well-supported SlipStream
development environment. We're going to assume you're running OS X with
`Homebrew <http://brew.sh/>`__ and
`easy\_install <https://pythonhosted.org/setuptools/easy_install.html>`__
available.

Most of the necessary dependencies are already installed by default in
recent versions of Mac OS X. The few that are not already there, can be
installed with:

::

    $ sudo easy_install pip
    $ sudo pip install nose coverage paramiko mock pylint

These dependencies are needed to run the unit tests for the python code.

CentOS 6
--------

CentOS 6 is the current target platform for production deployments of
SlipStream. Builds on CentOS 6 are the only ones that are officially
supported.

These instructions assume that you are building the software on an
**up-to-date, minimal CentOS 6 system**.

Several of the packages required for the build are not available in the
core CentOS 6 distribution. You will need to configure your machine to
use the `EPEL 6 package
repository <http://fedoraproject.org/wiki/EPEL>`__:

::

    $ yum install -y epel-release

If you're not using a CentOS release, you'll need to find and install
the RPM for EPEL configuration on their website. You can find the URL
and package name via the information in the "How can I use these extra
packages?" section on the `EPEL welcome
page <http://fedoraproject.org/wiki/EPEL>`__.

In the latest versions of CentOS 6 there are some conflicts between the
versions of python crypto libraries and those needed by SlipStream. To
avoid these conflicts, do the following:

::

    $ yum erase python-paramiko python-crypto

The correct versions will then be installed with the other dependencies.

Most (but not all!) of the build dependencies can be installed directly
with ``yum``. The following table lists the RPM packages that must be
installed and describes how those packages are used within the build.

The command:

::

    $ yum install -y \
          git \
          java-1.8.0-openjdk-devel \
          python \
          python-devel \
          pylint \
          python-pip \
          python-mock \
          gcc \
          rpm-build \
          createrepo

will install all of the listed packages.

+----------------------------+---------------------------------------------+
| Package                    | Comment                                     |
+----------------------------+---------------------------------------------+
| git                        | Download sources from GitHub                |
+----------------------------+---------------------------------------------+
| java-1.8.0-openjdk-devel   | Compile and run the server                  |
+----------------------------+---------------------------------------------+
| python                     | Client CLI build and testing                |
+----------------------------+---------------------------------------------+
| python-devel               | Needed for python module dependencies       |
+----------------------------+---------------------------------------------+
| pylint                     | Analysis of python code                     |
+----------------------------+---------------------------------------------+
| python-pip                 | Installation of python modules              |
+----------------------------+---------------------------------------------+
| python-mock                | Mocking library used in unit tests          |
+----------------------------+---------------------------------------------+
| gcc                        | c-bindings for python module dependencies   |
+----------------------------+---------------------------------------------+
| rpm-build                  | Creates binary distribution packages        |
+----------------------------+---------------------------------------------+
| createrepo                 | Create local yum repository                 |
+----------------------------+---------------------------------------------+

There are a few python modules that must be installed with ``pip``. The
SlipStream code uses options and features that require more recent
versions than those packaged for CentOS 6. The following table provides
details. Use the command:

::

    $ pip install nose coverage paramiko

to install all of these packages.

+------------+----------------------------------------+
| Package    | Comment                                |
+------------+----------------------------------------+
| nose       | Unit testing utility for python code   |
+------------+----------------------------------------+
| coverage   | Coverage testing for python code       |
+------------+----------------------------------------+
| paramiko   | SSH library for python                 |
+------------+----------------------------------------+

CentOS 7
--------

The official platform for SlipStream will shift to CentOS 7 sometime in
the not-too-distant future. In preparation for this, the software is
already being built on this platform. Because of the more recent
packages provided in CentOS 7, the dependency installation is somewhat
simplified from CentOS 6.

These instructions assume that you are building the software on an
**up-to-date, minimal CentOS 7 system**.

Several of the packages required for the build are not available in the
core CentOS 7 distribution. You will need to configure your machine to
use the `EPEL 7 package
repository <http://fedoraproject.org/wiki/EPEL>`__.

::

    $ yum install -y epel-release

If you're not using a CentOS release, you'll need to find and install
the RPM for EPEL configuration on their website. You can find the URL
and package name via the information in the "How can I use these extra
packages?" section on the `EPEL welcome
page <http://fedoraproject.org/wiki/EPEL>`__.

All of the build dependencies can be installed directly with ``yum``.
The following table lists the RPM packages that must be installed and
describes how those packages are used within the build.

The command:

::

    $ yum install -y \
          git \
          java-1.8.0-openjdk-devel \
          python \
          python-devel \
          pylint \
          python-mock \
          python-nose \
          python-coverage \
          python-paramiko \
          rpm-build \
          createrepo

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
| pylint                     | Analysis of python code                 |
+----------------------------+-----------------------------------------+
| python-mock                | Mocking library used in unit tests      |
+----------------------------+-----------------------------------------+
| python-nose                | Unit testing for python code            |
+----------------------------+-----------------------------------------+
| python-coverage            | Coverage testing for python code        |
+----------------------------+-----------------------------------------+
| python-paramiko            | SSH library for python                  |
+----------------------------+-----------------------------------------+
| rpm-build                  | Creates binary distribution packages    |
+----------------------------+-----------------------------------------+
| createrepo                 | Create local yum repository             |
+----------------------------+-----------------------------------------+

Ubuntu 14.04
------------

Ubuntu is **not** a supported production platform for SlipStream;
nonetheless, it can be used for development and testing.

These instructions assume that you are building the software on an
up-to-date, minimal Ubuntu 14.04 system.

All of the build dependencies can be installed directly with
``apt-get``. The following table lists the packages that must be
installed and describes how those packages are used within the build.

The command:

::

    $ apt-get install -y \
          git \
          openjdk-7-jdk \
          python-minimal \
          pylint \
          python-mock \
          python-nose \
          python-coverage \
          python-paramiko \
          rpm \
          createrepo

will install all of the listed packages.

+-------------------+-----------------------------------------+
| Package           | Comment                                 |
+-------------------+-----------------------------------------+
| git               | Download sources from GitHub            |
+-------------------+-----------------------------------------+
| openjdk-7-jdk     | Compile and run the server              |
+-------------------+-----------------------------------------+
| python-minimal    | Client CLI build and testing            |
+-------------------+-----------------------------------------+
| python-devel      | Needed for python module dependencies   |
+-------------------+-----------------------------------------+
| pylint            | Analysis of python code                 |
+-------------------+-----------------------------------------+
| python-mock       | Mocking library used in unit tests      |
+-------------------+-----------------------------------------+
| python-nose       | Unit testing for python code            |
+-------------------+-----------------------------------------+
| python-coverage   | Coverage testing for python code        |
+-------------------+-----------------------------------------+
| python-paramiko   | SSH library for python                  |
+-------------------+-----------------------------------------+
| rpm               | Creates binary distribution packages    |
+-------------------+-----------------------------------------+
| createrepo        | Create local yum repository             |
+-------------------+-----------------------------------------+

.. important:: 

    Running the tests requires Java 1.8 to run. Either you can install
    Java 1.8 from an unofficial repository or simply skip the tests
    using the maven ``-skipTests`` option.

The SlipStream RPM packages will be built if you install the ``rpm`` and
``createrepo`` packages; however, they cannot be used to install and run
the SlipStream server. Follow the instructions for running a test
version of the server from the respository sources.

Build Tool: Maven
-----------------

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
    3.2.0.

Once you have downloaded and unpacked Maven, you can setup the
environment with:

::

    $ export MAVEN_HOME=<installation directory>/apache-maven-3.3.3
    $ export PATH=$PATH:$MAVEN_HOME/bin

The ``mvn`` command should now be visible. The software will build with
any maven version later than 3.2+.
