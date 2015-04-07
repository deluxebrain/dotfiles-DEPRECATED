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

### dotfile strategy
1. Align OSX behaviour with Linux by forcing Terminal sessions to spawn an interactive non-login shell.
2. Setup environment in `.bashrc`
3. To support logging in remotely, create a `.bash_profile` which simply sources the `.bashrc`

#### Caveats with unifying OSX and Linux dotfiles mechanism
Note that OSX spawning interactive login shells when launching Terminal is the correct behaviour as, unlike Linux, this actually represents the first Posix subsystem login event.

In addition, changing the OSX behaviour to spawn non-login shells has the side-affect that the full chain of dotfiles tied to a login shell is never read. Specifically, the `/etc/profile` is never executed and hence cannot be utilised as part of environment configuration.

However, within the context of the configuration of a development environment (as opposed to a server environment) the benefits of a unified dotfile mechanism out weighs this limitation.

#### Forcing OSX to spawn non-login interactive shells
Use the `/usr/bin/login` utility to log specified user (`-f`) into the system using a non-login (`-l`) shell.

The `-f` options allows a specific shell to be specified (in this case `/bin/bash`).

> Note that OSX normally starts an `ssh-agent` daemon when an interactive login shell is spawned by a terminal emulator. 
E.g. within a vanilla Terminal window `ssh-add -l` will work automatically without an `ssh-agent` daemon having to be explicitly started. **This is not the case when using a non-login shell** meaning the `ssh-agent` will need to be explicitly started using `eval $(ssh-agent)`.

##### Spawning interactive non-login shell in Terminal  
1. Terminal ...
2. Preferences ...
3. General ...
4. Shells open with ...
5. Command: `/usr/bin/login -l -f <user> /bin/bash`

##### Spawning interactive non-login shell in iTerm2
1. iTerm ...
2. Preferences ...
3. Profile ...
4. General ...
5. Command: `/usr/bin/login -l -f <user> /bin/bash`

#### `.bashrc` and `.bash_profile` structure
> See actual `.bashrc` and `.bash_profile` dotfiles

1. Split `.bashrc` into interactive and non-interactive sections. 
	* The interactive session will be used for e.g. terminal sessions. 
	* The non-interactive sessions will use used for e.g. `cron` jobs in conjunction with the `$BASH_ENV`
2. Source the `.bashrc` file from the `.bash_profile` file to ensure environment is setup for e.g. remote connections.
3. Check in `.bash_profile` if the file is being executed within an interactive login shell. Warn (`echo` to `stderr`) if so as this implies that the terminal emulator has not been configured correctly.

Note that the warning in the `.bash_profile` file will not affect desktop environment login as Linux windows systems execute the `~/.profile` file at login.

## Shell type identification
### Simple test for interactive shell
`[[ $- == *i* ]] && echo 'interactive' || 'non-interative'`

#### Notes
`[[`		: test (without word splitting nor pathname expansion)
`$-`		: current options set for the shell
`s1 == s2`	: string s1 is identical to string s2, where s2 can be a wildcard pattern
`*`		: match any string of zero or more characters 

###  More structures test for interactive shell
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
	
---	|	---
`)`	|	case values are demarcated with the `)` character
`|*?`	|	case values can contain patterns
`;;`	|	skip to `esac` keyword

### Testing for login shell
`shopt -q login_shell && echo 'login shell' || 'not-login shell'` 

#### Notes

---		|	---
`shopt`		|	control bash shell options
`-q`		|	suppress output (quiet)
`login_shell`	|	read-only shell descriptor set by the shell when it is a login shell

## Use of `$BASH_ENV` in non-interactive shells
When bash is started non-interactively (e.g. to run a shell script) it looks for the `$BASH_ENV` environment variable, expands its value and uses the expanded value as the name of a file to read and execute.

The `$BASH_ENV` variable is commonly set in shell scripts and `crontab` files to ensure that the shell environment is configured at time of execution. One common approach is point `$BASH_ENV` at a file that links to `.bash_rc`. Inturn, `.bash_rc` then detects whether it is being run interactively (or non-interactively) and configures the environment accordingly.
