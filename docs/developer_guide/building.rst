Build Everything
================

Maven is used to control the build of all of the SlipStream components.
To perform the full build, just drop into the "SlipStream" repository
that you've checked out and perform the usual maven dance::

    $ cd SlipStream
    $ mvn clean install

This command will build and test all of the components. If you wish to
skip the tests, you can add the option ``-DskipTests`` to the maven
command line.

Local Yum Repository
--------------------

If you're using a CentOS machine, the build process will have created a
YUM repository containing all of the generated RPM packages.

Create the directory::

    $ mkdir -p /opt/slipstream

and then unpack the tarball there::

    $ cd /opt/slipstream
    $ tar -c /opt/slipstream zxf yum/target/SlipStream*.tar.gz

This will create the YUM repository in the location expected by the
quick installation procedure.
