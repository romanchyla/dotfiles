# Roman's Dot Files

These are the various config files I have to setup a system
the way I want it. Bootstrapped from Mitchell Hashimoto's
dotfiles:

    git clone git://github.com/mitchellh/dotfiles.git

## Installation

    git clone git://github.com/romanchyla/dotfiles.git
    ./bootstrap.sh
    dotfiles/install.sh

## Changes to Ubuntu 14.04

  * Get rid off the annoying CTRL SCAN EVENTS, edit sudo vim /usr/share/dbus-1/system-services/fi.w1.wpa_supplicant1.service and remove '-s'

  * echo 'manual' | sudo tee /etc/init/avahi-daemon.override
  * sudo service avahi-daemon stop
