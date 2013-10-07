# Hello World: Simple Client/Server Tutorial

## Goal

The goal of this tutorial is to show you how to build a simple
distributed test with a client and a server running on separate
machines. We are going to use an Apache server as the server, put some
data into it, and then from a separate machine test that the data can be
accessed remotely. The end result, or the solution, of this tutorial can
be found in SlipStream™ in the public project
`Public/Tutorials/HelloWorld`.

## Create a New Project

To host the different modules we will create in this tutorial, first
create a new top level project. Simply click on the "Start" button on
the welcme page. If you have not logged-in, you will be asked to do so.
You will then be shown the root projects page, which will only list the
projects for which you have read access. To create a new project, click
the "New Project" button. Give this project a unique name. Fill-in the
form and save it. That's it; you have now created a new project. In this
new project, create another project called, say, "HelloWorld" in which
we will perform this tutorial.

The "Authorization" tab gives you access to the authorization for this
module. As you can tell, by default, the project is only visible to you,
as this is the default for each module you create. This means that
nobody else will see this project in the root project list. To share
this project with others, simply hit the Edit button, and check the
checkbox corresponding to `Read` either for `Public`, if you want to
share the all logged-in users, or `Group`, if you want to have finer
control of whom you want to share with. For Group, you will need to
provide a list of comma separated user names you want to share with.
Group definition will be inherited by default by all children of this
project, such that you don't have to repeat this information.

## Apache Server Machine Image Module

Now that we have a project to work in, we need to create a couple of
machine image modules: one for the server and another for the test
suite. You can do this by navigating to the new project you've created
in the previous step and clicking the "New Machine Image" button. This
will add a new image to the current project.

As with most forms in the application, you will see a summary tab,
followed by different more specialized tabs. In *view* mode, only the
parts that are defined are displayed, whereas in *edit* mode, all the
available tabs are displayed. For example, *Machine Image*s have two
specialized tabs: *Creation* and *Deployment*. Call this new machine
image `apache`. The following subsections provide information for the
other parts of the form.

As briefly explained in the introduction section, SlipStream™ supports
two main workflows: "image creation" and "deployment execution". The
advantage of creating new specific virtual machine is that during
execution, these machine will be up and running very quickly, at the
price of creating once a new machine, a process that can take several
minutes, depending on the cloud service you are using. Therefore, for
this tutorial, we will not create new machines but simply rely on the
deployment instructions (called *Target*s). We do however encourage you
to consider creating new machine images whenever appropriate to improve
the performance of you deployments. For this refer to the SlipStream™
Reference Manual.

## Image Reference

The *Reference* tab contains information specifying the mapping between
SlipStream™ machine image models (or templates) and real machine images
at the cloud service level. SlipStream™ supports the concept of
inheritance between machine image modules, which is a powerful feature
for building machines incrementally. For this tutorial however, we'll
start simple and base our image on an existing base image. A base image
in SlipStream™ is simply a module that points to an existing image, not
built by SlipStream™. You can see it as a bootstrap.

By default, SlipStream™ ships with references to a few base images, such
as Ubuntu, Fedora and CentOS. They are located in the
`Public/BaseImages` public project.

