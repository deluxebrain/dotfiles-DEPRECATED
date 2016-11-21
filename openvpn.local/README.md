# OpenVPN client configuration

## Setup

Download the connection configuration file and move to `~/.openvpn/client.ovpn`.

Create a credentials file in `~/.openvpn/creds` and add username to firstline, and password the the second.

Edit the configuration file and add the credential file to auth-user-password:

```shell
auth-user-pass /Users/<user>/.openvpn/creds
```

## Sudoers setup

For convenience, you might want to add openvpn to the `sudoers` file to allow passwordless `sudo openvpn`. This is done in the `install` script.

Note - its easy to hose your `sudoers` file. If you do, it can be recovered though Finder (that has a separate security model):

1.  Open Finder, and allow the current user full access to the `/etc/sudoers` file
2.  Fix the sudoers file
3.  Restore the permissions

    ```sh
    chmod 0400 /etc/sudoers
    ```
