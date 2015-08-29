# longboatharry's dotfiles

## Prerequisites
### Homebrew
**Homebrew** is a dependendy in the following ways:
1. As the runner for the package and application `Brewfile` and `Caskfile` that can optionally be run as part of installation
2. One of the packages in the `Brewfile` (`bash-completion`) adds auto-completion to various Bash commands. This is configured in the symlinked `.bash_profile`

``` shell
# Install Homebew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## Pre-installation considerations
### SSH key pairs
The `bootstrap.sh` Bash script creates a symlink to `~/.ssh' from the repository file `ssh.symlink`. 
This has the side afffect of overwriting any existing `~/.ssh` directory and hence any pre-existing SSH key pairs.
The script will backup any existing `~/.ssh` directory to `~/.ssh_backup`, which in turn will be overwritten on subsequent runs of the bootstrapper.

## Installation
Clone dotfiles repositoy, e.g. to `~/Projects/dotfiles` and fork the `bootstrap.sh` script.
The bootstrap script can also be used to update the dotfiles installation at any stage.
``` shell
$ git clone git@github.com:longboatharry/dotfiles.git && cd dotfiles && sh bootstrap.sh
```
Optionally, run the Brewfile and Caskfile to install base packages and applications.
``` shell
$ brew bundle Brewfile
$ brew bundle Caskfile
```

## Post installation steps
The `Brewfile` installs Bash 4. To change to the new shell use the following:
``` shell
# Add the following to /etc/shells
/usr/local/bin/bash
$ chsh -s /usr/local/bin/bash
```

## SSH key management
### SSH key generation
SSH key creation is a manual step that should be performed before the `bootstrap` script is run.

``` shell 
# Create new key
$ ssh-keygen -t rsa -C "your_email@example.com"
# Add key and passphrase to keychain (-K switch)
$ ssh-add -K ~/.ssh/id_rsa_[your_key_name]
# Verify key was added successfully
$ ssh-add -l
```

### Add SSH key to GitHub
``` shell
# Copy public key to clipboard
$ pbcopy < ~/.ssh/id_rsa_[your_key_name].pub
```
+ Manually register the public key the GitHub account through the GitHub site.
+ Verify SSH connectivity to GitHub
``` shell
# Use the -T switch to so that a text terminal (tty) is not requested
$ ssh -T git@github.com
```

## Overview of Pathogen installation
Pathogen.vim as well as all plugins installed through are setup as submodules within the `~/.vim/bundle/` directory.
In order for Vim to load pathogen, the following minimal `.vimrc` is included in the dotfiles repository:

``` shell
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
syntax on
filetype plugin indent on
```

Pathogen was then added as a submodule within `.vim` as follows:
``` shell
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
+ [vim-sensible](https://github.com/tpope/vim-sensible)
+ [vim-unimpaired](https://github.com/tpope/vim-unimpaired)
+ [syntastic](https://github.com/scrooloose/syntastic)

The following example installs the sensible vim plugin as a submodule
``` shell
$ cd ~/.vim
$ git submodule add git@github.com:tpope/vim-sensible.git bundle/vim-sensible
$ git add -A .
$ git commit -m “Install sensible.vim bundle as a submodule”
$ git push origin master
```

### Updating Vim plugins
Adding plugins as submodules  allows the plugin to be updated as follows:
``` shell
$ cd ~/.vim/bundle/vim-sensible
$ git pull origin master
$ cd ..
$ git add vim-sensible
$ git commit -m "Updated the sensible vim plugin"
$ git push origin master
```

Alternatively, all plugins can be updated at once as follows:
``` shell
$ cd ~/.vim
$ git submodule foreach git pull
$ git add bundle
$ git commit -m "Updated all vim plugins"
$ git push origin master
```
This is wrapped up in the `updatevim()` function declared in `~/.functions`.

## Thanks to...
+ [Mathias Bynens dotfile repository](https://github.com/mathiasbynens/dotfiles) which was used as an intial seed 
+ [Zach Holmans dotfile repository](https://github.com/holman/dotfiles), from which the symlinker script was cribbed
