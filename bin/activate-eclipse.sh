#!/bin/bash

#when switching perspectives, the windows lose focus, this will 
# find and click into the eclipse

xdotool search --onlyvisible --sync eclipse windowactivate --sync click 1
