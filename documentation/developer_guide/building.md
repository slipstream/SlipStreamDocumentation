---
title: Building from Sources
---

# Build Everything

Maven is used to control the build of all of the SlipStream
components.  To perform the full build, just drop into the
"SlipStream" repository that you've checked out and perform the usual
maven dance:

    $ cd SlipStream
    $ mvn clean install

This command will build and test all of the components.  If you wish
to skip the tests, you can add the option `-DskipTests` to the maven
command line.

# Create Local Yum Repository

If you're using CentOS 6, the easiest way to install the software is
with `yum`, so we will create a local yum repository with all of the
generated packages.

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

**NOTE**: If you're using your own package repository, **do not install
the `slipstream-repos` RPM** as described in the installation chapter.

[Homebrew]: http://brew.sh/
[easy_install]: http://python-distribute.org/distribute_setup.py

[epel]: http://fedoraproject.org/wiki/EPEL

