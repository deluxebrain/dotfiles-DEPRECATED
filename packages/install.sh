#!/bin/bash
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

CWD="${BASH_SOURCE%/*}" # path to executing script
DEPENDS_ON=(
	~/lib/pretty_print.sh		\
	~/lib/if_exists.sh		\
	~/lib/sudo_keepalive.sh)

__main () (

	# Check for github api token and warn if missing
	[ ! "${HOMEBREW_GITHUB_API_TOKEN}" ] && \
		msg_warn "HOMEBREW_GITHUB_API_TOKEN environment variable is not set"

	# Ask for administrator password upfront
	sudo_keepalive
	
	# load dependencies
	for FILE in "${DEPENDS_ON[@]}"; do source "${CWD}/${FILE}"; done

	__install_brew
        __install_brew_packages
        __install_cask_packages

	brew cleanup && brew cask cleanup
	
	# Report success status back to parent shell
        exit 0
)

__load_dependencies() {
        local script_dir="${BASH_SOURCE%/*}"
	# source the scripts into the current shell process
        source "${script_dir}/../functions/pretty-print.sh"
        source "${script_dir}/../functions/if-exists.sh"
}

__install_brew () {
	app_exists? "brew" || {
        	print_info "Installing Homebrew ..."
        	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	}

	app_exists? "brew cask" || {
		print_info "Installing Cask ..."
		brew install caskroom/cask/brew-cask
	}
	brew tap caskroom/versions

	print_info "Updating Homebrew ..."
	brew update

	print_info "Checking for updates to any pre-existing formulae ..."
	brew upgrade
}

__install_brew_packages () {
	brew install grc coreutils spark
	brew install wget
	brew install pstree
}

__install_cask_packages () {
	brew cask install iterm2-beta
	brew cask install alfred
}

__main "$@"

unset CWD
unset DEPENDS_ON

unset -f __main
unset -f __load_dependencies
unset -f __install_brew
unset -f __install_brew_packages
unset -f __install_cask_packages
