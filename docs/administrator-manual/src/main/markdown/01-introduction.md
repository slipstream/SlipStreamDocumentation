Introduction
============

SlipStream™ captures information about machine images and system
deployments. It provides a mechanism for automatically deploying system
configurations and running a battery of tests against the deployed
configuration. Benefits of the system include:

-   Explicit capture of machine and system configuration, reducing the
    risk of information loss from personnel changes.

-   Improved reproducibility via defined machine and deployment
    "recipes".

-   Reduced effort by handling machine deployment and clean up
    automatically.

-   Better team cohesion and communication by making full deployment
    accessible to everyone in software production team.

Users (software developers, integrators, testers, and deployment
experts) interact with SlipStream™ via a web interface. They can define
their machine images system deployments via the web interface. Once a
deployment is defined, the user can launch an instance of the
deployment, run tests against it (either automatically or manually), and
then collect the test results.

The SlipStream™ system consists of four components: a server, a client,
a database, and a "cloud". The server acts as the central point of the
system, providing the web interface to users and acting as the contact
point for resources running in the cloud. The client interface, used
principally in machine images running in the cloud, permits command line
and programmatic access to the server. A database stores all of the
metadata related to the machine images and deployments. The "cloud"
contains computing and storage resources that are used to instantiate
dynamically system deployments.
