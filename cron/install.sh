#!/bin/bash

script_dir="${BASH_SOURCE%/*}"
cat "${script_dir}"/crontab | crontab -
