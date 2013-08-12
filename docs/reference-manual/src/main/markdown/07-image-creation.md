Image Creation Process
======================

SlipStream defines two types of images: Normal Images and Base Images.
Normal Images are images that SlipStream can build, extending other
images (i.e. base or normal). Base Images are images built outside of
SlipStream.

In this section, you will find specific instructions regarding the
creation of both types identified above.

Normal Image Creation Process
=============================

In this section, we describe the normal image creation workflow. This
means the workflow of an image creation, where the reference to this
image is an existing stock image. For the extended workflow of stock
image creation, see ? below. The internal image creation steps are as
follows:

1.  prerecipe execution. A user defined script to be run before the
    packages installation.

2.  package installation. One can provide a list of packages to be
    installed optionally specifying repositories and GPG keys.

3.  recipe execution. A user defined script to be run after the above
    packages installation.

Base Image Creation Process
===========================

For base image creation, please consult the corresponding cloud provider
or distribution documentation.
