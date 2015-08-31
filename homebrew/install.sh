#!/bin/bash
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

load_dependencies() {
        local script_dir="${BASH_SOURCE%/*}"
	# source the scripts into the current shell process
        source "${script_dir}/../functions/pretty-print.sh"
        source "${script_dir}/../functions/if-exists.sh"
}

install_brew () {
	app_exists? "brew" || {
        	print_info "Installing Homebrew ..."
        	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	}

	app_exists? "brew cask" || {
		print_info "Installing Cask ..."
		brew install caskroom/cask/brew-cask

	}

	print_info "Updating Homebrew ..."
	brew update

	print_info "Checking for updates to any pre-existing formulae ..."
	brew upgrade
}

install_brew_packages () {
	brew install grc coreutils spark
	brew install wget
	brew install pstree
}

install_cask_packages () {
	brew cask install iterm2
}

main () (
	load_dependencies

	install_brew
	install_brew_packages
	install_cask_packages
	
	exit 0
)

main
unset -f load_dependencies
unset -f install_brew
unset -f install_brew_packages
unset -f install_cask_packages
unset -f main
