---
title: Configuration from Files
---

At this point you have a naked SlipStream instance running on your
system. This is great, but you probably want a few basic configuration
items loaded for your instance to be useable and useful.

The following instructions describe how you can drive the entire
configuration of SlipStream by simply dropping a few files on the
file system and restarting the service.

The configuration files will only be loaded once, on an empty system.
It is therefore safe to restart the SlipStream service with modified
configuration files. A specific post request can be invoked to force
a reload of the files.

> If your SlipStream server is already, don't forget to restart
it for the configuration files to be loaded.
{: .warning}

## File System Structure

Initially, SlipStream will look for configuration files in the file
system to load. Typically, the loader will look for files in the
following locations, stopping at the first occurrence:

    /etc/slipstream/
    ~/.slipstream/

Inside this structure of the expected configuration is a follows:

| Configuration file    | Meaning                                |
|:----------------------|:---------------------------------------|
| `./slipstream.conf`   | Main configuration file                |
| `./connectors/*.conf` | Connector specific configuration files |
| `./modules/*.xml`     | Module definition files                |
| `./cloud-ids/*.conf`  | Unique cloud image identifiers         |
| `./users/*.xml`       | User definition files                  |
| `./passwords/*`       | User passwords                         |

Note that these files are not created by default during a standard
installation.

## Main Configuration File

The main configuration file is normally placed in /etc/slipstream
when performing a standard installation. The default values are taken from
the [system default] shipped with SlipStream.

If you want to override these defaults, a good place to start is from the [system default]
file, that you can modify and drop in one of the standard location (see previous
section). 

> Do not forget to rename the default file to `slipstream.conf`. 
{: .warning}


## Connector Configuration Files<a name="connector" />

Each connector can be configured by simply dropping a configuration file
in the `./connctors/` directory. While the same can be achieved using the
main configuration file, we recommend you split your connector configuration
in separate files. This method is also more configuration management
tool friendly, such as Puppet, Chef or Ansible.

The connector configuration file must include the `cloud.connector.class`
and the name given to the connector instance must be used to qualify
all other configuration parameter. Here is an example of a connector file
to configure the Exoscale cloud:

    cloud.connector.class = exoscale-ch-gva:cloudstack
    exoscale-ch-gva.endpoint = https://api.exoscale.ch/compute
    exoscale-ch-gva.zone = CH-GV2
    exoscale-ch-gva.quota.vm = 20
    exoscale-ch-gva.orchestrator.imageid = 605d1ad4-b3b2-4b60-af99-843c7b8278f8
    exoscale-ch-gva.orchestrator.instance.type = Micro
    exoscale-ch-gva.native-contextualization = linux-only

> Do not forget to have a `cloud.connector.class` key in each file. 
{: .warning}

You can have as many connector configuration files as you wish.

> If you are using the enterprise edition, makes sure you have the license
matching the number of connector instance configured.
{: .warning}


## Module Configuration Files

To load automatically module definitions (i.e. projects, images and deployments),
simply drop module files in the `./modules` configuration directory. These
files (now in xml and soon in json) can be retrieved from a live SlipStream
instance by simply GETting the module or appending `?media=xml` to the end of
a URL, either using your browser, curl or any other http tool.

**Loading Apps from Nuvla&trade;**

[Nuvla&trade;](http://nuv.la), a SlipStream service managed by SixSq, contains a number of
interesting apps you can take advantage of. You can download these following
a simple procedure. Once you have the xml files, simply drop them in the
`modules/` directory and restart your SlipStream service.

> Modules will only be loaded from file if no modules already exist.
{: .warning}

[More information about loading apps](https://github.com/slipstream/apps/blob/master/README.md)
is available. 

## Unique Cloud Identifier Configuration Files

As you build a full SlipStream system configuration, you will also need to
provide unique cloud identifiers, especially for base images. Typically, these
files will be cloud service specific. Here is an example of a unique cloud identifier
file for Exoscale:

    apps/Minecraft/minecraft-server = exoscale-ch-gva:aaabbbccc

where the key is the module to set, and the value is composed of a `:`
separated tuple, composed of the cloud service name and the unique cloud identifier.

> Ensure the cloud service name part of the value matches the cloud service
name defined via the `cloud.connector.class` configuration parameter.
{: .warning}


## User Configuration Files<a name="user" />

The last piece of configuration required to have a fully functional system
is one or several users. By default, SlipStream will create a privileged user
during the first startup of the service. But you can add more users to the system
dropping files in the `./users/` configuration directory.

As for modules (see above), user configuration files can be created GETting
existing users.

For security reasons, since user passwords are never transmitted over the wire once the user is
registered, a second set of configuration file is required to define the
user password.  Only a hashed version of the password is kept in the database.


## User Password Configuration File<a name="password" />

As mentioned above, the password of each user must be defined using separate
files, located in the `./passwords/` directory.  The file name must march the
username, without any extension. The file must only contain the password in
clear text.

Here is an example of the content of the password file for the user `test`:

    $ cat ./passwords/test
    test:Change_Me

You can also, using such a password file change the password of the `super`
user created automatically during the first execution of the service. However,
ensure that the file is in place before the first execution, or that no user
exist in the database.

> Ensure each password file has the exact same name as the user it corresponds
to, without any extension.
{: .warning}


[system default]: https://github.com/slipstream/SlipStreamServer/blob/master/jar-connector/src/main/resources/com/sixsq/slipstream/configuration/default.config.properties
