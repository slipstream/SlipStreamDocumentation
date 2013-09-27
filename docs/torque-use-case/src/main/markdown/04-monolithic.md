Monolithic Deployment
=====================

Introduction
============

The simplest Torque deployment is to treat the same machine as a client,
worker, and server. This avoids all cross machine configuration and
transfer problems. Nonetheless, the scripts used to configure the
machine will be written anticipating that they will eventually be split
between different machines.

Machine Description
===================

As the machine configuration takes little time, we will put all of the
machine configuration into the execute script. This will avoid the large
latencies when creating a new machine image.

The machine configuration will install the Torque packages created via
the build deployment, configure the server, configure the client, and
launch the system test. The execute script is as follows:

    #!/bin/sh -x

    # Create a temporary area for batch system packages.
    mkdir -p /tmp/rpms
    cd /tmp/rpms

    # Download all of the packages from S3.
    ss-download sixsq-results:torque-client-2.3.6-1cri.CentOS5.i386.rpm
    ss-download sixsq-results:torque-2.3.6-1cri.CentOS5.i386.rpm

    # Install all of them.
    rpm --install *.rpm 

    # Determine the private hostname of the server.
    SERVER_HOST=`ss-get --exact server.privateDnsName`
    echo SERVER_HOST=${SERVER_HOST}

    # Write the server name into the pbs server configuration.
    cat <<EOF > /var/spool/pbs/server_name
    $SERVER_HOST
    EOF

    # Create a simple job script in a user account. 
    cat <<EOF > /home/userx/test.sh
    #!/bin/sh
    hostname
    hostname -f
    date
    EOF

    # Wait for the server to say that its configuration
    # has been completed.  (This is a blocking call.)
    ss-get --exact server.configuration.done

    # Determine the expected number of workers.
    WORKER_NUMBER=`ss-get --noblock --exact worker.multiplicity`
    if [ $? -ne 0 ]; then
      WORKER_NUMBER=1
    fi

    # Loop waiting for the number of 'up' nodes to be
    # equal to the number of configured workers.
    WORKERS_UP=`pbsnodes -l up | wc -l`
    while [ $WORKERS_UP -lt $WORKER_NUMBER ]; do 
      echo "${WORKERS_UP} of ${WORKER_NUMBER} workers available; sleeping..."
      sleep 15
      WORKERS_UP=`pbsnodes -l up | wc -l`
    done

    # Get the configured number of nodes and their states.
    date
    pbsnodes -a

    # Now try submitting the job.
    su --command="qsub test.sh" - userx

    # Wait a bit for it to finish and look at output.
    sleep 30
    qstat -f
    ls -l /home/userx/test.sh.*
    cat /home/userx/test.sh.o*
    cat /home/userx/test.sh.e*

    #!/bin/sh -x

    # Create a temporary area for batch system packages.
    mkdir -p /tmp/rpms
    cd /tmp/rpms

    # Download all of the packages from S3.
    ss-download sixsq-results:torque-mom-2.3.6-1cri.CentOS5.i386.rpm
    ss-download sixsq-results:torque-2.3.6-1cri.CentOS5.i386.rpm

    # Install all of them.
    rpm --install *.rpm 

    # Determine the full private name of the server.
    SERVER_HOST=`ss-get --exact server.privateDnsName`
    echo SERVER_HOST=${SERVER_HOST}

    # Write the server name into the pbs server configuration.
    cat <<EOF > /var/spool/pbs/server_name
    $SERVER_HOST
    EOF

    # Ensure that the temporary job area exists.
    # It must be owned by a group that contains 
    # all users.  The directory must have group
    # write permission.
    mkdir -p /var/spool/pbs/tmpdir
    chown root:users /var/spool/pbs/tmpdir
    chmod 0775 /var/spool/pbs/tmpdir

    # Configure the machine as a worker. 
    cat <<EOF > /var/spool/pbs/mom_priv/config
    \$pbsserver $SERVER_HOST
    \$tmpdir /var/spool/pbs/tmpdir
    \$logevent 255
    \$loglevel 7
    EOF

    # Ensure that the host key for the torque server is known
    # for non-interactive ssh access to server.
    ssh-keyscan -t rsa1,rsa,dsa ${SERVER_HOST} > /etc/ssh/ssh_known_hosts

    # Add all of the keys from the client machines as well.
    CLIENT_NUMBER=`ss-get --noblock --exact client.multiplicity`
    if [ $? == 0 ]; then

      # Configure for multiple clients.
      for i in `seq 1 ${CLIENT_NUMBER}`; do
        CLIENT_HOST=`ss-get --exact client-${i}.privateDnsName`
        ssh-keyscan -t rsa1,rsa,dsa ${CLIENT_HOST} >> /etc/ssh/ssh_known_hosts
      done
    else

      # Configure for a single client.
      CLIENT_HOST=`ss-get --exact client.privateDnsName`
      ssh-keyscan -t rsa1,rsa,dsa ${CLIENT_HOST} >> /etc/ssh/ssh_known_hosts
    fi

    # Restart all of the torque services.
    service pbs_mom restart

    #!/bin/sh -x

    # Create a temporary area for batch system packages.
    mkdir -p /tmp/rpms
    cd /tmp/rpms

    # Download all of the packages from S3.  For debugging,
    # the client commands are also installed on the machine.
    ss-download sixsq-results:torque-server-2.3.6-1cri.CentOS5.i386.rpm
    ss-download sixsq-results:torque-scheduler-2.3.6-1cri.CentOS5.i386.rpm
    ss-download sixsq-results:torque-client-2.3.6-1cri.CentOS5.i386.rpm
    ss-download sixsq-results:torque-2.3.6-1cri.CentOS5.i386.rpm

    # Install all of them.
    rpm --install *.rpm 

    # Determine the private hostname of the server.
    SERVER_HOST=`ss-get --exact server.privateDnsName`
    echo SERVER_HOST=${SERVER_HOST}

    # Write the server name into the pbs server configuration.
    cat <<EOF > /var/spool/pbs/server_name
    $SERVER_HOST
    EOF

    # Create the nodes file containing the worker host names.
    touch /var/spool/pbs/server_priv/nodes

    # Add all of the workers to the nodes file.
    WORKER_NUMBER=`ss-get --noblock --exact worker.multiplicity`
    if [ $? == 0 ]; then

      # Configure for multiple workers.
      for i in `seq 1 ${WORKER_NUMBER}`; do
        WORKER_HOST=`ss-get --exact worker-${i}.privateDnsName`
        cat <<EOF >> /var/spool/pbs/server_priv/nodes
    ${WORKER_HOST} np=1 cluster
    EOF
      done
    else

      # Configure for a single worker.
      WORKER_HOST=`ss-get --exact worker.privateDnsName`
      cat <<EOF > /var/spool/pbs/server_priv/nodes
    ${WORKER_HOST} np=1 cluster
    EOF
    fi

    # Create the server configuration file.  This MUST be fed
    # to qmgr for any of the settings to take effect. 
    cat <<EOF > /var/spool/pbs/server_priv/server.conf
    # Configure the queues for the server.
    #
    # Create queues and set their attributes.
    #
    #
    # Create and define queue short
    #
    create queue short
    set queue short queue_type = Execution
    set queue short resources_max.cput = 00:05:00
    set queue short resources_max.walltime = 00:10:00
    set queue short enabled = True
    set queue short started = True
    #
    # Set server attributes.
    #
    set server acl_hosts = $SERVER_HOST
    set server log_events = 511
    set server mail_from = adm
    set server scheduler_iteration = 600
    set server node_check_rate = 150
    set server tcp_timeout = 6
    set server scheduling = true
    set server default_queue = short
    EOF

    # Restart all of the torque services.
    service pbs_server restart 
    service pbs_sched restart

    # Actually configure the server. This must come AFTER the
    # server is started!
    qmgr < /var/spool/pbs/server_priv/server.conf

    # Permit all of the clients to submit jobs.  Add the host
    # names to the torque server configuration AND add them
    # to the /etc/hosts.equiv file.
    rm -f /etc/hosts.equiv
    CLIENT_NUMBER=`ss-get --noblock --exact client.multiplicity`
    if [ $? == 0 ]; then

      # Configure for multiple clients.
      for i in `seq 1 ${CLIENT_NUMBER}`; do
        CLIENT_HOST=`ss-get --exact client-${i}.privateDnsName`
        qmgr -c "set server submit_hosts += ${CLIENT_HOST}"
        echo ${CLIENT_HOST} >> /etc/hosts.equiv
      done
    else

      # Configure for a single client.
      CLIENT_HOST=`ss-get --exact client.privateDnsName`
      qmgr -c "set server submit_hosts = ${CLIENT_HOST}"
      echo ${CLIENT_HOST} >> /etc/hosts.equiv
    fi

    # Set a parameter to indicate that the server configuration
    # has been completed.
    ss-set configuration.done 1

    # Get the configured number of nodes and their states.
    date
    pbsnodes -a

    # Wait a couple of minutes.
    echo 'waiting for daemons to come up'
    sleep 120

    # Get the configured number of nodes and their states again.
    date
    pbsnodes -a

The log files from the server and client should also be saved. The
reports script will do that. It contains the following:

    #!/bin/sh

    # Location to save logs and reports for SlipStream.
    SS_REPORTS=/tmp/slipstream/reports

    # Ensure that the reports directory exists.
    mkdir -p ${SS_REPORTS}

    # Copy all of the torque (mom) logs into the reports area.
    cp /var/spool/pbs/mom_logs/* ${SS_REPORTS}

Deployment
==========

The deployment consists only of a single machine. The results will
consist of the script log file for the machine and the Torque log files.