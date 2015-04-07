---
title: Building from Sources
---

# Prerequisites

SlipStream has been tested and is working with the following versions:

* Java 1.7+
* Python 2.6+ (but not 3.0+)
* Maven 3

The software should build without problems on any Unix-like
environment (Linux, FreeBSD, Mac OS X, etc.).  However, the packages
will only be built on platforms supporting RPM.

# Build Dependencies

The primary platform used by the SlipStream developers is Mac OS X.
Production releases are compiled and packaged for CentOS 6.

## Mac OS X

We're going to assume you're running OS X with [Homebrew] and
[easy_install] available.  In this case, all of the necessary
dependencies can be installed with:

```
$ sudo easy_install pip
$ sudo pip install nose coverage paramiko mock pylint
```

These dependencies are needed to run the unit tests for the python
code. 

## CentOS 6

These instructions assume that you are building the software on an
**up-to-date, minimal CentOS 6 system**.  The build may work on other
distributions, but you may have to modify the packages or commands to
get a working version.

Several of the packages required for the build are not available in
the core CentOS 6 distribution.  You will need to configure your
machine to use the [EPEL 6 package repository][epel].

EPEL provides an RPM to do the configuration.  Just download the RPM
and install it with `yum`.

```
$ wget -nd <URL>
$ yum install -y <downloaded RPM>
```

You can find the URL and package name via the information in the "How
can I use these extra packages?" section on the [EPEL welcome
page][epel].

Most (but not all!) of the build dependencies can be installed
directly with `yum`.  The following table lists the RPM packages that
must be installed and describes how those packages are used within the
build.

A command like:

```
$ yum install -y [packages]
```

will install all of the listed packages.

| Package                      | Comment                                  |
|:-----------------------------|:-----------------------------------------|
| java-1.7.0-openjdk-devel     | Compile and run the server               |
| python                       | Client CLI build and testing             |
| python-devel                 | Needed for python module dependencies    |
| pylint                       | Analysis of python code                  |
| python-pip                   | Installation of python modules           |
| python-mock                  | Mocking library used in unit tests       |
| gcc                          | c-bindings for python module dependencies|
| git                          | Download sources from GitHub             |
| rpm-build                    | Creates binary distribution packages     |
| createrepo                   | Create local yum repository              |

There are a few python modules that must be installed with `pip`.  The
SlipStream code uses options and features that require more recent
versions than those packaged for CentOS 6.  The following table
provides details.  Use the command:

```
$ pip install nose coverage paramiko
```

to install all of these packages.

| Package    | Comment                             |
|:---------- |:------------------------------------|
| nose       | Unit testing utility for python code|
| coverage   | Coverage testing for python code    |
| paramiko   | SSH library for python              |

Lastly, the overall build is managed with Maven.  You will need to
download the [Maven distribution][mvn-download] (choose the most
recent binary distribution), unpack the distribution and modify the
environment to make the `mvn` command visible.

Once you have downloaded and unpacked Maven, you can setup the
environment with:

```
$ export MAVEN_HOME=<installation directory>/apache-maven-3.2.3
$ export PATH=$PATH:$MAVEN_HOME/bin
```

The `mvn` command should now be visible.  The software will build with
any maven version later than 3.0.2.

# Build Everything

Maven is used to control the build of all of the SlipStream
components.  To perform the full build, just drop into the
"SlipStream" repository that you've checked out and perform the usual
maven dance:

```
$ cd SlipStream
$ mvn clean install
```

This command will build and test all of the components.  If you wish
to skip the tests, you can add the option `-DskipTests` to the maven
command line.


[Homebrew]: http://brew.sh/
[easy_install]: http://python-distribute.org/distribute_setup.py

[epel]: http://fedoraproject.org/wiki/EPEL

