---
title: Installation
---

Installing the SlipStream server is as simple as installing the binary
packages with `yum`.  After the installation, the services can be
started via standard SysV initialization scripts.

These instructions assume that you will be using the prebuilt binary
packages for SlipStream.  If you want to build your own packages from
the source, refer to the Developers Guide.

## Yum repository configuration

The yum installer needs to be told where to find the packages.  To do
this download and install the following RPM package:

    $ wget -nd http://yum.sixsq.com/slipstream/centos/6/slipstream-repos-2.0-1.noarch.rpm
    $ yum install -y slipstream-repos-2.0-1.noarch.rpm

This will create the necessary yum configuration file in
`/etc/yum.repos.d`.  If you've built your own SlipStream packages, do
not install this RPM and instead use the yum configuration discussed
in the previous chapter.

You must also configure the machine for the [EPEL 6 repository][epel].
The instructions for doing this can be found in the build chapter.

Once these are in place it is a good idea to clear the cache and
update your system with:

    $ yum clean all
    $ yum update

You can verify that the packages are available by running the command: 

    $ yum search slipstream-server

If this doesn't return an entry with this RPM package, then you need
to correct your yum configuration.

## Install Packages

Once the yum system is setup, just install the package for the
SlipStream server and the underlying database.  These packages will
pull in all of the necessary dependencies.

    $ yum install -y \
        slipstream-server \
        slipstream-server-nginx-conf \
        slipstream-hsqldb 

This installs the software for the SlipStream server, proxy, and SQL
database.

The software for SlipStream will be installed in the
`/opt/slipstream/server` directory and the configuration files will be
in `/etc/slipstream`.

The simplest deployment puts the server, proxy, and database on the
same machine.  However other deployment configurations, such as those
for high-availability, are supported.  This is the reason that the
proxy and database dependencies are not included in the server
package.

## Start Database

After this start the database:

    $ service hsqldb start

The database files will be stored in `/opt/slipstream/SlipStreamDB/`.

**NOTE: The startup script will indicate that the start failed, but
the database is indeed running correctly.**

## Start SlipStream

Next start SlipStream.

    $ service slipstream start

The server will automatically populate the empty database when the
service initializes. 

## Start the Proxy

The SlipStream server runs behind an nginx proxy.  All of the
necessary configuration will have been installed with the above
packages.  The nginx server will need to be started:

    $ service nginx start

if the server wasn't already running before the installation.

The nginx configuration package will generate a self-signed
certificate for the server if one doesn't already exist.  For a
production deployment, you should replace the generated certificate
with a commercial one; restarting the nginx server after its
installation.

## Testing the Service

You should now be able to contact the SlipStream server with a web
browser using HTTPS; the URL should be `https://your_machine/`. 
You should be redirected to the login page that looks similar to
the following screenshot.

NOTE: If you're using the generated self-signed certificate your
browser may display a warning.  You'll have to manually accept this
certificate to proceed.

NOTE: The service is actually initialized only the first time it is
accessed.  Because of this, the response to the first request may take
some time (tens of seconds).

If everything looks good, you are ready to configure the server and/or
install cloud connectors.

![SlipStream Login Page](images/screenshot-login.png)

## Cloud Connectors

SlipStream provides a uniform interface to multiple cloud providers
through a set of "cloud connectors".  You must also install the cloud
connector packages for the clouds that you want to support through
your SlipStream server.  See the Cloud Connector chapter for the
additional dependencies and installation instructions for each
connector.
