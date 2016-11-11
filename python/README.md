# Python

## Installation

Python is managed via _PyEvn_. This allows you to keep the system Python as the global python version, and then use PyEnv to manage specific Python versions at the project level.

NOTE - do not install Python via Homebrew. This overwrites the system Python, and when used in combination with PyEnv makes _Powerline_ become incredilby slow.

Python virtual environments are managed via _PyEnv-VirtualEnv_. Not exactly sure if this calls into _VirtualEnv_ or _PyVEnv_ ...

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

## Virtual environment management

Virtual environment information is saved down to `~/.pyenv/versions`.

### Create virtual environment

```sh
# Create with specific python version
pyenv virtualenv 2.7.10 my-virtual-env
```

```sh
# Create with default pyenv version
pyenv virtualenv my-virtual-env
```

```sh
# Remove virtual environment
pyenv uninstall my-virtual-env
```

### List virtual environments

```sh
pyenv virtualenvs
```

### Manually activate virtual environment

PyEnv automatically activates a virtual environment when you enter the containing directory. However, they can also be manually activated:

```sh
pyenv activate my-virtual-evn
pyenv deactivate
```

## Pip

Pip should be used in conjuctions with virtual environments.

```sh
pip install freeze > requirements.txt
pip install -r requirements.txt
```