We will base our server and test suite machine images on the standard
Ubuntu image ([details](http://www.ubuntu.com)). To select this machine
image as the base image to our Apache server image, in edit mode, select
the *Reference* tab and click on the "Choose Reference" button. This
will bring up the *Chooser Window*. In this window navigate to the
`Public/BaseImages/Ubuntu/...` machine image and click on the "Select"
button. Don't save the newly created machine image yet - we will
continue working on it by defining input/output parameters. Actually, do
not worry if you do hit the save button. SlipStream will simply attempt
to validate the image and report any missing information as an error at
the top of the window.

## Instance Parameters

### Cloud Parameters

Virtual machine properties (e.g. number of CPUs, RAM, network, extra
disks) are defined and understood differently by the different cloud
providers. The
Parameters
tab includes a separate section for each available cloud. You only need
to configure the section that corresponds to the cloud service you
intend to use.
### Input/Output parameters

Using a IaaS cloud service, we cannot predict the IP address nor the
hostname of virtual machines before they are instantiated. While there
are common services to specify IP addresses, such as Amazon's Elastic
IP, they are limited in number. Therefore, it is not practical to
leverage such a service as a general solution since we would run out of
addresses very quickly.

To alleviate this problem, SlipStream™ embeds in the image boot-up
sequence a small script which will make available metadata to other
images running as part of the same deployment.

This discovery feature can be configured using *Input* and *Output*
parameters in the *Parameters* tab. Further, this feature also provides
a simple synchronization mechanism to control the order in which the
different services are brought up. For example, a client will wait for
the server it needs to contact to configure and start, while in turn the
server might need to wait for a database to initialize before it can
accept connections. We will see more of this feature in the test suite
client image creation section below.

SlipStream™ allows virtual machines to be synchronized. In our current
tutorial, we will want that the test suite only fires once the web
server is ready to accept connections. To do this, we use input/output
parameters.

Let's go back to our tutorial. Select the *Parameters* tab. You will see
that by default SlipStream™ provides `hostname` and `instanceid`
"Output" parameters. Now we will create a couple of other output
parameters. Click on the *Add Parameter* button at the bottom of the
"Output" section. Create this way a new parameter called `port` and the
other called `ready`.

The `hostname` and `port` parameters will be used to inform the test
suite how to connect to the web server, while the `ready` parameter will
tell it when the server is ready for the test to be executed.

We can also give some of our parameters default. In this case, give the
`port` parameter a default value of say, `8080`.

## Deployment

SlipStream™ supports the creation of new machine images. This can be
done using the *Creation* tab. However, for sake of simplicity, we will
not create new machine images here and rely on the machine image
deployment scripts, called *Target*s as defined in the *Deployment* tab.

### Targets

During the execution of a deployment, each image goes through a boot-up
sequence, where SlipStream™ executes user scripts. These user scripts
are called *Target*s. The currently available targets are: `execute` and
`report`. These targets can be defined using the "Targets" sub-section
in the "Deployment" tab of the image (in edit mode by clicking "Add
Target" button).

The target code is expected to exit with a zero (i.e. `0`) return code
for normal execution and a non-zero (i.e. `!0`) in the case of error or
failure. Returning a non-zero return code will set the abort flag the
run to *Failing*. The scripts can also sets the abort flag, using for
example the SlipStream™ command `ss-abort`). Once the abort flag is set,
the entire run will abort. See the Reference Manual for further details
on the deployment execution sequence.

The *execute* target is meant, as its name suggests, to execute a script
or a program corresponding to the behavior this image is meant to adopt
during a deployment. For example, if the image corresponds to a test
suite, the execute target will contain a call to execute the test suite.

While the *execute* target runs during the *Running* phase of the run,
the *report* target runs during the *Sending Report* phase of the run.
This is the right time to gather reports. Remember that by default
machines are released (i.e. destroyed) at the end of each run, which
means that it is a good idea to gather enough information in the reports
to help troubleshoot problems or to gather performance data for further
analysis. This information is archived on the SlipStream™ server.

You can configure SlipStream™ not to release the machines at the end of
the execution by changing your user configuration.

In this tutorial, we will use the *report* target in order to retrieve
the Apache logs to verify the correct execution of the server, or
investigate any errors reported during server access from the remote
test suite.

We can now add standard packages to our reference machine image. Select
the *Deployment* tab. Click on "Add Target" and select from the dropdown
list *execute* as the target name.

    #!/bin/sh -xe
    apt-get update -y
    apt-get install -y apache2

This recipe will simply update the packages installed on the system and
add the Apache web server to the system.

> **Note**
>
> Note that we run the shell script with -e (exit immediately if any
> untested command fails - "halt on an error" behavior) and -x (write
> each command to stderr before it is executed) parameters. This is a
> good practice for the
> execute
> target. Whereas, running
> report
> target with -e might not be a good idea as one would be interested in
> collecting as much logging info from the node as possible while
> tolerating cases when certain logs or outputs would not available.

Now we need to add some simple data to the Apache server for the test
suite to retrieve. We do this by appending to the script defined above
the following text:

    echo 'Hello from Apache deployed by SlipStream!' > /var/www/data.txt

This will simply add text to a data file available at the root of the
Apache server.

Another interesting modification to the Apache server is to change the
port on which the web server is listening. To do that, add the following
commands to our script:

    service apache2 stop
    port=$(ss-get port)
    sed -i -e 's/^Listen.*$/Listen '$port'/' /etc/apache2/ports.conf
    sed -i -e 's/^NameVirtualHost.*$/NameVirtualHost *:'$port'/' \
              /etc/apache2/ports.conf
    sed -i -e 's/^<VirtualHost.*$/<VirtualHost *:'$port'>/' \
              /etc/apache2/sites-available/default
    service apache2 start
    ss-set ready true

This will first stop Apache, so we can change its configuration. Then it
will retrieve the `port` parameter from the SlipStream™ server for the
specific run. For this we use the SlipStream™ command `ss-get`. We then
modify the configuration using the port value. After restarting the
Apache server, we set the `ready` parameter to `true`. This will inform
the test suite that the server is ready to accept connections.

Here is what the final script should look like:

    #!/bin/sh -xe
    apt-get update -y
    apt-get install -y apache2

    echo 'Hello from Apache deployed by SlipStream!' > /var/www/data.txt

    service apache2 stop

    port=$(ss-get port)

    sed -i -e 's/^Listen.*$/Listen '$port'/' /etc/apache2/ports.conf
    sed -i -e 's/^NameVirtualHost.*$/NameVirtualHost *:'$port'/' \
              /etc/apache2/ports.conf
    sed -i -e 's/^<VirtualHost.*$/<VirtualHost *:'$port'>/' \
              /etc/apache2/sites-available/default

    service apache2 start
    ss-set ready true

Now create a *report* target by clicking the "Add Target" button, then
select `report` from the drop down list and copy and paste the following
text in the text area:

    #!/bin/sh -x
    cp /var/log/apache2/access.log $SLIPSTREAM_REPORT_DIR
    cp /var/log/apache2/error.log $SLIPSTREAM_REPORT_DIR

This script copies the standard Apache log files (i.e. access and error)
to the standard reports area. The directory `/tmp/slipstream/reports` is
the default location in which the SlipStream™ client will expect the
reports to be when bundling and uploading the final reports to the
SlipStream™ server.

Now click the save button to commit your changes. You will be prompted
to provide an optional commit message. SlipStream keeps a copy of each
saved version of all modules (e.g. Project, Image, Deployment).
Therefore, you can always go back to previous versions of modules by
clicking the "other versions" link on the *Summary* tab on the "Version"
row. You will then see a list of all versions, with the save action
timestamp and an optional comment.

### Output Parameters

By default, when an image is created, SlipStream™ creates output
parameters called `hostname` and `instanceid`. At runtime, these output
parameters are automatically filled by SlipStream™ and will contain the
hostname of the image instance and the unique identifier of the instance
according to the cloud service used. This means that other images, as
part of the same deployment, will be able to find this image. In the
next section when defining the test suite (client) image, we will
leverage this feature.

Now that we have created an Apache machine image module to act as our
web server in our client/server tutorial, we next need to create the
corresponding client to contact this server.

## Test Suite Client Image Module

To go with the Apache server machine image we have created in the the
previous section, we will now build a client machine image module
containing a simple test suite client.

Since we now have a bit more experience with building images, here is a
more condensed set of instructions for the client image. Following the
same steps as for the Apache server, create in the same project a new
`Machine Image`. Let us call this new image "testclient".

### Image Reference

First, in edit mode, select the *Reference* tab and choose the same
Ubuntu image as for the Apache server machine image (i.e.
`Public/BaseImages/Ubuntu/...`) using the chooser button.

### Instance parameters

### Instance Type

Physical properties (e.g. number of CPUs, RAM, network) of running image
instances can be for each configured cloud. By default, the referenced
image values will be inherited.
### Input/Output parameters

As mentioned earlier, it does not make much sense for the test suite to
execute before the server is ready to accept connections. While we could
loop inside the test suite waiting for the server to respond, this is
not elegant, and it will not scale as we create more complex deployments
where, for example, a database must be up and running before the server
is ready to accept connections. Also we still do not know where the
server is, since we cannot predict virtual machine IP addresses. We will
use the synchronisation feature of SlipStream™ to provide
synchronization between our machines, without having to expose this
issue to our user code.

As we discussed when defining the Apache server image, the hostname for
each machine is automatically resolved by SlipStream™ during the early
part of the boot-up sequence. In order to leverage this, we simply need
to declare a new input parameter called, for example
`webserver.hostname`. Do this, in edit mode, by clicking on the
*Parameters* tab. We will see how this parameter is associated with the
`hostname` output parameter of the Apache server in the next section.
What is important to understand at this stage is that while we are
focusing on building a simple client/server deployment, the simple test
suite we are defining does not know about the specifics of the web
server image we have already created, nor does it need to. By creating
this input parameter, we are simply stating a requirement where this
input parameter must be resolved before this test suite can be executed.
It therefore does not know which image this requirement will be
fulfilled by.

Along the same lines, we'll need a `webserver.port
        ` and `webserver.ready` input parameters.

## Deployment

Under the *Deployment* tab, create a new `execute` target with the
following content:

    #!/bin/sh -xe
    # Wait for the metadata to be resolved
    web_server_ip=$(ss-get --timeout 360 webserver.hostname)
    web_server_port=$(ss-get --timeout 360 webserver.port)
    ss-get --timeout 360 webserver.ready

    # Execute the test
    ENDPOINT=http://${web_server_ip}:${web_server_port}/data.txt
    wget -O /tmp/data.txt ${ENDPOINT} && \
        ss-set statecustom "OK: $(cat /tmp/data.txt)" || \
        ss-abort "Could not get the test file: ${ENDPOINT}"

The above bash script simply uses the SlipStream™ command line client to
retrieve the `hostname` and the `port` parameters to use to connect to
the web server. It also reads the `ready` indicating that the server is
ready to receive connections. By default the `ss-get` command is
blocking, which means that the command will wait until the parameter is
set (or a timeout occurs) before returning. Then, we `wget` the default
web page and ensures that this retrieval was successful.

To make the demo a bit more lively, we then use the `ss-display` to
display information in the SlipStream™ dashboard. Under the hood, the
command simply sets the `statecustom` parameter.

> **Note**
>
> Instead of using the command-line interface, we could have used the
> Python API (we like Python at SixSq ;-), and created a PyUnit test
> case instead.

> **Note**
>
> For more details on the client command-line and Python API, refer to
> the SlipStream™ Reference Manual.

The script above will exit with a zero return code if the test suite
succeeds, or a non-zero return code if the assertion fails or another
error occurs in the script execution, such as if the SlipStream™ client
cannot reach the SlipStream™ server or if any parameter (e.g.
`webserver.hostname` in this case) is not defined.

Since the execution of this script already redirects the standard output
and error to the reports directory, we do not need to add a report
target to get the output of the test suite execution.

However, for the demonstration's sake, we may add the following report
target which would bundle the file downloaded from the server with the
execution report.
    #!/bin/sh -x
    cp /tmp/data.txt $SLIPSTREAM_REPORT_DIR

## Deployment Module to Run it All

Now that we have two machine image modules to work with, we will create
a deployment module to run these images to form our simple client/server
system test.

Go back to your project and click on the `New
    Deployment` button. Give it a sensible name, say `client_server`.
You will see that deployments have the concept of *Node*. A Node in
SlipStream™ is a group of running instance of the same image. For this
tutorial, we need to add two nodes corresponding to our Apache server
and our test suite. To do this follow these simple steps in edit mode:

1.  Add a new node, in the *Nodes* tab, by clicking on the "Add Node"
    button. This will open a chooser window. In the chooser, navigate
    and select your apache image. You will only be able to select an
    module of type `Image`. Now name this nods `apache`.

2.  Do the same for the test suite. As you can see, SlipStream™
    automatically pulls the input parameters of the selected machine
    image module for you to resolve. Call the node `testclient`.

3.  Set the "Linked to" field of the `webserver.hostname` parameter to
    `apache:hostname` (where "apache" corresponds to the name of the
    node you have given in the first step). This means that when the
    `apache`'s `hostname` parameter will be set as part of the node
    execution sequence, the `webserver.hostname` parameter of the
    "testclient" node will also be set, linking them together. The
    autocompletion dropdown will guide you to help choose the right
    parameter. Link the following `testclient` input paramters to
    `apache` as well: `webserver.port` to `apache:port` and
    `webserver.ready` to `apache:ready`.

4.  Save the deployment.

We are now ready to run our new test deployment.

## Execute Distributed Test

To launch the distributed test, simply click on the *Run* button of the
deployment you have created above. Sit back, relax and enjoy the show!

The execution instance created for each submission allows you to track
the progress of the deployment run. Once the deployment is completed,
you can access the reports generated by the different nodes, by clicking
on the *Results* link.

You can access all your runs by clicking on the "dashboard" link at the
top right of every page. To only list the execution of a given
deployment module, select the *Runs* tab. of a given deployment.

If you are wondering what the *Run...* button does, have a go. It will
allow you to change the default parameters, the number of instances for
each node and also change the cloud the different nodes will be deployed
on. If you are interested, continue with the *Performance Example using
Apache* tutorial.

Thanks for taking the time to learn about SlipStream™ and please if
there's anything we can do to improve this tutorial or the application
itself, don't hesitate in getting back to us at <support@sixsq.com>.
