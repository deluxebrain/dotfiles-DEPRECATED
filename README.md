# @deluxebrain does dotfiles

## Installation

Install as follows:

```sh
git clone https://github.com/deluxebrain/dotfiles && cd dotfiles
export HOMEBREW_GITHUB_API_TOKEN="<personal-access-token>"
./install | tee install.log 2>&1
```

Along the way - you will be asked the following:

-   To have exported your `HOMEBREW_GITHUB_API_TOKEN`
-   To enter your local machine account password
-   To enter your git username and associated email address
-   To add the newly generated ssh public key to your github account

## Symlinking

The dotfile synchronization model is based around symlinking files and directories in the dotfiles repository to their respective positions in the `$HOME` directory.
Two symlinking mechanisms are supported - which work for both files and directories:

1.  `<somepath>.symlink`

The path is symlinked into the `$HOME` directory as `$HOME/<somepath>` (i.e. with .symlink removed).

2.  `<somepath>.dotfile`

The path is symlinked into the `$HOME` directory as `$HOME/.<somepath>` (i.e. as a dotfile).

### Convenience symlinks

Note that the repository contains some symlinks back to directories in the repository as convenience directories. 

For example,`./lib` is a symlink to the `./lib.symlink` directory. This is to allow files within this path to be referenced at the time of installation using the path `./lib`. Obviously, post installation ( and hence post the setup of symlinks ), this is just performed using `$HOME/lib`. This symlink is created using the _relative_ option which prevents an other-wise absolute symlink being broken when cloned from Git into a different working directory. Relative symlinks are supported on revent version of the GNU coreutils ( as installed through Homebrew ), and created as follows:

```shell
gln -s --relative  <source> destination
```

## File organization

```shell
\Karabiner	| Karabiner and Seil setup and configuration
\bin.symink	| Standalone scripts
\completions	| Bash completions
\config.dotfile	| Powerline configuration
\cron		| Cron setup
\ctags		| ctag configuration
\environment	| Environment configuration, such as bash dotfiles
\git		| Git configuration, incuding hooks, etc
\iTerm2		| iTerm setup - dynamic profiles and that kind of thing
\install	| Installers
\lib		| Symlinked version of lib.symlink to allow the script library to be used as part of installation
\lib.symlink	| Bash scripts intended to be sourced into scripts (i.e. a library of re-usable functions for more complex scripts)
\linters	| Linters and style checkers
\osx		| OSX setup
\packages	| Homebrew, cask, pip, NPM packages
\shell		| Shell configuration (Bash dotfiles, etc)
\themes.dotfile	| Solarized theme for iterm, tmux, etc
\tmux		| Tmux configuration
\vim		| Vim setup, including Pathogen plugins as submodules
```

## Foundations

### Homebrew

#### Installing Homebrew

1.  Run the installer:

    ```shell
    # Install Homebew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    ```

2.  Check everything works by running the self-diagnoser:

    ```shell
    brew doctor
    ```

#### Homebrew minimum to know to get going

1.  `brew help`, or `man brew` to get some help
2.  Type `brew search` for a list
3.  Type `brew search [package]` to search for a specific package

#### Maintaining Homebrew

1.  Update Homebrew and bring down new formulae:

    ```shell
    # This updates Homebrew - it **does not** udpate any software installed via Homebrew
    brew update
    ```

2.  Updgrade all software installed via Homebrew:

    ```shell
    # This upgrades all software in the Homebrew Cellar
    brew upgrade
    ```

3.  Updating all cask apps

    Theres currently no in-build mechanism to update cask apps. The following one-liner is a suggested work-around until an official mechanism becomes available:

    ```shell
    brew cask list | xargs brew cask install
    ```

## Getting ready to install

### Creating an ssh key pair

1.  Create a new ssh key pair:

    ```shell
    ssh-keygen -t rsa -C "email@example.com"
    ```

2.  Add the new to the authentication agent (`ssh-agent`):

    > Note that on OS X, `ssh-agent` is integrated with `launchd` such that `ssh-agent` is automatically started on demand.

    ```shell
    # Use the -K switch to store your passphrase
    ssh-add -K ~/.ssh/id.rsa
    ```

3.  Verify the key was added successfully:

    ```shell
    ssh-add -l
    ```

