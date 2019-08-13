#!/bin/bash

source ./dconf.setup
h=`hostname -s`
gsettings list-recursively > "dconf.dump.$h"
sort "dconf.dump.$h" -o "dconf.dump.$h"
