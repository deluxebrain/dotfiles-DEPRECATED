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

### Disabling plugins

To disable a Pathogen plugin, dename the parent directory from `plugin_name` to `plugin_name~`.

### Plugin specific installation steps

For plugins that require post-installation steps (such as YouCompleteMe), author these steps in a script named the same as the repository (e.g. YouCompleteMe) and drop this script alongside the vim installer script.

### Plugin configuration

Note that the ```.vimrc``` is loaded before plugins. Therefore any configuration that requires the actual plugin to have been loaded and initialized needs to take place a file within the ```~/.vim/after/plugin``` directory. 

