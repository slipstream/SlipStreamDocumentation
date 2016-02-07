Components Part II
==================

Now that you have a component that runs a web server, create a second
component that will run the tests against the server that you've been
running by hand.

In this section you'll exercise the knowledge from building the web
server in building the test client.  This shows how you can develop
and test components individually.

Testing Goals
-------------

To test the web server fully, you should check that the conditions in
the following table are true.

============ ============ ===========
Web Page     credentials? HTTP status
============ ============ ===========
unprotected         none         200
protected           none         401
protected          wrong         401
protected        correct         200
============ ============ ===========

Since the point of the exercise is learning about SlipStream and not
shell programming, you can use the following (inelegant!) script to
make the above tests.  The script takes three parameters: host,
username, and password::

    #!/bin/bash

    exit_code=0

    web_hostname=$1
    web_user=$2
    web_password=$3
    web_url_unprotected="http://${web_hostname}/"
    web_url_protected="http://${web_hostname}/protected/"

    # Check that web page responds with 200.
    rc=`curl -s -o /dev/null -w "%{http_code}" ${web_url_unprotected}`
    echo "Return code from unprotected page is " ${rc}
    if [ "${rc}" -ne "200" ]; then
      echo "Return code from unprotected page was not 200."
      exit_code=1
    fi

    # Check that web page responds with 401.
    rc=`curl -s -o /dev/null -w "%{http_code}" ${web_url_protected}`
    echo "Return code from protected page w/o password is " ${rc}
    if [ "${rc}" -ne "401" ]; then
      echo "Return code from protected page was not 401."
      exit_code=1
    fi

    # Check that web page responds with 401.
    rc=`curl -u ${web_user}:WRONG_PWD -s -o /dev/null -w "%{http_code}" ${web_url_protected}`
    echo "Return code from protected page w/ wrong password is " ${rc}
    if [ "${rc}" -ne "401" ]; then
      echo "Return code from protected page was not 401."
      exit_code=1
    fi

    # Check that web page responds with 200.
    rc=`curl -u ${web_user}:${web_password} -s -o /dev/null -w "%{http_code}" ${web_url_protected}`
    echo "Return code from protected page w/ password is " ${rc}
    if [ "${rc}" -ne "200" ]; then
      echo "Return code from protected page was not 200."
      exit_code=1
    fi

    # set the customstate to inform user about the result
    ss-set statecustom "Web client exit code: ${exit_code}"

    exit ${exit_code}

.. important::

   Be careful to escape variable references (or avoid them entirely)
   when writing the above script to the system. 

.. important::

   Also be careful to make the script you create executable with the
   command ``chmod a+x script_name.sh``!


Web Client
----------

Before developing your web client, you should ask yourself the
following questions to plan your attack strategy:

- Where should the above checking script be installed?
- Does the script need any additional software installed?
- What input and/or output parameters need to be defined? 
- How are the needed values obtained and passed to the checking
  script?
- What happens if the checking starts before the web server is ready?


.. admonition:: EXERCISES

   1. Create your own test client component.
   2. Run the client pointing to a non-existant server, what happens?
   3. Start your web server component.
   4. Using interactive debugging, verify that the test client works.
   5. Start a new client with the web server running, does the full
      test work correctly without any manual intervention? 
   6. Verify the correct behavior by downloading the reports.
