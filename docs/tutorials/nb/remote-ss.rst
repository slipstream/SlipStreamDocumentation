Connection to a remote SlipStream
=================================

Connection/relation with SlipStream.

How NB connect to remote SS, tunneling

url NuvlaBox.com urls

References to SS... (KS). ../ss/slipstream-defined and others.

Tunneling to Remote SlipStream
------------------------------
By default tunnel is enabled, check contextualization in /etc/default/nuvlabox-tunnels

To stop and disable the SSH tunnel, run following command:
```sh
systemctl stop nuvlabox-ssh-tunnel
systemctl disable nuvlabox-ssh-tunnel
```

The username and host to use for the tunnels can be configured in the
file `/etc/default/nuvlabox-tunnels`. The most likely parameters to
be needed are ID and HOST.  See the command source for all parameters
that can be set.

**NOTE**: The host key of the remote SlipStream server needs to be in
the `known_hosts` file for the root account on the NuvlaBox.

### Configuration of Remote SlipStream Machine

The remote SlipStream must have a **non-root** account for the
NuvlaBox to use to connect.  That account should be a normal user
account with the NuvlaBox's root `id_rsa.pub` file in the
`authorized_keys` file.
