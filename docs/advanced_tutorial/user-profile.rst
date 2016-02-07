User Profile
============

You already saw and updated your user profile when you were
configuring your account earlier.  This page contains all of your user
parameters, several of which are worth pointing out explicitly.

.. image:: images/screenshots/profile-general-section.png
   :alt: Parameters in User Profile General Section
   :width: 70%
   :align: center

Important Parameters
--------------------

Default Cloud Parameter
~~~~~~~~~~~~~~~~~~~~~~~

The "Default cloud" parameter indicates which cloud infrastructure
will be used by default for your applications unless you specify
another cloud explicitly.

Keep Running Parameter
~~~~~~~~~~~~~~~~~~~~~~

The "Keep running after deployment" indicates what SlipStream will do
by default when it is finished deploying an application onto a cloud
infrastructure.  The default is "On success".  The possible values
are: 

- "On success"
    Leave the application running until you explicitly terminate it.

- "On error"
    Leave the application running only in the case of an error to
    allow you to debug the problems.

- "Never"
    Always terminate the application.

- "Always"
    Always leave the application running.

Pay attention to values that leave the applications running.  They
will continue to use cloud resources (and incur charges) until you
explicitly terminate them. 

Usage Email Parameter
~~~~~~~~~~~~~~~~~~~~~

The third parameter of interest is the "Cloud usage email" option. You
can choose either "daily" or "never".  If you choose daily, you'll
receive a daily reminder of your cloud resource usage.  This can be
useful reminder to stop applications that you've forgotten about!

Usage
-----

In the menu under your username, you can also find the "Usage" page.
This page gives you a summary of your cloud usage (per day) over
time.  This is the information that will be emailed to you if you
activated that option. 

.. image:: images/screenshots/usage.png
   :alt: Cloud Resource Usage Page
   :width: 70%
   :align: center

The usage is calculated each morning, so it will initially be empty.
It should show some activity tomorrow!

Events
------

SlipStream records events for important changes in the application
lifecycle.  These events can be used to understand the timeline of a
given application deployment.  All of the events related to your
account can be seen on the "Events" page, which can be found in the
menu under your username.

The page will look like the following screenshot.  You should have
events in the list related to the deployment of Wordpress from the web
interface tour. 

.. image:: images/screenshots/events.png
   :alt: Events Page
   :width: 70%
   :align: center

When trying to see events related to a particular application
deployment (run), visit the run page.  It contains a section with just
the events for that application deployment.

.. image:: images/screenshots/events-run.png
   :alt: Events Page
   :width: 70%
   :align: center

This page is also instructive because is shows the complete list of
application states.  From the events, you can also understand how much
time is spent in each state.

Help
----

You can also get help, by consulting the SlipStream documentation,
Knowledge Base, or by contacting SixSq directly.

.. image:: images/screenshots/help.png
   :alt: Getting Help
   :width: 70%
   :align: center

