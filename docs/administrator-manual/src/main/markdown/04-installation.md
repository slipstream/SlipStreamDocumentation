# Installation

Once the packages are available, installing the SlipStream™ server is
as simple as installing a package with `yum`.  After the installation,
the services can be started via standard SysV initialization scripts.

## Install Packages

The first step is the installation of the packages.  Just install the
package for the SlipStream™ server; it will pull in all of the
necessary dependencies including the database.

    $ yum install slipstream-server

The software will be installed in the `/opt/slipstream` directory and
the configuration files will be in `/etc/slipstream`.

## Start Database

After this start the database:

    $ service hsqldb start

The database files will be stored eventually in
`/opt/slipstream/SlipStreamDB/`.

**NOTE: The startup script will indicate that the start failed, but
the database is indeed running correctly.**

## Start SlipStream

Next start SlipStream™.

    $ service slipstream start

The server will automatically populate the empty database when the
service initialzes. 

You should now be able to contact the SlipStream™ server with a web
browser.  Note that the service will initially use a self-signed
certificate, so you may be warned by your browser about this.

You should be redirected to the login page that looks similar to
the following screenshot.  If so, you are ready to configure the
server.

![SlipStream™ Login Page](images/screenshot-login.png)
