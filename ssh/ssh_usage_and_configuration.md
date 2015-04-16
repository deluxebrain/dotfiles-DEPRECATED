# SSH Usage and Configuration

## SSH agent forwarding

**tl;dr;** Dont use SSH agent forwarding due to its associated security implications. Use `proxycommand` instead.

SSH agent forwarding allows you to access a chain of SSH servers without installing your private key onto any of them by chaining SSH authentication back to the originating SSH client.

With SSH agent forwarding, all authentication requests are forwarded back to the SSH client on your local machine. Agent forwarding creates a socket on each originating SSH server and sets its location in the `$SSH_AUTH_SOCK` environment variable. SSH access from tha SSH server out to other SSH servers is then authenticated via this socket back to the SSH client on your machine.

**Note SSH agent forwarding presents a security risk in that if the remote server is compromised the intruder can use the socket to authenticate across machines**

### Limiting SSH agent forwarding

Due to the risks associated with SSH agent forwarding, it should only be used when explicitly required and for trusted servers. Best practice is to disabled it system-wide, and then re-enable it per host.

```script
# Within /etc/ssh_config
AllowAgentForwarding no

# Within ~/.ssh/config
Host <my_trusted_host>
	ForwardAgent yes
```

### Using SSH agent

To allows password-less logins, the public key of the originating user will need to be installed into the `~/.ssh/authorized_keys` of each host in the SSH chain.

#### Command-line usage

* Use the `-A` option to enable agent forwarding.
* Use the `-t` option on all `ssh` commands that specify a command to be run to force a pseudo-tty to be attached and prevent it exiting after running the command.

To SSH to **Server3** via **Server1** and then **Server2**:
`ssh -A -t Server1 ssh -A -t Server2 ssh -A Server 3` 

#### SSH config usage

```shell
Host Jump
	HostName <some_ip> or <some_dns>
	User <my_user>
	ForwardAgent yes

Host Destination
	HostName <some_ip> or <some_dns>
	User <my_user>

# Use the -t option to prevent the SSH connection to Jump from exiting
ssh -t Jump ssh Destination
```

## SSH `proxycommand`

SSH `proxycommand` offers the same functionality as SSH agent forwarding  of connecting to SSH servers via a series of intermediaries. However, it has none of the security risks that comes with agent forwarding associated with the `$SSH_AUTH_SOCK`.

> As of OpenSSH version 5.4, the SSH `proxycommand` option can be run in a **netcat mode** that does not need the explicit use (nor installation) of the `netcat` utility.






### SSH port forwarding

## Some notes on SSH configuration

### Configuration files
SSH configuration is controlled through two files:

* `/etc/ssh/ssh_config` controls system-wide SSH configuration
* `~/.ssh/config` are user-overrides

It is also possible to specify an alternative configuration file using the `-F` option, e.g:
`ssh -F ~/.ssh/<alternative_config> <host>`

### Per-Host Configuration
SSH configuration for a particular system is controlled using the `Host` keyword. This matches on ip or dns and must be an exact case-sensitive match to what is typed at the command line.

#### Matching groups

The `Host` keyword allows matching of IP or DNS groups, e.g:

* `Host *.example.com`
* `Host 192.168.*.0`

#### Matching mulitple hosts

Match multiple hosts by specifying them on the same line, separated by spaces, e.g:

`Host <some_ip> <some_dns> <some_other_dns>`

#### Specifying default configuration

Defaults are specified at the end of the file and are used by **servers not matched by previous `Host` entries**.

E.g:
```script
Host <some_host>
	Port <some_port>
	...

# defaults for non-matched hosts
Port <some_other_port>
```

## SSH configuration examples

### Basic SSH access to server

```script
Host <my_alias>
	HostName <some_ip> or <some_dns>
	User <my_user>
	Port <my_port> # if not 22
	IdentityFile ~/.ssh/<my_key> # if not id_rsa
```

### SSH access to server with agent forwarding

* This section is required by other use-cases later on
* Agent forwarding should only be used with servers your **really** trust

```script
Host <my_alias>_with_forwarding
	HostName <some_ip> or <some_dns>
	User <my_user>
	IdentityFile ~/.ssh/<my-key> # if not id_rsa
	IdentifiesOnly yes
	ForwardAgent no
``` 

### Port forwarding to host accessible from SSH server

Use as follows: `ssh -N <my_alias> &`
Note that binding to a local port below 1024 will require `root`.

```script
Host <my_alias>
	HostName <ip_or_dns_of_ssh_server>
	User <my_user>
	IdentityFile ~/.ssh/<my_key> # if not id_rsa
	LocalForward <local_port> <remote_host>:<remote_port>
```

### SSH to host accessible from SSH server

```script
Host <my_alias>
	HostName <ip_or_dns_of_remote_host>
	User <my_user>
	ProxyCommand ssh -W %h:%p <alias_of_ssh_server_with_forwarding>
```
