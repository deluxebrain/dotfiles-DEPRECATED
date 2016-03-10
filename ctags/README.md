# Ctags

## Configuration

The dotfiles setup includes git hooks that regenerate the ctags index on key events such as commit. 

The git repository is assumed to be the container for a multi-level directory hierarchy of source code. The issue then is how to structure the tag files to support indexing across this directory structure.

The default approach taken by the dotfiles is to have a single global tags file nested withiin the repository ```.git``` direcctory.

I.e. - there is a single tags directory ( nested within the ```.git``` directory ) which is updated following various git actions ( via hooks ). 

For this reason, Ctags is configured to record all file paths in the tag file relative to the tags directory ( as opposed to the current directory ) via the ```--tag-relative``` option.



