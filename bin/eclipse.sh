#!/bin/bash

export UBUNTU_MENUPROXY=0
export SWT_GTK3=0 
export IBUS_ENABLE_SYNC_MODE=1

if [ "$1" = "cpp" ]; then
  cd /dvt/eclipse-neon-cpp/eclipse
else
  cd /dvt/eclipse-neon/eclipse
fi

./eclipse -showlocation
