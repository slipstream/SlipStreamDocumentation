.. _dg-cfg:

Configuration
=============

To do anything useful with the local SlipStream server, you will need to
configure it.

You can either use the web UI that you just started, or use
:ref:`configuration files <dg-cfg-files>`.

User(s)
-------

During the initial startup of the server, an administrator account
("super") will be created. The initial password for this account is
"supeRsupeR". You should log in as this user, visit the profile page
(single user icon at top), and change the password to another value.

Alternatively, you can change the password on first server startup by
:ref:`dropping a password file in your configuration directory
<dg-cfg-files-password>`.

You can also create new user accounts by visiting the "users" page
(*Configuration* -> *Users* from top nav bar), or dropping user
configuration files in your configuration directory (see
:ref:`dg-cfg-files-user`).

Connector(s)
------------

Once the server is up and running you need to configure a connector
before trying to deploy a module. Out of the box, using the local
connector is the easiest way to get started. To do so, navigate to the
`server configuration page <http://localhost:8080/configuration>`__ and
define a cloud connector instance in the SlipStream Basics section:

::

    test-cloud:local

You must be logged in with an administrator account to do this. The
value of this field has the form "name1:connector1,name2:connector2";
multiple instances of a single connector are permitted. If the name
isn't given, it defaults to the connector name.

For configuration of other cloud connectors, check our
`blog <http://sixsq.com/blog/index.html>`__.

Alternatively, you can create new connector instance by :ref:`dropping
connector configuration files in your configuration directory
<dg-cfg-files-connector>`.

Load base images and apps modules
---------------------------------

The client module includes examples containing base images and tutorial
that can be loaded.

::

    $ cd ../../SlipStreamClient/client/src/main/python
    $ ./ss-module-upload.py \
          --endpoint http://localhost:8080 \
          -u test -p tesTtesT \
          ../resources/doc/*

Change the username and password to an existing (preferably
non-administrator) account.

You now only need to configure the cloud parameters of a user (e.g.
"test"). And add the cloud IDs to the native images (e.g. Ubuntu,
CentOS) you just created.

Building on these base images, you can `install
apps <https://github.com/slipstream/apps>`__ from the
`Nuvla™ <http://nuv.la>`__ service.
