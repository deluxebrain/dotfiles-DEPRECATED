# SSH Usage and Configuration

## Some notes on SSH usage

### SSH agent forwarding

SSH agent forwarding allows all SSH access to a group of servers to be centralised through a single bastion server. This has the following benefits:

* It is only necessary to open up firewall access to the bastion server. The other servers are accessed via the bastion and hence do not require explicit external access.
* It is only necessary (nor possible) to copy your public key to the bastion server. Without agent forwarding, to access server B from server A would required your public key to be added to both servers (which in turn would require you to add your private key to server A).

With SSH agent forwarding, all authentication requests are forwarded back to the SSH client on your local machine. Agent forwarding creates a socket on the SSH server and sets its location in the `$SSH_AUTH_SOCK` environment variable. SSH access from the SSH server out to other machines is then authenticated via this socket back to the SSH client on your machine.

**Note SSH agent forwarding presents a security risk in that if the remote server is compromised the intruder can use the socket to authenticate across machines**

#### Limiting SSH agent forwarding

Due to the risks associated with SSH agent forwarding, it should only be used when explicitly required and for trusted servers. Best practice is to disabled it system-wide, and then re-enable it per host.

```script
# Within /etc/ssh_config
AllowAgentForwarding no

# Within ~/.ssh/config
Host <my_trusted_host>
	ForwardAgent yes
```

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
