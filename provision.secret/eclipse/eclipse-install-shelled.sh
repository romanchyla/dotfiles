#!/bin/bash

# this should be run insie the eclipse folder, it will install pydev, to remove it pass 'remove'

repository=`cat ~/dotfiles/provision.secret/eclipse/eclipse-repos`

pushd $1

if [ "$2" == "remove" ]; then
  action='uninstallIUs'
else
  action='installIUs'
fi

./eclipse -nosplash -application org.eclipse.equinox.p2.director -repository  "$repository" -${action} "org.eclipse.ldt.feature.group, org.eclipse.ldt.remote.feature.group"

popd
