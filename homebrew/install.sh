#!/bin/bash
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew 
: <<'EOF'
:		| no-op (can take arguments)
here 		| ensure that the delimiter word must be quoted to avoid expansion within the here document
command -v 	| describe a command without executing it, exit 1 if doesn't exist
> /dev/null 	| redirect stdout to null device
2>&1		| redirect stderr to stdout
|| 		| run command on right if command on left returns with exit 1
{ } 		| multi-line command group, use ; to delimit commands if on single line
'EOF'
command -v brew > /dev/null 2>&1 || {
	echo "Installing Homebrew ..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

# Update Homebrew
brew update

# Upgrade any existing formulae
brew upgrade





# Install homebrew packages
brew install grc coreutils spark

exit 0
