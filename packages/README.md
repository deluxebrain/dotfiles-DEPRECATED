# TL;DR guide to the plugins

## ag

Find files containing "foo", and print the line matches in context:
ag foo

Find files containing "foo", but only list the filenames:
ag -l foo

Find files containing "FOO" case-insensitively, and print only the match, rather than the whole line:
ag -i -o FOO

Find "foo" in files with a name matching "bar":
ag foo -G bar

Find files whose contents match a regular expression:
ag '^ba(r|z)$'

Find files with a name matching "foo":
ag -g foo

## fzf

launch curses-based finder, read the list from STDIN, and write the selected item to STDOUT.

find * -type f | fzf > selected

Without STDIN pipe, fzf will use find command to fetch the list of files excluding hidden ones. (You can override the default command with FZF_DEFAULT_COMMAND)

vim $(fzf)

select multiple words in vertical tmux split on the left (20% of screen width)
cat /usr/share/dict/words | fzf-tmux -l 20% --multi --reverse

