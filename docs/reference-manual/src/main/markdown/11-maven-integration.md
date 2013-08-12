Maven Integration
=================

What is Maven?
==============

Maven is an extensible framework which allows fine control over the
build and test process while supporting complete automation. Maven's
repository model is a particular strength, allowing the automatic
resolution of dependencies and providing a consistent mechanism build
coordination through the repository. More information about maven can be
found on the project's website.

Because of its widespread use, Maven has been integrated into many
continuous build tools, notably Hudson and Jenkins. Providing
integration of SlipStream with maven therefore offers the possibility of
integrating SlipStream actions into a build and test process built
around existing continuous integration tools.

SlipStream Archetype
====================

Maven is capable of generating skeletons of new projects based on
defined "archetypes". An archetype for a SlipStream module exists and
can be used to generate a working maven project that runs a given
SlipStream deployment. To use the archetype, run the following command:

    mvn archetype:generate \
      -DarchetypeArtifactId=slipstream-module \
      -DarchetypeGroupId=com.sixsq.slipstream \
      -DarchetypeVersion=1.0 \
      -Dslipstream-url=http://slipstream.stratuslab.eu \
      -Dslipstream-module=Tutorial/HelloWorld/client_server 

The first three parameters define the archetype to use; they are all
required. You may check for the latest version of the archetype by
searching in the maven central repository. The last two parameters are
optional and if not given, default values will be used.

When the command above is run, it will prompt for required values that
have not been specified. In particular, it will ask for a groupId and
artifactId for the module. These should follow standard maven
conventions. If the above command finished successfully, then it will
have created a subdirectory with the same name as the artifactId. You
can then descend into this subdirectory and perform the usual maven
commands:

    $ mvn install

which will run the given SlipStream module and install the deployment's
results as build artifacts. By default, the SlipStream deployment will
be executed during the integration-test phase.

Maven Plugin
============

A maven plugin is available from the central maven repository that
allows users to run a deployment module defined in SlipStream from
maven, to follow the evolution of the deployment, and to recover the
results from each node in the deployment. The results are registered as
artifacts of the maven build and will be uploaded into the defined maven
repository if the install or deploy phase is executed.

The simplest method for creating a maven module capable of running a
SlipStream deployment is to use the archetype defined in the previous
section. This will create a working skeleton capable of running a given
SlipStream deployment module.

To get information about the plugin itself and its parameters, you can
use maven's help plugin:

    $ mvn help:describe -Dplugin=slipstream -Ddetail

This will provide a listing of all parameters, their descriptions, and
their default values (if any).

    ...
    [INFO] com.sixsq.slipstream:slipstream-maven-plugin:1.0

    Name: SlipStream Maven Plugin
    Description: Sonatype helps open source projects to set up Maven repositories
      on https://oss.sonatype.org/
    Group Id: com.sixsq.slipstream
    Artifact Id: slipstream-maven-plugin
    Version: 1.0
    Goal Prefix: slipstream

    This plugin has 1 goal:

    slipstream:run-deployment
      Description: runs the specified deployment modules(s), adding the reports
        as project artifacts
      Implementation: com.sixsq.slipstream.SlipStreamMojo
      Language: java
      Bound to phase: integration-test

      Available parameters:

        deploymentModuleNames
          Name(s) of the deployment modules to run. If multiple modules are
          supplied, they will be run sequentially.

        pollIntervalInSeconds (Default: 15)
          Poll interval (in seconds) for checking the deployment status

        slipstreamServerId (Default: slipstream)
          SlipStream server ID used in the settings.xml file. This cannot be empty
          or null. The user's username and password must be available from the
          settings.xml file for this server ID.

        slipstreamServerUrl
          Root URL for the SlipStream server

    ...

The plugin must access the SlipStream server as a valid user,
consequently you must provide your SlipStream username and password to
the plugin. This is done through your settings.xml file, so that the
information does not need to be included in the pom.xml.

    <settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                          http://maven.apache.org/xsd/settings-1.0.0.xsd">
      <localRepository/>
      <interactiveMode/>
      <usePluginRegistry/>
      <offline/>

      <pluginGroups>
        <pluginGroup>com.sixsq.slipstream</pluginGroup>
      </pluginGroups>

      <servers>
        <server>
          <id>slipstream</id>
          <username>my_slipstream_username</username>
          <password>my_slipstream_password</password>
        </server>
      </servers>

      <mirrors/>
      <proxies/>
      <profiles/>
      <activeProfiles/>

    </settings>

The id in the settings.xml file must match the value given for the
slipstreamServerId parameter.
