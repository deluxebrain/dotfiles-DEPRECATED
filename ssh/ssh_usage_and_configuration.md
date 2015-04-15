# SSH Usage and Configuration

## Some notes on SSH usage

### SSH agent forwarding

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
