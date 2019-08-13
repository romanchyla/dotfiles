#!/bin/bash

source dconf.setup

gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Shift>Shift_R']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['']"
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'cz+qwerty')]"
gsettings set org.freedesktop.ibus.general engines-order "['xkb:us::eng', 'xkb:cz:qwerty:cze']"
