Building Torque Packages
========================

Operating System Image
======================

The SlipStream™ client requires Python 2.5.0 or later with SSL support
and the Python httplib2 module. For this use case, we want to test
Torque on CentOS 5, a RedHat Enterprise Linux (RHEL) 5 clone. The
default version of Python shipped with CentOS 5 does not meet the
SlipStream™ requirements; therefore, we must create a new image that
contains the necessary SlipStream™ dependencies.

To create the new machine image (named "CentOS5\_32\_Base"), we create a
new machine image module with "Public/Images/CentOS 5" as the base
module. The following "pre-recipe" will then download the correct
versions of Python and httplib2, compile them, and install them on the
machine.

    #!/bin/sh

    SS_DIR=/var/slipstream
    LOCAL_DIR=$SS_DIR/local
    BUILD_DIR=$SS_DIR/build
    PYTHON_DIR=$LOCAL_DIR/python-2.5.4

    # Create directory to download and build dependencies.
    mkdir -p $BUILD_DIR
    cd $BUILD_DIR

    # OpenSSL development libraries must be installed for the
    # python compilation (with SSL) to work.
    yum -y install openssl-devel

    # Download good versions of python and httplib2.
    wget -nd http://www.python.org/ftp/python/2.5.4/Python-2.5.4.tgz
    wget -nd http://httplib2.googlecode.com/files/httplib2-0.4.0.tar.gz

    # Unpack the software.
    tar zxf Python-2.5.4.tgz
    tar zxf httplib2-0.4.0.tar.gz

    # Python needs to be patched to make sure that SSL is enabled.
    cat > Setup.dist.patch <<'EOF'
    --- Setup.dist.orig     2009-03-18 11:59:33.000000000 -0400
    +++ Setup.dist  2009-03-18 12:00:13.000000000 -0400
    @@ -199,14 +199,14 @@
     #_csv _csv.c
     
     # Socket module helper for socket(2)
    -#_socket socketmodule.c
    +_socket socketmodule.c
     
     # Socket module helper for SSL support; you must comment out the other
     # socket line above, and possibly edit the SSL variable:
     #SSL=/usr/local/ssl
    -#_ssl _ssl.c \
    -# -DUSE_SSL -I$(SSL)/include -I$(SSL)/include/openssl \
    -# -L$(SSL)/lib -lssl -lcrypto
    +_ssl _ssl.c \
    + -DUSE_SSL -I$(SSL)/include -I$(SSL)/include/openssl \
    + -L$(SSL)/lib -lssl -lcrypto
     
     # The crypt module is now disabled by default because it breaks builds
     # on many systems (where -lcrypt is needed), e.g. Linux (I believe).
    EOF

    # Actually patch the file.
    patch --ignore-whitespace Python-2.5.4/Modules/Setup.dist < Setup.dist.patch

    # Build python.
    mkdir -p $PYTHON_DIR
    cd Python-2.5.4
    ./configure --prefix=$PYTHON_DIR
    make
    make install

    # Build httplib2.
    cd $BUILD_DIR
    cd httplib2-0.4.0
    $PYTHON_DIR/bin/python setup.py install

The patch in the above script will enable SSL for Python. This
specially-compiled version of Python is installed in a separate
directory from the default system one and will not interfere with the
usual system configuration of CentOS 5.

To allow SlipStream™ to initialize a machine after the usual init.d boot
sequence, the SlipStream™ initialization script must be referenced from
the rc.local file. The module's "recipe" takes care of this
modification:

    #!/bin/bash

    # Insert SlipStream bootstrap script in rc.local. 
    # NOTE: This is has a different location in different operating systems.
    # For RHEL-based systems, it is the /etc/rc.d/rc.local file.
    /opt/slipstream/client/scripts/slipstream-prepare-bootstrap /etc/rc.d/rc.local

