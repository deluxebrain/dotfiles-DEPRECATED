# Notes

Starting from Vim 7.4 you can structure your Vim dotfiles as follows:

~/.vim/vimrc

## Plugins

### Syntastic

Verified basic setup is working ok by issuing `:Helptags`

List installed checkers via `:SyntasticInfo`

Syntax checkers: https://github.com/scrooloose/syntastic/wiki/Syntax-Checkers

### vim-indent-guides

Ensure that identation is enabled in the .vimrc. See http://vim.wikia.com/wiki/Indenting_source_code 

For example, the following will setup Vim indentation without hard tabs:

set expandtab
set shiftwidth=2
set softtabstop=2

The plugin is toggled using <Leader>ig.

To verify it has loaded correctly verify the following is truthy `:echo g:loaded_indent_guides`.

