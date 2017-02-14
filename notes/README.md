1.  eslint configuration file

    A `.eslintrc` file in your home directory will only be picked up if no other
    files are found in the repository.

2.  Incorrect indent size in vim

    Indent style and sizes are set through a combination of `vim-sleuth` and
    `editorconfig`.

    On the whole this should set the indent sizing to 2 spaces. This can be
    verified using `:set shiftwidth?`.

    If this is wrong - most usually the erroneous case is it being set to 4
    spaces, this can often be caused by the heuristic model of vim-sleuth.

    In this case - the solution is often to just to forcibly ensure that all
    tabs in the file are replaced by a specified number of spaces:

    ```shell
    expand -t 2 file | sponge file
    ```

    Note the use of `sponge` (moreutils) that allows a file to be rewritten back
    to itself.

3.  Updating git submodules

    Use the following

    ```shell
    git submodule update --recursive
    ```

    Note - add `ignore = dirty` to the gitmodules file for any submodule that is
    _compiled_ in some way. I.e. for submodules that that will be changed in
    some way. This cannot be achieved using the parent gitignore file as this is
    not inherited by submodule git repositories.
