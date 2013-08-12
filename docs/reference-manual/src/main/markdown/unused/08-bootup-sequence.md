Image Boot-up Sequence
======================

Introduction
============

In this chapter, we describe the boot-up sequence that takes place on
SlipStream™ instrumented images. We take great care in minimizing the
intrusion our instrumentation our tools has on the normal behaviour of
the image, in order to ensure that the SlipStream™ instrumented images
behave as closely as possible to the normal deployment sequence you
expect when deploying your production system.

We first describe the boot-up sequence for Linux type systems. This will
be followed in future releases of SlipStream™ by Microsoft Windows and
Sun Microsystem's OpenSolaris.

Linux Instrumentation
=====================

rc.local...

Deployment Execution Sequence
=============================

This section describes the different stages each deployment goes
through.

1.  Initialisation

    During this execution phase, all machine boot-up and their hostname
    is published to the SlipStream™ information specific to this
    deployment instance. Once all machines have reached this stage, the
    sequence execution resumes with the execution of the `execute`
    target (if present).

2.  Finalisation

    Once the execute target has returned, whether with a zero or
    none-zero return code, each machine waits to all machines to have
    reached this stage. Once this final stage is reached, the `report`
    target is executed on all machines. This is the time to gather and
    compile the required information and a report bundle is uploaded to
    the SlipStream™ server for later viewing by the user. Once all
    machines have reached this step, we then conclude with the last
    stage.

3.  Termination

    This last stage informs the SlipStream™ orchestrator that the
    deployment has reached its end and the machines can be shutdown and
    released. The final status of the execution is set (i.e. Finished,
    Failed, Aborted), depending on the execution of the deployment.

You can follow the execution of the deployment by monitoring the
`exec.status` execution property on the execution web-page.
