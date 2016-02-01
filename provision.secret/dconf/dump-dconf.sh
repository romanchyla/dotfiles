#!/bin/bash

# necessary to get the values
unset XDG_CONFIG_HOME

pushd ~/dotfiles/provision.secret/dconf
gsettings list-recursively > dconf.dump
popd
