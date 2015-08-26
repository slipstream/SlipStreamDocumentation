---
title: Accounts
head-title: SlipStream Advanced Tutorial&#58; Accounts
---

SlipStream is a secure web application that allows individuals to
access one or more cloud infrastructures transparently. Separate
accounts are required for all users to allow them to keep their work
private and to protect their cloud credentials.

To work with SlipStream you must have:

  - A valid account on the SlipStream server and
  - An account on one or more cloud infrastructures.

SlipStream supports nearly all major cloud service providers and open
source cloud solutions.

> This tutorial assumes that you're using the SlipStream SaaS operated
> by SixSq at https://slipstream.sixsq.com.  If you're using another
> instance, just replace the SaaS endpoint with your endpoint.
{: .tip}

> Most of the tutorial is independent of the chosen cloud providers,
> but where necessary for concrete examples, this tutorial will
> provide instructions for the [Exoscale][exoscale] and
> [Ultimum][ultimum] cloud infrastructures.
{: .tip}

# SlipStream Account

You can register for a SlipStream account directly through the
service.  The procedure follows the usual steps for web application
registration and hopefully is clear without instructions.  Just in
case the details are:

  1. Fill in the registration form on the SlipStream [welcome
     page][ss-endpoint]; you only need to provide a username and an
     email address.
  2. You will receive an email to verify the email address that you
     provided. 
  3. Visit the URL provided in that email, either by clicking on the
     link or copying it into your browser. 
  4. You will see a web page acknowledging that you've verified your
     email address. 
  5. You will then receive a second email with a temporary password
     for your account. 
  6. Visit the SlipStream [welcome page][ss-endpoint] and log in with
     your username and temporary password. 
  7. View your user profile by hovering over your username in the page
     header and then clicking on "Profile".
  8. Change your temporary password by clicking on "Edit", updating
     the password fields and then clicking on "Save".

You will also need to provide cloud credentials and optionally an SSH
public key to make full use of SlipStream.  The configuration steps
are provided below.

# Cloud Infrastructure Accounts

You will also need to provide the credentials for at least one cloud
infrastructure before being able to use SlipStream to deploy cloud
applications.

The procedure is similar for all cloud services, but you may need to
contact your cloud administrator for all of the necessary
configuration parameters.  The detailed procedure is provided for
Exoscale and Ultimum below. 

## Exoscale

If you need to create an account at Exoscale, you can visit their
[registration page][exoscale-register].

Once you've obtained your account with Exoscale, then you'll need to
provide your Exoscale credentials to SlipStream.  To find the
information you need in the Exoscale portal:

  1. Click on the "Account" icon on the left after logging into the
     Exoscale portal. 
  2. Click to open the "API Keys" tab.
  3. You will need to the "API Key" and "Secret Key" for the
     SlipStream configuration. 

Add your Exoscale credential to your SlipStream account:

  1. Open your user profile.
  2. Click on "Edit".
  3. Open the section "exoscale-ch-gva" by clicking on the section
     header.
  4. Provide the "API Key" value in the "Key" field and the "Secret
     Key" value in the "Secret" field.
  5. Click on "Save".

You will now be able to use the Exoscale cloud with your account
through SlipStream. 

## Ultimum

If you need to create an account at Ultimum, you can visit their
[registration page][ultimum-register].

Once you've obtained your account with Ultimum, then you'll need to
provide your Ultimum credentials (username and password) to
SlipStream.  The username is your email address.  

Add your Ultimum credential to your SlipStream account:

  1. Open your user profile.
  2. Click on "Edit".
  3. Open the section "ultimum-cz1" by clicking on the section
     header.
  4. Provide values for your username (email), password, and "Project
     name (Tenant name).  Your "Project name" is the same as your
     username.
  5. Click on "Save".

You will now be able to use the Ultimum cloud with your account
through SlipStream. 

# Exercises

  1. Register for an account on the SlipStream server
  2. Configure your profile with your Exoscale and Ultimum accounts


[exoscale]: https://www.exoscale.ch
[exoscale-register]: https://exoscale.ch/register

[ultimum]: https://ulticloud.com
[ultimum-register]: https://console.ulticloud.com/registration/

[ss-endpoint]: https://slipstream.sixsq.com
