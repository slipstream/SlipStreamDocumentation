Creating Machine Images
=======================

Prerequisites
=============

Note: before you start, you'll need valid EC2 credentials

EC2 Image Creation
==================

Start EC2 base instance. For example: Reference Ubuntu AMI id:
ami-6a57b203.

Note: Assuming you've followed to EC2 getting started instructions:

1.  Start an instance, using for example the Elasticfox plugin. Make
    sure you do the following to make sure you can access the resource:

    1.  select the gsg-keypair keypair so that you can be authenticated
        when loging-in

    2.  select the default security group, such that you have access to
        the resource from outside

2.  Login to it:

        ssh -i id_rsa-gsg-keypair root@<public-instance-address>

Adding ²One to the Image
========================

Download the base scripts for ²One (note that "2one.hopto.org" is a
place-holder for a publicly reachable):

    mkdir -p /opt/2one/client
    wget http://2one.hopto.org:8182/repository/release/2one/2OneClientPy/versions/latest/packages/2OneClientPy.tgz -O /opt/2one/client/2OneClientPy.tgz
    tar zxvf /opt/2one/client/2OneClientPy.tgz -C /opt/2one/client/
    cp /opt/2one/client/2OneClientPy/scripts/2one-node-execution.bootstrap /etc/init.d

this will add the bootstrap file in the bootstrap sequence (works for
Ubuntu!)

    update-rc.d 2one-node-execution.bootstrap defaults 99

Install the httplib2 Python library. If you're using a package manager,
the package is called python-httplib2. You can also find the
installation instructions here.

Adding your own code to the image
=================================

Now add the user behavior to the image:

1.  Create a script called: /root/2onesession/doit

2.  Make sure it is executable

This file is the entry point to your code. Here is the expected behavior
of the executable:

1.  For service images (i.e. not tests) this script should start
    programs, application and services in the background (e.g. using &
    at the end of the commands)

2.  For test images (which control the termination of the deployment
    execution), the test script should block until the test has
    completed.

3.  All valuable reports should be copied into the /tmp/2onereports
    directory (create it if necessary).

If your image doesn't require to run specific code (as in the Apache
example), but you want to retrieve important information like log files,
create a script /root/2onesession/prepare-reports (again make sure it's
executable). This script should copy all files to the /tmp/2onereports
directory (create it if necessary).

TODO: implement this service/test background thing as different
bootstrap script

Packaging the Image
===================

Still logged-in, execute the following instructions:

    cd /mnt

Copy your EC2 keys to your instance, for example:

    scp <user-name>@<home-server>:ec2-keys/*.pem .

Replacing the .pem files with yours, next bundle the instances as an
AMI:

    ec2-bundle-vol -k <pk-XXX>.pem -c <cert-XXX>.pem -u <Account-Number>

Your Account Number can be found at the top of the AWS Account Activity
page. But make sure you remove the "-" in the number.

You will be prompted for the image architecture or you can use the "-r"
option. You may also want to specify an image prefix to give the image a
descriptive name.

Upload the bundle to S3.

Note: For the moment, the target must be publicly accessible for ²One to
find it. This will be fixed in a future release when we introduce user
EC2 credentials (TODO):

    ec2-upload-bundle -b <S3-bucket-name> -m /tmp/image.manifest.xml -a <Your-Access-Key-ID> -s <Your-Secret-Access-Key>

Register the Image
==================

The image needs to be registered with EC2 so that it can find it. You
can do the registration from Elasticfox as well (just click on the white
cross with green background!), or from where you've installed the EC2
command-line client. Write down the unique AMI number that EC2 returns.
Using the EC2 command-line client, here's the command:

    ec2-register /tmp/image.manifest.xml

That's it you're done :-)

Create a new image instance in ²One
===================================

With the image created above, you can now instruct ²One to use it as
part of an automatic deployment. Here are the steps to do that.

Modelling in ²One
-----------------

Model the image in ²One. Here are the steps to do that:

1.  Create a new project or use an existing one

2.  Create a new image in that project

3.  Create a new version for this image

4.  If this image requires inputs and/or provides output to other images
    to use, define them in the version

5.  Assign the image type to AMI

6.  Set the image id to the id returned by the manifest registration
    step above

7.  Create a new deployment (in the same project or somewhere else)

8.  Create a new version for this deployment

9.  Select the in an existing new image and corresponding version in
    ²One (using the web interface).

Automatic Test Execution
------------------------

TODO

Miscellaneous Notes
===================

For creating an orchestrator image:

    wget http://2one.hopto.org:8182/repository/release/2one/2OneClientPy/versions/latest/packages/2OneClientPy.tgz -O /opt/2one/client/2OneClientPy.tgz
    tar zxvf /opt/2one/client/2OneClientPy.tgz -C /opt/2one/client/
    cp /opt/2one/client/2OneClientPy/scripts/2one-orchestrator.bootstrap /etc/init.local

this will add the bootstrap file in the bootstrap sequence (works for
Ubuntu!)

    update-rc.d 2one-orchestrator.bootstrap start 99 S .

Upload the bundle.

    ec2-upload-bundle -b meb.images/2one/orchestrator-ubuntu-8.04 -m /tmp/image.manifest.xml -a <Your-Access-Key-ID> -s <Your-Secret-Access-Key>

To update the tarball of the client on the rep (TODO: add this as a
target to the main build.xml file)

    tar zcvf /home/meb/workspace/2OneExecuctionService/repository/release/2one/2OneClientPy/versions/latest/packages/2OneClientPy.tgz 2OneClientPy
