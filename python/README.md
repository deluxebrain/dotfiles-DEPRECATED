# Python

## Installation

Python is managed via _PyEvn_. This allows you to keep the system Python as the global python version, and then use PyEnv to manage specific Python versions at the project level.

NOTE - do not install Python via Homebrew. This overwrites the system Python, and when used in combination with PyEnv makes _Powerline_ become incredilby slow.

## PyEnv

### Installing Python versions

```sh
# List all versions available
pyenv install -l

# Install a specific version
pyenv install 2.7.12
pyenv install 3.5.2
```

### Viewing installed Python versions

```sh
# List system Python
which python

# List current PyEnv Python
pyenv which python

# List all PyEnv versions
pyenv versions
```

### Switching versions globally

Dont do this - for system stability keep the default system Python the global version

```sh
# List the global Python version
pyenv global

# Switch global version
pyenv global <version>
```

### Switching versions locally

PyEnv managed local python versions at the directory level, by creating a `.python-version` file. PyEnv automatically sets the python version locally from this file when entering the respective directory.

```sh
# Create a local pyenv version
pyenv local <version>
```
