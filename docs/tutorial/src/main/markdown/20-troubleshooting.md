# Troubleshooting

## Debugging a failing deployment

When looking for the causes of a failed deployment, here are a few tips
and tricks that might help you identifying the source of the problem.

Most causes of deployment failures are due to faulty scripts. Here's a
method to avoid playing trial and error which can be time consuming in
finding the cause of the error:

1.  Instruct SlipStream to run forever if an error occurs. To do that,
    once logged-in, access your account by clicking on your username at
    the top right corner of the page. Click the Edit button and on that
    page in the *Properties* section, tick the *General On Error Run
    Forever* option. From now on, SlipStream will leave your machines
    running when an error occurs, so make sure you kill them manually.

    To terminate running machines, from the run page, click the
    *Terminate* button. You can also use the corresponding native cloud
    interface.

    > **Note**
    >
    > These settings will only affect new executions, therefore, they
    > will not affect already running machines.

2.  Once you have made these changes re-run the failing deployment.
    Then, find the instance id of the failing machine. This id can be
    found in the *Runtime Parameters* list as
    `<nodename>.<index>:instanceid` and login to it using ssh:

        ssh -i <private-key> root@<machine ip address>

    where `<private-key>` is the private key corresponding to the public
    key you have configured in your SlipStream account.

3.  Once logged-in to the failing machine, configure the SlipStream
    client environment. To do that, change to the following directory:

        cd /opt/slipstream/client/sbin

    and source the following file:

        source slipstream.setenv

    Your local environment should now be the same as the one when the
    SlipStream orchestrator runs your recipe. Currently, the SlipStream
    command-line client will only work if you run from this directory.

4.  At this point, from a single node, you can re-run its execution
    script: `/tmp/tmp*`. However, if you're troubleshooting a
    deployment, it's likely that your deployment will already have
    failed, which includes the abort flag being set. This special flag
    is used to unblock all blocking calls to SlipStream to make sure the
    deployment workflow finishes in a controlled manner despite an error
    being detected. To reset the workflow, run the `ss-abort` command
    with the `--cancel` option.

        ss-abort --cancel

5.  From this point on, you should be able to execute your `execute`
    script which might help you to identify the source of the deployment
    failure.

Sometime, you'll also need to (re)set key/value pairs from the current
node or from other nodes. You can use the `ss-set` to set values, as
from the standard targets an recipes, as well as `ss-get` to fetch key
values.
