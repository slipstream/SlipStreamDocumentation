
# Building SlipStream

SixSq provides binary packages for all versions of the SlipStream
server and the associated connectors.  You can use those packages to
avoid having to build and package the software yourself.  However, if
you want to use the bleeding edge version or create a customized
version, for example, use the instructions in this chapter.

If you are not building the software, skip to the next chapter for the
installation and configuration instructions.

## Build Dependencies

These instructions assume that you are building the software on an
**up-to-date, minimal CentOS 6 system**.  The build may work on other
distributions, but you may have to modify the packages or commands to
get a working version.

Several of the packages required for the build are not available in
the core CentOS 6 distribution.  You will need to configure your
machine to use the [EPEL 6 package repository][epel].

EPEL provides an RPM to do the configuration.  Just download the RPM
and install it with `yum`.

    $ wget -nd <URL>
    $ yum install -y <downloaded RPM>

You can find the URL and package name via the information in the "How
can I use these extra packages?" section on the [EPEL welcome
page][epel].

Most (but not all!) of the build dependencies can be installed
directly with `yum`.  The following table list the RPM packages that
must be installed and describes how those packages are used within the
build.

A command like:

    $ yum install -y [packages]

will install all of the listed packages.

Package                       Comment
----------------------------  -----------------------------------------
java-1.7.0-openjdk-devel      Compile and run the server
python                        Client CLI build and testing
python-devel                  Needed for python module dependencies
pylint                        Analysis of python code
python-pip                    Installation of python modules
python-mock                   Mocking library used in unit tests
gcc                           c-bindings for python module dependencies
pandoc                        Generates documentation from Markdown
texlive-latex                 For PDF versions of docs
texlive-xetex                 For PDF versions of docs
git                           Download sources from GitHub
rpm-build                     Creates binary distribution packages
createrepo                    Create local yum repository
-----------------------------------------------------------------------

There are a few python modules that must be installed with `pip`.  The
SlipStream code uses options and features that require more recent
versions than those packaged for CentOS 6.  The following table
provides details.  Use the command:

    $ pip install nose coverage paramiko

to install all of these packages.

Package     Comment
----------  ------------------------------------
nose        Unit testing utility for python code
coverage    Coverage testing for python code
paramiko    SSH library for python
------------------------------------------------

Lastly, the overall build is managed with Maven.  You will need to
download the [Maven distribution][mvn-download] (choose the most
recent binary distribution), unpack the distribution and modify the
environment to make the `mvn` command visible.

Once you have downloaded and unpacked Maven, you can setup the
environment with:

    $ export MAVEN_HOME=<installation directory>/apache-maven-3.2.3
    $ export PATH=$PATH:$MAVEN_HOME/bin

The `mvn` command should now be visible.  The software will build with
any maven version later than 2.2.1.

## Checkout Sources

Now that the build environment has been setup, you will need to obtain
the sources from GitHub.  Clone the sources (`git clone`) from the
following repositories into a common directory.

  * SlipStream
  * SlipStreamDocumentation
  * SlipStreamUI
  * SlipStreamServer
  * SlipStreamServerDeps
  * SlipStreamClient

You may need to setup a `.gitconfig` file for `git`.

The URL for each repository is the name of the repository prefixed by:

    https://github.com/slipstream/

For instance, to clone the SlipStream repository do:

    $ git clone https://github.com/slipstream/SlipStream

This URL creates a read-only clone of the given repository.

## SlipStream Versions

The git repositories will contain a number of branches and tags.  By
default, you will be on the `master` branch which contains the latest
development version.

You may want to build a specific release rather than the bleeding-edge
version.  To find all of the tagged versions, do:

    $ (cd SlipStream; git tag -l)

Choose the version you want from the list of tags.

Once you've chosen the tag you want to build, checkout the tagged
version of each of the repositories:

    $ export VERSION=2.0.3
    $ for i in SlipStream*; do (cd $i; git checkout $i-$VERSION); done

This will checkout the same version for all of the different modules.

## Build and Package

The build is managed from the SlipStream module.  Change into the root
of that directory and use it as your working directory.  Before
compiling all of the modules, you must build the master pom file and
install it in your maven cache.  Run the command:

    $ mvn clean install

This will download a (large) number of packages and then build and
install the master POM file.

**After you have built the master pom file**, then touch the file
`.slipstream-build-all`.  This will signal Maven to do a complete
compilation of all modules.

Just to make sure that everything is working correctly and to start
with a clean slate, do the following:

    $ mvn clean

This should download a bunch of Maven plugins and then finish with a
long list of modules that have been built successfully.  If not, you
will need to correct any problems before going on.

Now start the complete build with:

    $ mvn install

This will download a large number of build dependencies, but it should
eventually end successfully.

The default value for the `BUILD_NUMBER` is '0'.  This will show up in
the release number of the generated pacakges.  If for some reason you
want to set a different value, use the `-DBUILD_NUMBER=0` option,
replacing '0' with your value.

## Create Local Yum Repository

The easiest way to install the software is with `yum`, so we will
create a local yum repository with all of the generated packages.

In the directory containing all of the checked out repositories,
create a subdirectory called `ss-packages`:

    $ mkdir ss-packages

and then collect all of the generated packages in this directory.  The
shell magic for this is:

    $ find . -name \*.rpm -exec cp {} ./ss-packages/ \; 

It just copies each RPM package it finds into the `ss-packages`
subdirectory.

Now turn this subdirectory into a yum repository:

    $ createrepo ss-packages

This generates the repository metadata from all of the RPM packages.

Finally, configure the system to use this local repository.  Create
the file `/etc/yum.repos/local.repo` with the contents:

    [local]
    name=local
    baseurl=file:///absolute/path/ss-packages
    enabled=1
    gpgcheck=0

changing the `baseurl` value to the one appropriate for your system.
Check that the created packages are visible:

    $ yum clean all
    $ yum search slipstream-server

The response should indicate that the package was found.  If so, you
are ready for the installation. 

NOTE: If you're using your own package repository, **do not install
the `slipstream-repos` RPM** as described in the installation chapter.

[epel]: http://fedoraproject.org/wiki/EPEL
[mvn-download]: http://maven.apache.org/download.cgi
