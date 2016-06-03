# Notes

Starting from Vim 7.4 you can structure your Vim dotfiles as follows:

~/.vim/vimrc

## Plugins

Vim plugins are orchestrated using Pathogen and installed as git submodules into the bundle directory.
For plugins that require post-installation steps (such as YouCompleteMe), author these steps in a script named the same as the repository (e.g. YouCompleteMe) and drop this script alongside the vim installer script.

### Syntastic

Verified basic setup is working ok by issuing `:Helptags`

List installed checkers for the detected type of the current file via `:SyntasticInfo`

Note that the underlying syntax checkers need to be installed and configured independently. For a list of supported syntax checkers see: Syntax checkers: https://github.com/scrooloose/syntastic/wiki/Syntax-Checkers

### vim-indent-guides

Ensure that identation is enabled in the .vimrc. See http://vim.wikia.com/wiki/Indenting_source_code 

For example, the following will setup Vim indentation without hard tabs:

set expandtab
set shiftwidth=2
set softtabstop=2

The plugin is toggled using <Leader>ig.

To verify it has loaded correctly verify the following is truthy `:echo g:loaded_indent_guides`.

### Linters

#### JSCS

Configuration of JSCS is via presets ( see http://jscs.info/overview#preset ), e.g. based off Google JavaScript style guides. 
This buik of the JSCS configuration file is then just selecting the desired preset and providing any overrides as necessary - i.e. it wont have much in it.
Note - as the presents are baked into JSCS, simply updating JSCS updates the presets and the associated linter rules. I.e there is no need to manually reconcile linter rules against the reference set.

#### ESLint




