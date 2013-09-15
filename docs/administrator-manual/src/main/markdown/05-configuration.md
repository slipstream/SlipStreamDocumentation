# Configuration

## Administrator Access

The system must contain a superuser that can modify all modules in the
system and create users. To provide the initial parameters for the
superuser, use the command `ss-init-superuser`. This command will prompt
you for the necessary information and create (or update) the superuser
information in the database. Either the database information can be
provided on the command line or given in the `config.properties` file.

## SSL Certificate

Sensitive credentials are passed between a user's browser and the
SlipStream™ server; consequently, the server must be configured to use
SSL. The metadata describing machines and deployments may also contain
proprietary information and be similarly sensitive. The server can
either be secured with a commercial certificate (signed by a well-known
certificate authority) or a self-signed certificate.

### Using a Commercial Certificate

A commercial certificate signed by a well-known certificate authority is
the easiest to configure. These certificates are trusted by default in
most browsers and by most java distributions. Follow the instructions of
your chosen provider to obtain a signed certificate. Usually, this
certificate is delivered in X509 form (`*.pem` file). To use this for
the SlipStream™ server it must be converted either to PKCS12 for JKS
format.

To convert, the certificate and key into a PKCS12 format do the
following:

    openssl pkcs12 -in name.crt -inkey name.key -o name.p12

The resulting file will contain both the certificate and key. Be sure to
remember the password used to secure the PKCS12 file.

To convert, to JKS (Java Key Store) format, do the following:

    keytool -cert name.crt -key name.key

The resulting file will contain both the certificate and key. Be sure to
remember the password used to secure the JKS file.

You do not need to set the `truststore.*` parameters when using a
commercial certificate.

### Using a Self-signed Certificate

The advantage of a self-signed certificate is that it can be created
with no cost. The disadvantage is that it is not trusted by default by
web browsers nor by the java distributions. The SlipStream™ server and
client can be configured to trust the self-signed certificate. Web
browsers will generally warn users that the certificate is not trusted,
but give the user the option to ignore the warning.

To create a self-signed certificate, do the following:

    openssl xxxx

or using the keytool command:

    keytool xxxx

Convert the certificate and key into either a PKCS12 format or JKS
format with the commands from the previous section.

You must also create a "trust store" containing the certificate of the
self-signed certificate. The generated trust store must also contain the
certificates from the usual list of trusted certificate authorities.
Locate the file `cacerts` in your java distribution. Create a new
keystore with the same certificates with the following command:

    keytool xxxx

If the `cacerts` file has not be modified on your system, the default
password will be "changeit". You can set the password for the new
keystore to be anything you would like. Now add the certificate from
your self-signed certificate to the new keystore:

    keytool yyyy

You must set the `truststore.*` parameters in the configuration file
when using a self-signed certificate.

## Web-based Configuration

### Email Configuration

### Cloud Configuration

