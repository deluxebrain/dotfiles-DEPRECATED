# OpenVPN client configuration

Download the connection configuration file and move to `~/.openvpn/client.ovpn`.

Create a credentials file in `~/.openvpn/creds` and add username to firstline, and password the the second.

Edit the configuration file and add the credential file to auth-user-password:

```shell
auth-user-pass /Users/<user>/.openvpn/creds
```
