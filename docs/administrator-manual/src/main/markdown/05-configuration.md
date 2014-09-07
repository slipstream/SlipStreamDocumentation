# Configuration

Now that you have successfully started the SlipStream server, you will
need to configure it.  Most of this configuration can be done through
the web interface.

## Predefined Accounts

The following table describes the predefined accounts for a new
SlipStream installation.

-----------------------------------------------------------------
User   Password    Description
-----  ----------  ----------------------------------------------
super  supeRsupeR  The initial administrator account for the 
                   service.  This account can modify the server 
                   configuration and all modules.

sixsq  siXsQsiXsQ  Owner of pre-defined images and tutorials that
                   are "public" and available to all authenticated
                   users.

test   tesTtesT    A test account with standard privileges.
-----------------------------------------------------------------

**The passwords for these accounts should be changed immediately.** To
do so log into the server with the "super" account.  After logging in,
click on the "users" icon to see a list of users.  You should see a
list of users like the following screenshot.

![SlipStream Users Page](images/screenshot-users.png)

Click on the username, then on the "edit" button.  Fill in the new
password (twice) and click "save".  The password will be updated.  Do
this for all three accounts.  Note: For the "super" account you will
have to provide the current password.

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

Sensitive credentials are passed between a user's browser and the
SlipStream server; the metadata describing machines and deployments
may also contain similarly sensitive information.  Consequently, the
SlipStream proxy is configured to force the use of HTTPS.

The server will initially start with a self-signed certificate that is
generated during the initial startup of the proxy.  For production
deployment, use of a commercial certificate signed by a well-known
certificate authority is very strongly recommended.

To obtain a commercial certificate, follow the instructions of your
chosen provider.  Most providers will deliver the certificate and key
as a pair of files in the X509 format (`*.pem` files).  If not, you
will need to convert the delivered certificate and key to the X509
format.

To install your certificate with SlipStream, copy the certificate and
key to the files `server.crt` and `server.key` in the
`/etc/nginx/ssl/server.crt` directory, respectively.

NOTE: The key must **not** be password protected. 

NOTE: Both files should be visible only to the `root` account.  Change
the permissions to `0400` for these files.

After updating the certificate and configuration, restart the nginx
server.

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
