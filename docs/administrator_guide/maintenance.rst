Maintenance
===========

SlipStream, as for every service, needs proper care and feeding! This
chapter provides some information about best practices for this service.

Activity Overview
-----------------

When logged in as an administrator, you can get an overview of all
running deployments and virtual machines by visiting the dashboard. Just
click on the "dashboard" icon at the top of the page.

Log Files
---------

The Web service log files are located in ``/opt/slipstream/server/logs``.
For the API Service, they are located in ``/var/log/slipstream/ssclj``.
(The configuration of API Service logging is
driven by ``/opt/slipstream/ssclj/resources/log4j.properties``)
These are named by date and rotated daily (or when the service is
restarted). You should regularly review errors in the log to see if
there are configuration or resource problems.

Database Backups
----------------

The real value of a SlipStream instance is in the defined images and
deployments. These and a full history are kept in the HSQLDB database.
This database should be backed up regularly to avoid having any of this
valuable information lost.

Maintenance mode
----------------

SlipStream can be set in maintenance mode to prevent users to access it
and to display an explanatory message instead. Moreover the properly
HTTP code
(`503 <http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.5.4>`__)
will be returned so that search engines can handle that case correctly.

Enabling
~~~~~~~~

To enable the maintenance mode, edit the file
``/etc/nginx/conf.d/slipstream-extra/maintenance.map``.

::

    # This file define which IPs will receive an error page which explain that the application is in maintenance.
    # 0 - Maintenance disabled
    # 1 - Maintenance enabled
    # One IP per line

    default  0;

    # Localhost
    "~^127\.[0-9]+\.[0-9]+\.[0-9]+$" 0;

    # Autoconfig IPs
    # "~^169\.254\.[0-9]+\.[0-9]+$"  0;

    # Private subnets
    # "~^10\.[0-9]+\.[0-9]+\.[0-9]+$"  0;
    # "~^192\.168\.[0-9]+\.[0-9]+$"    0;
    # "~^172\.(1[6-9]|2[0-9]|3[0-1])\.[0-9]+\.[0-9]+$"  0;

On this file, you can define which IPs are affected or not by the
maintenance mode. On the original file above, everybody (``default``)
will be affected by the maintenance mode if you set it to ``1`` but
SlipStream can still be accessed from localhost
(``~^127\.[0-9]+\.[0-9]+\.[0-9]+$``) if you keep it to ``0``.

Then execute the following command:

::

    $ service nginx reload

Disabling
~~~~~~~~~

To disable the maintenance mode, you have to set ``default`` and all
custom IPs to ``0``. And then reload nginx (see command above).

Customize error pages
---------------------

All error pages are static files that you can find in
``/opt/slipstream/server/webapps/slipstream.war/static-content/error/``

Authentication keys
-------------------

Certificates for generation of authentication tokens are not
password-protected.  The new unencrypted certificates are by default generated
under ``/etc/slipstream/auth`` as part of the post-install script of
``slipstream-ssclj`` RPM.  Next time when RPM gets updated the files will not
be overwritten.

Regeneration of Authentication keys
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The authentication keys can be regenerated at any time. Check
``/opt/slipstream/ssclj/bin/generate-auth-keys.sh`` script for the details.

Only one service ``ssclj.service`` requires private key for encrypting the
authentication token. All other services require only public key for
decryption. Locations of both can be configured in their respective ``systemd``
configuration files or in the respective ``/etc/default/<service>`` files.

After the new keys are generated and/or their locations are updated in the
configuration files, restart the following services::

  systemctl restart ssclj slipstream ss-pricing

