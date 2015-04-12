# ssh config concatenation
# https://serverfault.com/questions/375525/can-you-have-more-than-one-ssh-config-file
alias complile-ssh-config = 'cat ~/.ssh/*.config > ~/.ssh/config-compiled'
alias ssh = 'compile-ssh-config && ssh -F ~/.ssh/config-compiled' 
