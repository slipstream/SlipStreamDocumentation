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
