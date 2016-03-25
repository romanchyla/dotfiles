#!/bin/bash

eclipsedir=${1:-/dvt/eclipse-mars/eclipse}
pushd $eclipsedir
export SWT_GTK3=0
export UBUNTU_MENUPROXY=0
./eclipse -showlocation
popd
