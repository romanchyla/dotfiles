#!/bin/bash

# necessary to get the values
unset XDG_CONFIG_HOME

gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Shift>Shift_R']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['']"
