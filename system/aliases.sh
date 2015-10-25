# ssh config concatenation
# https://serverfault.com/questions/375525/can-you-have-more-than-one-ssh-config-file
alias complile-ssh-config="cat ~/.ssh/*.config > ~/.ssh/config-compiled"
alias ssh="compile-ssh-config && ssh -F ~/.ssh/config-compiled"

# roll calls (rc)
alias rcv="compgen -v" # names of all shell variables
alias rcf="compgen -A function" # names of all shell functions
alias rca="compgen -a" # names of all shell aliases
alias rch="compgen -A hostname" # hostnames as taken from the file specified by $HOSTFILE
alias rcj="compgen -j" # job names (if job control is active)
alias rck="compgen -k" # shell reserved key words.

# script helpers
alias ped="echo ${BASH_SOURCE%/*}" # path to the directory of the executing script 
alias ped2="echo $BASH_SOURCE"

# brew
alias bu="brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup"