As a sanity check, the "execute" script of the module performs some
checks:

    #!/bin/sh

    # Check that the version of python is at least
    # 2.5.0.  This will return a non-zero return code
    # if the sys module doesn't exist or the version
    # is below the required 2.5.0.
    output=`python -c "import sys; sys.exit(sys.version_info[:3] < (2,5,0))"`
    if [ $? -ne 0 ]; then
      version=`python -c "import sys; sys.version"
      echo "Python version is below 2.5.0!"
      echo "Detected version is ${version}."
      exit 1;
    fi

    # Check that SSL support is actually available in
    # the default python version.
    output=`python -c "import socket; socket.ssl"`
    if [ $? -ne 0 ]; then
      echo "Python does not support SSL!"
      exit 1;
    fi

    # Check that the httplib2 module is available.
    output=`python -c "import httplib2"`
    if [ $? -ne 0 ]; then
      echo "The httplib2 module is not available!"
      exit 1;
    fi

    exit 0;

The script checks the Python version, the availability of SSL, and the
availability of the httplib2 module. Execution of this module creates a
CentOS 5 machine image suitable for use with SlipStream™.

Building Torque
===============

To avoid dependencies on third-party repositories, the Torque sources
have been uploaded to a location within Amazon S3. These sources are
then used to create the binary packages for the CentOS 5 operating
system.

To build Torque packages (RPM packages for CentOS 5), a "build" machine
image is created (named "Build") with the following execution script:

    #!/bin/sh

    # Temporary directory to hold build sources.
    BUILD_DIR=/tmp/build
    RESULTS_DIR=$BUILD_DIR/results

    # Directory where the reports will be written.
    SS_REPORTS_DIR=/tmp/slipstream/reports

    # Locations of the sources within S3. 
    S3_SRC_BUCKET=sixsq-sources
    S3_RESULTS_BUCKET=sixsq-results
    S3_TORQUE_SRC_RPM=${S3_SRC_BUCKET}:torque-2.3.6-1cri.sl5.src.rpm

    # Add the packages needed to build torque.  These are added
    # here rather than as image packages to avoid having a new
    # image built.
    yum -y install pam-devel tcl-devel

    # Ensure that the reports directory exists.
    if [ ! -d $SS_REPORTS_DIR ]; then
      mkdir -p $SS_REPORTS_DIR
    fi

    # Create a temporary directory for this build.
    mkdir -p $BUILD_DIR
    mkdir -p $RESULTS_DIR

    # Move to that directory and download the sources.
    cd $BUILD_DIR
    ss-download $S3_TORQUE_SRC_RPM

    # Install and build torque.
    rpm --install torque*.src.rpm
    rpmbuild -ba --define "osVersion CentOS5" /usr/src/redhat/SPECS/torque.spec

    # Copy the results back to the temporary directory.
    find /usr/src/redhat/RPMS -name torque\*.rpm -exec cp {} $RESULTS_DIR \;
    find /usr/src/redhat/SRPMS -name torque\*.rpm -exec cp {} $RESULTS_DIR \;

    # Upload all of the results back into S3.
    for rpm in ${RESULTS_DIR}/*.rpm; do
      RPM_NAME=`basename $rpm`
      ss-upload $rpm ${S3_RESULTS_BUCKET}:${RPM_NAME}
    done

Note that this script uses Amazon S3 to retrieve the Torque sources and
to store the packages created when executing this image. Modules
(images) that we create and use later will depend on the packages
created here. However, SlipStream™ will currently *not* manage these
dependencies because the files are handled outside of its control.

Note also that this image does *not* contain a pre-recipe or a recipe
script. This means that no actual machine image will be created. This is
often useful in cases where the machine configuration takes little time
to avoid the large latencies (at least 20 minutes) with creating a
machine image.

To run this script, a simple deployment (named "Build\_Deployment")
containing only the build image is created and executed. This creates
the torque packages for the CentOS 5 operating system. Subsequent
machine images will pull the necessary packages from Amazon S3 to
install them.
