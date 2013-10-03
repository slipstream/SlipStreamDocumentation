
# Building SlipStream™

The core of SlipStream™ and some of the cloud plugins are available
under the open source Apache 2 license.  You can download the sources,
compile, and package the service yourself.

If you have bought a commercial license for the software, then a set
of precompiled packages will be provided.  In this case, you can skip
directly to the installation instructions in the next chapter.

## Build Dependencies

These instructions assume that you are building the software on an
**up-to-date, minimal CentOS 6 system**.  The build may work on other
distributions, but you may have to modify the packages or commands to
suit the system you are using.

Several of the packages required for the build are not available in
the core CentOS 6 distribution.  You will need to configure your
machine to use the [EPEL 6 package repository][epel].  EPEL provides
an RPM to do the configuration.  Just download the RPM and install it
with `yum`.

Most of the build dependencies can be installed directly with `yum`,
although some recent python modules will need to be installed with
`pip`.

The following table describes the RPM packages that must be
installed.  The table also describes how those packages are used
within the build.  A command like:

    $ yum install -y [packages]

will install all of the listed packages.

------------------------------------------------------------------
Package                   Comment
------------------------  ----------------------------------------
java-1.7.0-openjdk-devel  Used to compile and run the server.

python                    Needed for client CLI and testing

python-devel              Needed to build some python module
                          dependencies.

pylint                    For analysis of python code

python-pip                Used to install some python modules

gcc                       Compilation of some c-bindings for 
                          required python modules.

pandoc                    Pandoc system used to generate 
                          documentation in various formats from
                          markdown sources.

texlive-latex             Used to generate PDF versions of docs.

texlive-xetex             Used to generate PDF versions of docs.

git                       Source control system used to checkout
                          code from GitHub.

rpm-build                 Necessary to build binary packages.

createrepo                Necessary to create local yum
                          repository.
------------------------------------------------------------------

There are a few python modules that must be installed with `pip`.  The
SlipStream™ code uses options and features that require more recent
versions than those packaged for CentOS 6.  The following table
provides details.  Use the command:

    $ pip install nose coverage paramiko

to install all of these packages.

------------------------------------------------------------------
Package                   Comment
------------------------  ----------------------------------------
nose                      Unit testing utility for python code

coverage                  Coverage testing for python code

paramiko                  SSH library for python
------------------------------------------------------------------

Lastly, the overall build is managed with Maven.  You will need to
download the [Maven distribution][mvn-download] (choose the most
recent binary distribution), unpack the distribution and modify the
environment to make the `mvn` command visible.

Once you have downloaded and unpacked Maven, you can setup the
environment with:

    $ export MAVEN_HOME=<installation directory>/apache-maven-3.1.0
    $ export PATH=$PATH:$MAVEN_HOME/bin

The `mvn` command should now be visible.  The software will build with
any maven version later than 2.2.1.

## Checkout Sources

Now that the build environment has been setup, you will need to obtain
the sources from GitHub.  Clone the sources (`git clone`) from the
following repositories into a common directory.  You may need to setup
a `.gitconfig` file for `git`. 

------------------------
Repository              
------------------------
SlipStreamParent        
SlipStreamDocumentation 
SlipStreamMta           
SlipStreamUI            
SlipStreamServer        
SlipStreamServerDeps    
SlipStreamClient        
------------------------

The URL for each repository is the name of the repository prefixed by:

    https://github.com/slipstream/

For instance to clone the SlipStreamParent repository, do:

    $ git clone https://github.com/slipstream/SlipStreamParent

This URL will allow read-only clones of the given repository.

## SlipStream Versions

The git repositories will contain a number of branches and tags.  By
default, you will be on the `master` branch which contains the latest
development version.

Most likely you will want to build a specific release.  To find all of
the tagged versions, do:

   $ (cd SlipStreamParent; git tag -l)

Choose the version you want from the list of tags.

Once you've chosen the tag you want to build, checkout the tagged
version of each of the repositories:

    $ export VERSION=2.0.3
    $ for i in SlipStream*; do (cd $i; git checkout $i-$VERSION); done

This will checkout the same version for all of the different modules.

## Build and Package

The build is managed from the SlipStreamParent module.  Change into
the root of that directory and use it as your working directory.

In this directory, create and install the master pom file for the
build.  The command is:

    $ mvn install

This should download a bunch of Maven plugins and then end
sucessfully. 

Now, touch the file `.slipstream-build-all`.  This will signal Maven
to do a complete compilation of all modules.  Start the complete build
with: 

    $ mvn clean install -DBUILD_NUMBER=0 -DskipTests

This will download a large number of build dependencies, but should
eventually end successfully.  The "clean" is only necessary if a
previous build failed for some reason. 

## Create Local Yum Repository

The easiest way to install the software is with `yum`, so we will
create a local yum repository with all of the generated packages.

In the directory containing all of the checked out repositories,
create a subdirectory called `ss-packages`:

    $ mkdir ss-packages

and then collect all of the generated packages in this directory.  The
shell magic for this is:

    $ find . -name \*.rpm -exec cp {} ./ss-packages/ \; 

It just does a copy for each RPM package it finds. 

Now create the yum metadata for the repository:

    $ createrepo ss-packages

And finally, configure the system to use this local repository.
Create the file `/etc/yum.repos/local.repo` with the contents:

    [local]
    name=local
    baseurl=file:///absolute/path/ss-packages
    enabled=1
    gpgcheck=0

changing the URL to be the one appropriate for your system.  Check
that the created packages are visible:

    $ yum clean all
    $ yum search slipstream-server

The response should indicate that the package was found.  If so, you
are ready for the installation. 


[epel]: http://fedoraproject.org/wiki/EPEL
[mvn-download]: http://maven.apache.org/download.cgi
