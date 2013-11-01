
# Developers

SlipStream™ provides an ideal platform for deploying and testing
dynamic, near-production environments.  Multi-cloud support takes this
testing to the next level, allowing the behavior of systems to be
tested over the wide area network.

In this chapter, we show how SlipStream™ can be used to define a set
of tests for entire systems, how to debug deployments of systems, and
how to integrate SlipStream™ in your development process.

## Running Distributed Tests

This example will show you how to build a simple distributed test with
a client and a server running on separate machines.  The deployment
will consist of two machines: an Apache web server and a client.
During the tests we will inject data into the web server and then
verify that the data can be retrieved from the client.

The following text will highlight the important points in creating the
machine images and in the deployment.  The full information can be
found in the "examples/tutorials/service-testing" module of the
SlipStream™ server.

### Defining Images

Two images are defined for this deployment: one called "apache" and the
other "client".  In both cases, all of the software installation and
configuration is done as part of the deployment script to avoid the
long delays involved in creating new images.  Finalized deployments
would move that information into image creation recipes to reduce the
deployment latencies for end-users. 

The apache image deployment recipe simply installs and configures the
Apache server and then restarts it.  It adds a file `data.txt` to the
server containing a welcome string.  The server publishes via
SlipStream™ parameters the web server hostname, port, and flag
indicating that the server is ready.

The client image deployment recipe is equally simple.  It waits for
the relevant parameters to be set, then uses `wget` to retrieve the
file `data.txt` from the server.  If the download was successful, then
the "statecustom" flag is updated; if not, then the run is aborted.

If you have followed the examples from the previous chapters, creating
these types of images should be fairly straightforward.  You can see
all of the details in the "apache" and "client" modules in the
"examples/tutorials/service-testing" subproject.

> **Note that we run the shell script with the options `-e`, to exit
> immediately if any untested command fails and `-x`, to write each
> command to stderr before it is executed. This is a good practice for
> the execute target.**

### Recovering Reports

The process for testing the server and client mimics exactly what you
would do if you were doing it by hand.  However you are using
SlipStream™ to automate this process and you'll want to run the tests
and recover the results automatically.

To save the results, you can define a "report" script for each
machine.  This is defined in the "Report" tab of the "Deployment
Recipes and Coordination Parameters" section.  For the apache module
you will see the following script:

    #!/bin/sh -x
    cp /var/log/apache2/access.log $SLIPSTREAM_REPORT_DIR
    cp /var/log/apache2/error.log $SLIPSTREAM_REPORT_DIR

This copies the Apache access and error logs to the directory defined
by the `$SLIPSTREAM_REPORT_DIR` environmental variable.  This variable
is automatically set by SlipStream™ and any files in that directory
will be automatically copied back to the SlipStream™ server when the
deployment ends.

The report script for the client is even simpler:

    #!/bin/sh -x
    cp /tmp/data.txt $SLIPSTREAM_REPORT_DIR

This just copies the file downloaded from the server to the magic
directory to allow it to be recovered.

> **Note that for report script we have only used the `-x` option and
> not the `-e` option.  The allows as much logging information as
> possible to be collected, tolerating cases where certain logs or
> outputs are not available.  This maximizes the information retrieved
> from failed deployments.**

### Running the Test

The deployment module called "system" defines a system with one apache
server and one client by default.  It also links the output parameters
from the apache server to the input parameters for the client.
Running the deployment is simply a matter of clicking the "Run" button
as for all other deployments.

However before deploying the system, you should review the standard
termination behavior parameters in your user profile.  Looking in the
"General" section of your profile, you will find two important
parameters: 

![Termination Behavior Parameters](images/screenshot-termination-params.png)

One will tell SlipStream™ to leave the deployment running if an error
occurs.  This is useful for interactive debugging when deployments
fail.  The other will leave the deployment running if no errors
occur.  This is useful for production deployments of services.  In
this case, you will probably want to terminate the deployment in all
cases when it finishes.

Running the deployment will start all of the machine, run the tests,
collect the results, and tear down the system (if you have set the
approprate flags).  On the run page, there is a section titled
"Reports" that contains links to the reports that have been collected
for each machine.  Each linked file is a tarball containing all of the
report files for a given machine as well as the orchestrator.

### Scalability Tests

When running a deployment the number of machines of a given type can
be changed if the "Run..." button is selected.  In cases like this
example, this allows the number of clients to be increased allowing
scalability and performance tests to be easily done.

Note however the deployment must be created with multiple node
instances in mind.  Although you can increase the number of Apache
servers in this case, the deployment cannot take these into account.

## Debugging Deployments

When looking for the causes of a failed deployment, here are a few tips
and tricks that might help you identifying the source of the problem.

Most causes of deployment failures are due to faulty scripts. Here's a
method to avoid playing trial and error which can be time consuming in
finding the cause of the error:

1.  Instruct SlipStream™ to run forever if an error occurs. You can
    find this parameter in the "General" section of your user profile.
    With this selected, SlipStream™ will leave your machines running
    when an error occurs, so make sure you kill them manually.

    To terminate running machines, from the run page, click the
    "Terminate" button. You can also use the corresponding native
    cloud interface.

    > **Note that these settings will only affect new executions,
    > therefore, they will not affect already running machines.**

2.  Once you have made these changes re-run the failing deployment.
    Then, find the instance id of the failing machine. This id can be
    found in the *Runtime Parameters* list as
    `<nodename>.<index>:instanceid` and login to it using ssh:

        $ ssh -i <private-key> root@<machine ip address>

    where `<private-key>` is the private key corresponding to the public
    key you have configured in your SlipStream™ account.

3.  Once logged-in to the failing machine, configure the SlipStream™
    client environment. To do that, change to the following directory:

        $ cd /opt/slipstream/client/sbin

    and source the following file:

        $ source slipstream.setenv

    Your local environment should now be the same as the one when the
    SlipStream™ orchestrator runs your recipe. Currently, the SlipStream™
    command-line client will only work if you run from this directory.

4.  At this point, from a single node, you can re-run its execution
    script: `/tmp/tmp*`. However, if you're troubleshooting a
    deployment, it is likely that your deployment will already have
    failed, which includes the abort flag being set. This special flag
    is used to unblock all blocking calls to SlipStream™ to make sure the
    deployment workflow finishes in a controlled manner despite an error
    being detected. To reset the workflow, run the `ss-abort` command
    with the `--cancel` option.

        $ ss-abort --cancel

5.  From this point on, you should be able to execute your `execute`
    script which might help you to identify the source of the deployment
    failure.

Sometimes, you will also need to (re)set key/value pairs from the
current node or from other nodes. You can use the `ss-set` to set
values, as from the standard targets an recipes, as well as `ss-get`
to fetch key values.

## Continuous Integration with SlipStream™

The ability to automate complete system deployment and testing makes
SlipStream™ ideal for integrating with agile development processes.
Deployments can be launched either via a maven plugin or directly with
the REST API. 

### Maven Plugin

**TO BE COMPLETED...**

### REST API

**TO BE COMPLETED...**
