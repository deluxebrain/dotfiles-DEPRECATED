# Shell dotfiles

## Types of shell

### Interactive login shell
Executed as a result of a system login event - and is by its nature interactive

#### When is it executed?
* OSX Terminal sessions
* Spawned for `su -`
* `ssh` sessions

#### Read order for dotfiles
1. `/etc/profile`
2. Files in `/etc/profile.d/` directory
3. First of: `~/.bash_profile`, `~/.bash_login`, `~/.profile`
4. `~/.bash_logout` (only run with exit, logout or ctr-d) 

### Interactive non-login shell
Spawned for an already logged in user - does not represent a new login instance

#### When is it spawned?
* Linux Termain sessions
* `bash <script>`
* `su`

#### Read order for dotfiles
1. `/etc/bashrc`
2. `~/.bashrc`

### Non-interactive shell
Not directely associated with a terminal

#### When is it spawned?
* Shell scripts
* `cron`, `at`, etc

#### Read order for dotfiles
1. `$BASH_ENV` (if set)

Note that the `$BASH_ENV` environment variable is usually set to point to a file that links to `.bashrc`.

## Linux vs OSX terminal sessions
* Linux terminal sessions execute as an interactive non-login shell. This is because Linux windowing systems will have already executed the `.profile` dotfile as part of login.
* OSX terminal sessions execute as an interactive login shell. This is because OSX has a different approach to handling user environments and hence has not executed any dotfiles.

### A note on Linux desktop environment and dotfiles
As noted above, Linux windowing systems execute the interactive login dotfile chain as part of user login. However, this chain is usually different to that of terminal emulation and is as follows:

1. `/etc/profile`
2. `~/.profile`

In addition, the files are normally executed using the `dash` shell.

## Strategy to unify dotfile approach across platforms
1. Align OSX behaviour with Linux by forcing Terminal sessions to spawn an interactive non-login shell.
2. Setup environment in `.bashrc`
3. To support logging in remotely, create a `.bash_profile` which simply sources the `.bashrc`

### Caveats with unifying OSX and Linux dotfiles mechanism
Note that OSX spawning interactive login shells when launching Terminal is the correct behaviour as, unlike Linux, this actually represents the first Posix subsystem login event.

In addition, changing the OSX behaviour to spawn non-login shells has the side-affect that the full chain of dotfiles tied to a login shell is never read. Specifically, the `/etc/profile` is never executed and hence cannot be utilised as part of environment configuration.

However, within the context of the configuration of a development environment (as opposed to a server environment) the benefits of a unified dotfile mechanism out weighs this limitation.

### Forcing OSX to spawn non-login interactive shells
Use the `/usr/bin/login` utility to log specified user (`-f`) into the system using a non-login (`-l`) shell.

The `-f` options allows a specific shell to be specified (in this case `/bin/bash`).

> Note that this approach breaks the default OSX behaviour to automatically launch `ssh-agent` on demand within the spawned shell. `ssh-agent` therefore needs to be explicitly started in the dotfiles.

#### Spawning interactive non-login shell in Terminal  
1. Terminal ...
2. Preferences ...
3. General ...
4. Shells open with ...
5. Command: `/usr/bin/login -l -f <user> /bin/bash`

#### Spawning interactive non-login shell in iTerm2
1. iTerm ...
2. Preferences ...
3. Profile ...
4. General ...
5. Command: `/usr/bin/login -l -f <user> /bin/bash`

## Cross platform `ssh` identity management

On OSX, `ssh-agent` is integrated with `launchd` such that `ssh-agent` is automatically started on demand. In addition, `ssh-add` (with the `-K` option) adds the ssh identity and passphrase to Keychain, which is then used directly by `ssh-agent`. This prevents `ssh-add` from needing to be called again. 

> The auto launch `ssh-agent` behaviour is implemented by creating a socket on a system-wide `ssh-agent` instance and pointing the ssh agent forwarding environment variable (`$SSH_AUTH_SOCK`) at this socket. This environment variable is set by default by e.g. Terminal when lauching login shells (e.g. `echo $SSH_AUTH_SOCK`). 

This means that the *usual approach* on OSX (i.e. within `.bash_profile` for a login interactive shell) for ssh identity management is to **take no explicit action**. 

However, to provide a unified approach that works across platforms, shell types and terminal multiplexers (`screen`, `tmux`) identity management is made explicit by directly launching `ssh-agent` and telling it about keys using  `ssh-add`.   

## Overview of `.bashrc` and `.bash_profile` structure

> Due to the apporach of standardising on using interactive non-login shells, the `.bashrc` becomes the master dotfile

Certain steps are not necessary under all certain circumstances. I.e. these form a superset of commong steps across all platforms. 

1. Split `.bashrc` into interactive and non-interactive sections. 
	* The interactive session will be used for e.g. terminal sessions. 
	* The non-interactive sessions will use used for e.g. `cron` jobs in conjunction with the `$BASH_ENV`
2. Spawn (or attach to an existing) `ssh-agent`. As noted, this is not required under OSX when using the default login shell. 
3. Add ssh identities to `ssh-agent` using `ssh-add`. Note that certain display managers have hooks to automatically perform this step.
4. Source the `.bashrc` file from the `.bash_profile` file to ensure environment is setup for e.g. remote connections.
5. Check in `.bash_profile` if the file is being executed within an interactive login shell. Warn (`echo` to `stderr`) if so as this implies that the terminal emulator has not been configured correctly.

Note that the warning in the `.bash_profile` file will not affect desktop environment login as Linux windows systems execute the `~/.profile` file at login.

## Shell type identification
### Simple test for interactive shell
`[[ $- == *i* ]] && echo 'interactive' || 'non-interative'`

#### Notes

snippet		| description
---		| ---
`[[`		| test (without word splitting nor pathname expansion)
`$-`		| current options set for the shell
`s1 == s2`	| string s1 is identical to string s2, where s2 can be a wildcard pattern
`*`		| match any string of zero or more characters 

###  More structured test for interactive shell
```bash
case $- in
 *i*)	# interactive commands go here
	command
	;;
 *)	# non-interactive commands go here
	command
	;;
esac
```

#### Notes
	
snippet		| description
---		| --- 
`)`		| case values are demarcated with the `)` character
`|*?`		| case values can contain patterns
`;;`		| skip to `esac` keyword

### Testing for login shell
`shopt -q login_shell && echo 'login shell' || 'not-login shell'` 

#### Notes

snippet		| description
---		| ---
`shopt`		| control bash shell options
`-q`		| suppress output (quiet)
`login_shell`	| read-only shell descriptor set by the shell when it is a login shell

## Use of `$BASH_ENV` in non-interactive shells
When bash is started non-interactively (e.g. to run a shell script) it looks for the `$BASH_ENV` environment variable, expands its value and uses the expanded value as the name of a file to read and execute.

The `$BASH_ENV` variable is commonly set in shell scripts and `crontab` files to ensure that the shell environment is configured at time of execution. One common approach is point `$BASH_ENV` at a file that links to `.bash_rc`. Inturn, `.bash_rc` then detects whether it is being run interactively (or non-interactively) and configures the environment accordingly.
