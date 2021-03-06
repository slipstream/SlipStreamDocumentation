Debugging
=========

Things go wrong.  That is just the nature of the world.  SlipStream
provides various methods for debugging problems when they arise.

When creating a new application, very often there are bugs in the
deployment scripts. Iteratively modifying the scripts through
SlipStream and redeploying the machines can cause unnecessary
delays. **If you have selected an option that lets failed deployments
continue to run**, you can instead:

1. Log into a failed deployment,
2. Setup the environment for the SlipStream client (see below),
3. Reset the abort flag with the ``ss-abort --cancel`` command, and
4. Update and rerun the deployment script(s)

This allows for a much faster development cycle. The deployment
scripts can be found in the directory ``/var/lib/slipstream``, with
names that correspond to each phase of the deployment.  The logs from
the initial execution of these scripts are below

-  ``/var/log/slipstream/client`` on Linux
-  ``%TMP%\slipstream\reports`` on Windows.

Once the problems in the deployment scripts have been ironed out, just
copy them back into SlipStream.

Modifying the Environment
-------------------------

SlipStream minimizes its footprint to avoid any unintended
interference with the deployed applications.  Because of this, you
must specifically setup the environment to make the SlipStream client
commands accessible.  Usually you will want to do the following::

    $ source /opt/slipstream/client/sbin/slipstream.setenv

You should then have all of the SlipStream client commands (all prefixed
with ``ss-``) in your path. All of the commands support the ``--help``
option to give you information about the command.

Major Client Commands
---------------------

There are actually just a few commands in the SlipStream client that are
used in deployment scripts and in debugging. The following table
summarizes them.

+----------------+------------------------------------------------------+
| ``ss-get``     | Retrieves a named parameter, waiting if the          |
|                | parameter has not yet been set.                      |
+----------------+------------------------------------------------------+
| ``ss-set``     | Sets the value of a named parameter.                 |
+----------------+------------------------------------------------------+
| ``ss-random``  | Generates a random string value and optionally sets  |
|                | a named parameter with this value.                   |
+----------------+------------------------------------------------------+
| ``ss-abort``   | Sets the deployment abort flag or clears it with the |
|                | ``--cancel`` option.                                 |
+----------------+------------------------------------------------------+
| ``ss-display`` | Sets a string in the run for display purposes.       |
+----------------+------------------------------------------------------+

All of the parameters used in the deployment must have been defined in
the components used in the deployment. Trying to set or get an undefined
parameter will cause the command to raise an error, which in turn aborts the
run.

.. important::

   Although the "parameter database" and the associated commands are
   quite simple, the fact that ``ss-get`` will wait for a value to be
   set allows it to act as a semaphore to coordinate the configuration
   scripts on different machines in a multi-node deployment.

.. admonition:: EXERCISES

   1. Log into a machine that has been deployed via SlipStream and
      setup the environment to access the SlipStream client.
   2. Understand the options and behavior of the major commands by
      looking through the ``--help`` text.
   3. Find the deployment scripts for the machine that you've
      deployed. Try executing them by hand to see what happens.
   4. Set and clear the abort flag for your deployment. How does the
      behavior of ``ss-set`` and ``ss-get`` change when the abort flag
      is set?
