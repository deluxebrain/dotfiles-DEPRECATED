# Notes

Starting from Vim 7.4 you can structure your Vim dotfiles as follows:

~/.vim/vimrc

## Debugging

### List all loaded plugins

```shell
:scriptnames

```

### List command linked to key combination

```shell
:verbose map <S-Tab>
:verbose nnoremap <S-Tab>   # normal mode non-recursive map
:verbose inoremap <S-Tab>   # insert mode non-recursive map
```

## Plugin management

Vim plugins are orchestrated using Pathogen and installed as git submodules into the bundle directory.

### Plugin specific installation steps

For plugins that require post-installation steps (such as YouCompleteMe), author these steps in a script named the same as the repository (e.g. YouCompleteMe) and drop this script alongside the vim installer script.

### Plugin configuration

Note that the ```.vimrc``` is loaded before plugins. Therefore any configuration that requires the actual plugin to have been loaded and initialized needs to take place a file within the ```~/.vim/after/plugin``` directory. 

## Plugin notes

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

#### Tabularize

E.g. to align on =
```shell
:Tabularize /=
```

Certain frequently used variants have been mapped to <leader> key combinations using the ```after/plugin/tabularize.vim``` vim script. 
Note this relies on the Tabularize plugin have been loaded - hence why it needs to be performed after all plugins have been loaded.

It is also wired up to auto-align cucumber tables on the <pipe> character. This is done in the ```after/plugin/cucumbertables.vim``` script that is taken from [this Tim Pope scgist](https://gist.github.com/tpope/287147)

Example cucumber table for reference:
```gherkin
Scenario Outline: something
	Given there are <start> things
	When I remove <removed> things
	Then I should have <remaining> things

	Examples:
	| start | removed | remaining |
	| 10    | 2       | 8         |
```