### Adding identity to ssh config to allow multiple github accounts

    Update you ```~/.ssh/config``` as follows:

    ```shell
    Host github.com
    	User git
    	Hostname github.com
    	PreferredAuthentications publickey
    	IdentitiesOnly yes
    	IdentityFile ~/.ssh/id_rsa

    Host github-my-account
    	User git
    	Hostname github.com
    	PreferredAuthentications publickey
    	IdentitiesOnly yes
    	IdentityFile ~/.ssh/my-account
    ```

    To use the non-default account, specify when clongin. E.g.

    ```shell
    git clone git@github-my-account:user/repos
    ```

### Adding your public key to GitHib

1.  Copy your public key to the clipboard:

    ```shell
    pbcopy < ~/.ssh/id_rsa.pub 
    ```

2.  Manually register your public key with your GitHub account;
3.  Verify ssh connectivity to GitHub:

    ```shell
    # Use the -T switch so that a text terminal (tty) is not requested)
    ssh -T git@github.com
    ```

### Moving to a better terminal

## Installation

Clone dotfiles repositoy, e.g. to `~/Projects/dotfiles` and fork the `bootstrap.sh` script.
The bootstrap script can also be used to update the dotfiles installation at any stage.

```shell
$ git clone git@github.com:longboatharry/dotfiles.git && cd dotfiles && sh bootstrap.sh
```

Optionally, run the Brewfile and Caskfile to install base packages and applications.

```shell
$ brew bundle Brewfile
$ brew bundle Caskfile
```

## Post installation steps

The `Brewfile` installs Bash 4. To change to the new shell use the following:

```shell
# Add the following to /etc/shells
/usr/local/bin/bash
$ chsh -s /usr/local/bin/bash
```

## SSH key management

### SSH key generation

SSH key creation is a manual step that should be performed before the `bootstrap` script is run.

```shell
# Create new key
$ ssh-keygen -t rsa -C "your_email@example.com"
# Add key and passphrase to keychain (-K switch)
$ ssh-add -K ~/.ssh/id_rsa_[your_key_name]
# Verify key was added successfully
$ ssh-add -l
```

### Add SSH key to GitHub

```shell
# Copy public key to clipboard
$ pbcopy < ~/.ssh/id_rsa_[your_key_name].pub
```

-   Manually register the public key the GitHub account through the GitHub site.
-   Verify SSH connectivity to GitHub

```shell
# Use the -T switch to so that a text terminal (tty) is not requested
$ ssh -T git@github.com
```

## Overview of Pathogen installation

Pathogen.vim as well as all plugins installed through are setup as submodules within the `~/.vim/bundle/` directory.
In order for Vim to load pathogen, the following minimal `.vimrc` is included in the dotfiles repository:

```shell
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
syntax on
filetype plugin indent on
```

Pathogen was then added as a submodule within `.vim` as follows:

```shell
$ cd ~/.vim
$ mkdir bundle
$ git submodule init
$ git submodule add git@github.com:tpope/vim-pathogen.git bundle/vim-pathogen
$ git add -A .
$ git commit -m “Install pathogen.vim bundle as a submodule”
$ git push origin master
```

## Adding Vim bundles using Pathogen

The following plugins are installed by default:

-   [vim-sensible](https://github.com/tpope/vim-sensible)
-   [vim-unimpaired](https://github.com/tpope/vim-unimpaired)
-   [syntastic](https://github.com/scrooloose/syntastic)

The following example installs the sensible vim plugin as a submodule

```shell
$ cd ~/.vim
$ git submodule add git@github.com:tpope/vim-sensible.git bundle/vim-sensible
$ git add -A .
$ git commit -m “Install sensible.vim bundle as a submodule”
$ git push origin master
```

### Updating Vim plugins

Adding plugins as submodules  allows the plugin to be updated as follows:

```shell
$ cd ~/.vim/bundle/vim-sensible
$ git pull origin master
$ cd ..
$ git add vim-sensible
$ git commit -m "Updated the sensible vim plugin"
$ git push origin master
```

Alternatively, all plugins can be updated at once as follows:

```shell
$ cd ~/.vim
$ git submodule foreach git pull
$ git add bundle
$ git commit -m "Updated all vim plugins"
$ git push origin master
```

This is wrapped up in the `updatevim()` function declared in `~/.functions`.

## Thanks to...

-   [Mathias Bynens dotfile repository](https://github.com/mathiasbynens/dotfiles) which was used as an intial seed 
-   [Zach Holmans dotfile repository](https://github.com/holman/dotfiles), from which the symlinker script was cribbed
