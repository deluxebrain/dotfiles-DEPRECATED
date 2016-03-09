# Ctags

## Configuration

The Ctags index is associated to files at the git repository level. I.e. - there is a single tags directory ( nested within the ```.git``` directory ) which is updated following various git actions ( via hooks ). For this reason, Ctags is configured to record all file paths in the tag file relative to the tags directory ( as opposed to the current directory ) via the ```--tag-relative``` option.


