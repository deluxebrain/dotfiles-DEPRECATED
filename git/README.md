# Git

## Git and Ctags

See http://tbaggery.com/2011/08/08/effortless-ctags-with-git.html

Git hooks are used to re-index ctags on various git actions. These are are setup as default (global) hooks configured in the ```~/.git_template``` directory.

Note - this approach stores the tags directory in the ```.git``` directory. This is as part of working with ```fugitive.vim``` which makes vim look for the tags there regardless of the current working directory.

The default hooks cover post-commit, post-merge and post-checkout.  The post-rewrite hook covers ```git rebase```.

To add these hooks for an existing repository just run ```git init```.


