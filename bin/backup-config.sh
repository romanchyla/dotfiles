#!/bin/bash

cd ~/provision.secret/dconf/
./dump-dconf.sh 
git add ./dconf.dump*

w=`git status -s | grep -E '^ M'`

if (( $w -gt 0 )); then
  git commit -m "Updated dconf"'
  git push
fi
