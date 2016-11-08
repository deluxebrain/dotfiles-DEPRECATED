# Notes

## Plugins

### Markdown

Markdown syntax highlighting, etc is via the vim-markdown plugin.
Most notably, `:Toc` brings up a TOC in a quickfix window.

Other things:
`[[`, `]]`: go to previous/next header
`:TableFormat`: format table under cursor correctly (requires Tabularize plugin)

Note that by default it folds all headings. Folds 101:

| command | effect              |
| ------- | ------------------- |
| zi      | toggle folding      |
| za      | toggle current fold |
| zo      | open current fold   |
| zc      | close current fold  |
| zR      | open all folds      |
| zM      | close all folds     |

#### Formatting

For vim-autoformat to work properly, the following npm packages must be installed globally:

```js
npm install -g remark remark-cli remark-link remark-html
```

### Elixir

#### Alchemist

Client-Server app for Elixir development. Primarily for Emacs - but a Vim plugin exists. Note that the plugin installs Alchemist as part of the actual plugin - the are no further dependencies.

#### mix.vim

Plugin for using Elixirs build tool `mix`.

#### vim-elixir

Elixir support for vim, including syntax highlighting, indentation, etc

### Syntastic

Verify basic setup is working ok by issuing `:Helptags`

List installed checkers for the detected type of the current file via `:SyntasticInfo`

Note that the underlying syntax checkers need to be installed and configured independently. For a list of supported syntax checkers see: Syntax checkers: <https://github.com/scrooloose/syntastic/wiki/Syntax-Checkers>

Documenation for the various language integrations: 
<https://github.com/scrooloose/syntastic/blob/master/doc/syntastic-checkers.txt>

### vim-indent-guides

Ensure that identation is enabled in the .vimrc. See <http://vim.wikia.com/wiki/Indenting_source_code> 

For example, the following will setup Vim indentation without hard tabs:

set expandtab
set shiftwidth=2
set softtabstop=2

The plugin is toggled using <Leader>ig.

To verify it has loaded correctly verify the following is truthy `:echo g:loaded_indent_guides`.

### Tabularize

E.g. to align on =

```shell
:Tabularize /=
```

Certain frequently used variants have been mapped to <leader> key combinations using the `after/plugin/tabularize.vim` vim script. 
Note this relies on the Tabularize plugin have been loaded - hence why it needs to be performed after all plugins have been loaded.

It is also wired up to auto-align cucumber tables on the <pipe> character. This is done in the `after/plugin/cucumbertables.vim` script that is taken from [this Tim Pope scgist](https://gist.github.com/tpope/287147)

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

### Testing

#### vim-test

Language agnostic test runner that integrates with buffer shunting plugins to run tests outside of the current vim window.
See vim-test section of .vimrc

Requires that the projects and tests and structured and named according to language best practices.
E.g. for elixir tests, the tests should be named \_test.exs.

When using tslime to buffer forward to a different tmux pane, use prefix-q to show pane numbers.

## Linters

### JSCS

Configuration of JSCS is via presets ( see <http://jscs.info/overview#preset> ), e.g. based off Google JavaScript style guides. 
This buik of the JSCS configuration file is then just selecting the desired preset and providing any overrides as necessary - i.e. it wont have much in it.
Note - as the presents are baked into JSCS, simply updating JSCS updates the presets and the associated linter rules. I.e there is no need to manually reconcile linter rules against the reference set.
