Client Command Reference
========================

ss-abort
1
ss-abort
set the abort flag
ss-abort
--cancel
--quiet
--verbose
-h
|
--help
reason
Description
===========

The `ss-abort` command controls the abort flag for a deployment. The
reason for setting the abort flag can be set via the reason argument.

Options
=======

`--cancel`
:   Remove the abort flag. Useful when debugging on a remote node.

`--quiet`
:   Only print the minimum information.

`--verbose`
:   Prints additional information (default).

`-h`, `--help`
:   Show this message.

ss-get
1
ss-get
get key/value pairs from info sys restlet
ss-get
--ignoreabort
--noblock
--timeout
=
seconds
--quiet
--verbose
-h
|
--help
key
Description
===========

The `ss-get` command retrieve the value associated with the given key.
The command will normally block until a value for the given key has been
published or the timeout expires.

Options
=======

`--ignoreabort`
:   Ignore the abort flag if set. Normally all `ss-get` commands will
    fail if the abort flag is set.

`--noblock`
:   By default, the command will block until the requested value is
    published or until the timeout expires. This option turns off this
    blocking behavior.

`--timeout`=seconds
:   Maximum timeout (in seconds) for retrieving the value of the key.
    The default value is 60 seconds.

`--quiet`
:   Print minimal information.

`--verbose`
:   Print additional information (default).

`-h`, `--help`
:   Show this message.

ss-set
1
ss-set
set the value of a parameter
ss-set
--decrement
--quiet
--verbose
-h
|
--help
key
value
Description
===========

The `ss-set` command will set the parameter named by key to the given
value. The value is required unless the `--decrement` option is used. If
the `--decrement` option is used, the value will be ignored.

Options
=======

`--decrement`
:   Decrement the value of the named parameter. This implies that the
    current value of the parameter can be cast to an integer.

`--quiet`
:   Print minimal information.

`--verbose`
:   Print additional information (default).

`-h`, `--help`
:   Show this message.

ss-display
1
ss-display
display message in the dashboard
ss-display
-v
,
--verbose
-h
,
--help
message
Description
===========

The `ss-display` command is a convenience command to display a message
in the dashboard. It is useful to make the deployment more lively,
showing for example at which step the deployment scripts are at.

Options
=======

`-v`, `--verbose`
:   verbose level. Add more to get more details.

`-h`, `--help`
:   show this help message and exit

ss-execute
1
ss-execute
execute/trigger a run (i.e. image build, simple run, deployment)
ss-execute
-v
,
--verbose
-h
,
--help
module-uri
Full URL to the module to execute. For example
Public/Tutorials/HelloWorld/client\_server
Description
===========

The `ss-execute` executes/triggers a run (i.e. image build, simple run,
deployment).

Options
=======

`-v`, `--verbose`
:   verbose level. Add more to get more details.

`-h`, `--help`
:   show this help message and exit

`-u`, `--username`
:   SlipStream username

`-p`, `--password`
:   SlipStream password

`--cookie`
:   SlipStream cookie

`--endpoint`
:   SlipStream server endpoint

`--parameters`
:   Deployment or image parameters override. The key must be in a form:
    node-name:parameter-name. Several pairs can be provided comma
    separated

ss-module-get
1
ss-module-get
get/retrieve module definition as xml
ss-module-get
-v
,
--verbose
-h
,
--help
[module-uri]
Name of the module to list or show. For example
Public/Tutorials/HelloWorld/client\_server
Description
===========

The `ss-module-get` get/retrieves a module definition as xml.

Options
=======

`-v`, `--verbose`
:   verbose level. Add more to get more details.

`-h`, `--help`
:   show this help message and exit

`-u`, `--username`
:   SlipStream username

`-p`, `--password`
:   SlipStream password

`--cookie`
:   SlipStream cookie

`--endpoint`
:   SlipStream server endpoint

ss-run-get
1
ss-run-get
get/retrieve run as xml
ss-run-get
-v
,
--verbose
-h
,
--help
[run]
Run id to show. For example 0c1d1212-1753-47cf-9fb6-486bb9dd7873. By
default, lists all user runs
Description
===========

The `ss-run-get` get/retrieves a run definition as xml.

Options
=======

`-v`, `--verbose`
:   verbose level. Add more to get more details.

`-h`, `--help`
:   show this help message and exit

`-u`, `--username`
:   SlipStream username

`-p`, `--password`
:   SlipStream password

`--cookie`
:   SlipStream cookie

`--endpoint`
:   SlipStream server endpoint

ss-user-get
1
ss-user-get
get/retrieve user definition as xml
ss-user-get
-v
,
--verbose
-h
,
--help
[run]
user to show. For example joe. By default, lists all users, but requires
privileged account
Description
===========

The `ss-user-get` get/retrieves a user definition as xml.

Options
=======

`-v`, `--verbose`
:   verbose level. Add more to get more details.

`-h`, `--help`
:   show this help message and exit

`-u`, `--username`
:   SlipStream username

`-p`, `--password`
:   SlipStream password

`--cookie`
:   SlipStream cookie

`--endpoint`
:   SlipStream server endpoint

ss-module-put
1
ss-module-put
put/update a module definition as xml
ss-module-put
-v
,
--verbose
-h
,
--help
[module-uri]
Description
===========

The `ss-module-put` puts/updates a module definition as xml.

The [module-uri] argument is the name of the module to list or show. For
example Public/Tutorials/HelloWorld/client\_server

Options
=======

`-v`, `--verbose`
:   verbose level. Add more to get more details.

`-h`, `--help`
:   show this help message and exit

`-u`, `--username`
:   SlipStream username

`-p`, `--password`
:   SlipStream password

`--cookie`
:   SlipStream cookie

`--endpoint`
:   SlipStream server endpoint


