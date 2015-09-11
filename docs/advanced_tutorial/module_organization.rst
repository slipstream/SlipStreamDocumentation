Module Organization
===================

Once you have more than a few modules within SlipStream you will want to
start organizing them. SlipStream allows you to create "Project"
modules: essentially directories containing other "Project", "Image",
and "Deployment" modules.

Using "Project" modules, you can keep related images and deployments
together and organize your deployments into logical hierarchies. The
"examples" area shows a typical organization of modules and individual
application deployments.

.. important::

    Projects only provide "containment" of modules. The project
    organization does **not** imply any inheritance of values or
    configuration between modules in the project hierarchy.

Exercises
---------

Because the **root project is shared by all users**, it is recommended
that you create your own top-level project to hold your module
definitions.

1. Create your top-level project.
2. Verify that the project is available to you and not to others.
3. Verify that buttons for creating other modules are active
