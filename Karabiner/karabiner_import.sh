#!/bin/bash

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

$cli set repeat.wait 33
$cli set repeat.initial_wait 250

# Map left control to itself when used in combination
# Map left control to escape with used in isolation
$cli set remap.controlL2controlL_escape 1
