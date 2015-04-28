---
title: Quick Installation
---

An automated installation script is available to install SlipStream and all of
it's dependencies on a CentOS machine.

This script will do the following actions on your machine:

- Configure SlipStream yum repositories
- Configure epel yum repositories
- Configure nginx yum repository
- Install SlipStream in /opt/slipstream
- Install HSQLDB in /opt/hsqldb
- Install nginx
- Install some other dependencies with yum and python-pip
- Disable SElinux
- Configure nginx, HSQLDB and SlipStream
- Replace the firewall configuration with the following:
  - Allow all outgoing packets
  - Allow loopback connections
  - Allow incoming ICMP requests
  - Allow incoming SSH connections (port 22)
  - Allow incoming HTTP connections (port 80)
  - Allow incoming HTTPS connections (port 443)
  - Deny all other incoming connections
  - Deny forwarding
- Start nginx, HSQLDB and SlipStream

These instructions assume that you will be using the prebuilt binary
packages for SlipStream.  If you want to build your own packages from
the source, refer to the Developer Guide.


## Run the quick installation script

If you are going to install the enterprise version of SlipStream you have
to install the certificate (yum-client.crt and yum-client.key) provided by
SixSq into `/etc/slipstream/`.

The following command will take care of the installation of SlipStream.

The placeholder `{edition}` has to be replaced by `community` or
`enterprise`.

The placeholder `{repokind}` has to be replaced by `snapshot`,
`candidate` or `release`

    $ curl -sSfL https://raw.githubusercontent.com/slipstream/SlipStream/master/install/slipstream-install.sh | bash -s {edition} {repokind}

Once the installation script is terminated a SlipStream server will be
running but without any connectors.

## Cloud Connectors

The quick install script installs all open-source connectors.

If you have installed the enterprise edition, you have to install all
connectors you have a license for.

To install connectors simply execute the following command.

The placeholder `{list of connector names}` has to be replaced by the
list (space separated) of connector names to install.

The placeholder `{repokind}` has to have the same value as in the previous command.

    $ curl -sSfL https://raw.githubusercontent.com/slipstream/SlipStream/master/install/ss-install-connectors.sh | bash -s -- -r {repokind} {list of connector names}

Once all needed connectors are installed, restart SlipStream with:

    $ service slipstream restart

## Testing the Service

You should now be able to contact the SlipStream server with a web
browser using HTTPS; the URL should be `https://your_machine/`.
You should be redirected to the login page that looks similar to
the following screenshot.

If everything looks good, you are ready to configure the server and
cloud connectors.

![SlipStream Login Page](images/screenshot-login.png)


