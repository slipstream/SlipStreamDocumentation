---
title: Configuration
---

Now that you have successfully started the SlipStream server, you will
need to configure it.  Most of this configuration can be done through
the web interface.

## Predefined Accounts

The following table describes the predefined accounts for a new
SlipStream installation.

| User| Password   | Description                                      |
|:----|:-----------|:-------------------------------------------------|
|super| supeRsupeR |  The initial administrator account for the       |
|     |            |  service.  This account can modify the server    | 
|     |            |  configuration and all modules.                  |
|     |            |                                                  |
|sixsq| siXsQsiXsQ |  Owner of pre-defined images and tutorials that  |
|     |            |  are "public" and available to all authenticated |
|     |            |  users.                                          |
|     |            |                                                  |
|test | tesTtesT   |  A test account with standard privileges.        |

**The passwords for these accounts should be changed immediately.** To
do so log into the server with the "super" account.  After logging in,
click on the "users" icon to see a list of users.  You should see a
list of users like the following screenshot.

![SlipStream Users Page](images/screenshot-users.png)

Click on the username, then on the "edit" button.  Fill in the new
password (twice) and click "save".  The password will be updated.  Do
this for all three accounts.

> Note that for the "super" account you will have to provide the
> current password.

## Configuration Parameters

Once the application is installed, a few parameters must be configured
before SlipStream can be used.  To set these parameters click on the
"wrench" icon at the top of the page.  You should see a configuration
page like the following.  Fill in the fields with the correct
information and click on the "save" button.

![SlipStream Configuration Page](images/screenshot-cfg-support.png)

More information for the setting the parameters for each section is
below.  You can also get more information within the interface by
clicking on the question mark bullet to the right of the parameter.

### Basic and Advanced Parameters

The *SlipStream Basics* and *SlipStream Advanced* configuration section
must be updated to reflect the current installation.  In these sections
replace all occurrences of *example.com* with the appropriate value.
All other parameters, with the exception of the *cloud connector*
value should be kept unchanged.

### Support Parameters

SlipStream needs to send out email notifications, for example when
validating email addresses during user registration.  These parameters
are set in the *SlipStream Support* section.

## Cloud Configuration

On the configuration page, there is one section for each supported
cloud.  If the type of cloud you want to use is not listed, then you
will have to install the connector for that cloud.

See the cloud connector chapter for the installation and
configuration.

## SSL Certificate

The SlipStream proxy is configured to force the use of HTTPS to
protect the transfer of sensitive information (e.g. the users cloud
credentials) while in transit.

The server will start with a self-signed certificate that is generated
during the initial startup of the proxy.  Most web browsers will warn
users about self-signed certificates and may require them to create
security exceptions to access services with those certificates.
Consequently, the generated certificate should only be used for
initial testing.

For production deployments, use of a commercial certificate signed by
a well-known certificate authority is very strongly recommended.  This
avoids the security warnings from browsers and makes user access to
your SlipStream service easier and more secure.

### Obtaining a Commercial Certificate

This section describes the typical process and commands for obtaining
a commercial certificate.  The process may be slightly different for
your chosen certificate provider, so always check your provider's
documentation. 

Before a commercial provider can sign your certificate, you must
generate a private key and a certificate signing request (CSR).  On
Linux systems, the following command will generate both:

    $ openssl req -nodes \
                  -newkey rsa:2048 \
                  -keyout server.key \
                  -out server.csr

The `-nodes` option is important to ensure that the key is **not**
created with a password.  This command with then prompt you for the
fields of the certificate's Distinguished Name (DN).  The Common Name
(CN) in the DN **must** match the DNS name of your server.

You must then send the CSR to your certificate provider.  This is
usually done via a web form or an email.  Your provider will then
return a signed certificate and optionally a bundle of certificates
that were used to sign your certificate. 

Verify that your certificate is in the X509 (`*.pem`) format.  The
following command should print the certificate information, if it is
in the correct format:

    $ openssl x509 -in server.crt -noout -text

If it does not, then you will need to use the `openssl` command to
change the format of the certificate.  

If your provider also returned a bundle of certificates used to sign
your certificate, then you will need to concatenate your certificate
and the certificates within the bundle.

    $ cat myserver.crt bundle.crt > server.crt

Change the names as appropriate.  **Your server certificate must be
first within the concatenated file.**

### Installing Your Certificate

To install your certificate with SlipStream, copy the certificate (or
concatenated file with the server certificate and the bundled
certificates) and key to the files `server.crt` and `server.key` in
the `/etc/nginx/ssl/server.crt` directory, respectively. **Both files
should be visible only to the `root` account.** Change the permissions
to `0400` for these files.

After installing the certificate, restart the nginx server.  Verify
that the certificate presented by the server contains the correct
information.  The easiest way to do this is to connect to the
SlipStream server with a browser and then click on the "lock" icon to
view the certificate information.  This is slightly different in each
browser.

The nginx installation manual contains complete information for
[configuring the proxy for HTTPS][nginx-https].  This documentation is
useful in case you run into errors when starting the proxy.

## Examples

A set of examples that demonstrate the main features of SlipStream
are installed with the `slipstream-client` package on the machine, but
are not installed in the service by default. 

To add those examples to the service, run the command:

    $ ss-module-upload \
        -u sixsq -p PASSWORD \
        --endpoint=https://slipstream.example.com \
        /usr/share/doc/slipstream/*.xml

replacing the password and endpoint with the values for your service.
This will upload all of the examples under the "sixsq" account.  These
will be visible in the "examples" project on the welcome page.


[nginx-https]: http://nginx.org/en/docs/http/configuring_https_servers.html 
