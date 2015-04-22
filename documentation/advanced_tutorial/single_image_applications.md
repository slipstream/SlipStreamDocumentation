---
title: Single Image Applications
---

## Run an R Analysis Server

Advanced users and administrators can define appliances and services
that can be easily deployed by others.  One example is an RStudio
deployment that creates an R analysis server with a web browser
interface.  More information about RStudio can be found on their [web
site][rstudio].

Within SlipStream, navigate to the "examples/tutorials/rstudio"
module.  This module launches the predefined "rstudio-appliance" and
runs the deployment script to configure the machine.  The software
uses the user accounts defined on the machine for accessing the
server.  To remain secure, the deployment dynamically creates a user
account with a random password when the machine is deployed.  The
username and password are communicated to the user through the
SlipStream interface.

From the deployment module, click on the "Run" button to start.  This
will start an "orchestrator" to manage the deployment. The
orchestrator will then deploy the RStudio server.  You will see the
progress of the deployment in the "Run" dashboard for the deployment.
Once the server has been fully deployed, the message in the deployment
should change to "RStudio Server Ready!".

![RStudio Ready for Use](images/screenshot-rstudio-ready.png)

At this point, you can access the server via a web browser.  You can
find the address for the machine by hovering over the RStudio
deployment box.  You will be greeted by a login page requiring a
username and password.

You can find the credentials to use in the published deployment
parameters.  Open the accordian section titled "rstudio.1"; these are
the parameters tied to the RStudio server.  In these parameters, there
are two ("rstudio_user" and "rstudio_pswd") that provide the
necessary credentials.  Take a look at the following screenshot.

![RStudio Login Credentials](images/screenshot-rstudio-parameters.png)

Use those credentials to log into the RStudio web interface and you
should see the RStudio interface.  You can now use the deployed
machine for doing R analyses or just to play around.  Try out the
graphics demo by typing "demo(graphics)" at the console!

![RStudio Interface](images/screenshot-rstudio-interface.png)

To terminate the machine, you can just click the "Terminate" button in
the SlipStream interface.  Remember to save any information or data
you created outside of the machine before terminating it.


[rstudio]: http://www.rstudio.com
[torque]: http://www.adaptivecomputing.com/products/open-source/torque/
