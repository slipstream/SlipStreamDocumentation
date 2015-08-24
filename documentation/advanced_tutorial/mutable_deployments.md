---
Title: Mutable Deployments
head-title: SlipStream Advanced Tutorial&#58; Mutable Deployments
---

Very few, if any, applications experience a constant load.  Most
experience large fluctuations in the load, needing adjustments to the
allocated resources to maintain responsiveness at peak demand and to
avoid wasting resources when demand declines.

In this section you will learn how to:

  - Deploy an application that can be scaled
  - Scale the application through the API
  - Respond to resource changes to update configurations

# Mutable Runs

By default, the resource allocation of a deployment is fixed when the
deployment is started.  However clicking on the "Mutable Deployment"
option in run dialog will allow machines to be added or removed
dynamically through the SlipStream API.

When a run is mutable, the orchestrator will not be terminated when
the initial deployment finishes.  This necessary overhead allows the
orchestrator to respond to requests to add or remove nodes from the
deployment.

# Adding and Removing Nodes

When adding a node, you must specify the node type of the machine that
you want to add.  The server (and then orchestrator) will mutate the
deployment, provisioning the new node and then notifying all of the
machines in the application.

The notification takes place by running the "On VM Add" script (if it
exists) on all nodes.

As an example, we can deploy the LAMP++ application with its default
configuration, but marking it as a mutable deployment.  This will
result in a deployment with 6 nodes initially (1 load balancer, 2 web
front-ends, and 3 MongoDB nodes). 

The command to add a node of a particular type to a deployment is:

    $ ss-node-add f9390d34-10b1-4621-bd05-f4d8c7557754 web 1

After a provisioning cycle, you will see the additional node in the
deployment. 

![LAMP with 1 New Web Node](images/screenshot-lamp-scale-up.png)

When removing a node, you must specify exactly which node(s) you want
to remove.  The command for doing this is:

    $ ss-node-remove f9390d34-10b1-4621-bd05-f4d8c7557754 web 1 2

Similarly, the "On VM Remove" script will be run on each node when the
given node(s) have been removed.

Again after the (un-)provisioning cycle, the removed nodes will
disappear from the deployment. 

![LAMP with Web Nodes Removed](images/screenshot-lamp-scale-down.png)

# Mutability Scripts

Note that the current LAMP++ deployment is not designed for
mutability.  Although the nodes were added and removed from the
system, there are not any mutability scripts that handle a
reconfiguration of the overall system.

To support mutability properly, reconfiguration scripts must exist and
alter the service configuration appropriately.  Some information about
[how to write those scripts][mutability-scripts] is available from the
SixSq GitHub repository.

# Exercises

  1. Deploy your web server and client as a mutable run.
  2. Use the SlipStream client to add another client to the system,
     verifying that it sees the web server correctly. 
  3. Use the SlipStream client to remove one of the clients from the
     system, verifying that the machine has indeed disappeared.
  4. Deploy a mutable run, giving 0 as the number of machines for the
     clients.  Does this work?  Can you add these types of machines
     later? 
  5. Define the mutation scripts for your deployment and ensure that
     they are called when machines are added or removed.
  6. How would you collect information from the application to 
     automatically scale an application?

[mutability-scripts]: https://github.com/slipstream/SlipStreamClient/tree/master/client
