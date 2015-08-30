#!/bin/bash
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

app_exists? () {
	local app=$1
	# command-v | describe a command without executing it, exit 1 if doesn't exist
	command -v $($app) &> /dev/null
}

install_brew () {
	app_exists? "brew" || {
        	echo "Installing Homebrew ..."
        	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	}

	app_exists? "brew cask" || {
		echo "Installing Cask ..."
		brew install caskroom/cask/brew-cask

	}

	echo "Updating Homebrew ..."
	brew update

	echo "Checking for updates to any pre-existing formulae ..."
	brew upgrade
}

install_brew_packages () {
	brew install grc coreutils spark
	brew install wget
}

install_cask_packages () {
	brew cask install iterm2
}

main () {
	install_brew
	install_brew_packages
	install_cask_packages
	
	exit 0
}

main
