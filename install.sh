#!/usr/bin/env bash
#
# This installation is destructive, as it removes exisitng files/directories.
# Use at your own risk.

UNAME=$(uname)

for namespace in '.' '.config'; do
  echo "namespace $namespace"
  for name in `ls $namespace`; do
    name=`basename $name`

    if [ $name == "README.md" -o $name == "install.sh" -o $name == "bootstrap.sh" -o $name == ".config" ]; then
      continue
    fi


    if [ "$namespace" == "." ]; then 
      if [ ! $name == "nvim" -a ! $name == "bin" -a ! $name == "Desktop" ]; then
        target=".$name"
      else
        target="$name"
      fi
      target="$HOME/$target"
    else
      target="$HOME/$namespace/$name"
    fi

    #echo "target=$target name=$name"
    
    if [ -f $target ]; then
      cp -f $target $target.bkup
      rm $target
    elif [ -h $target ]; then
      rm $target
    elif [ -d $target ]; then
      rm -fr $target.bkup
      cp -fr $target $target.bkup
      rm -fr $target
    fi

    case $UNAME in
        CYGWIN* | MINGW32*)
            cp -R "$PWD/$namespace/$name" "$target"
            echo "Copied $PWD/$namespace/$name to $target."
            ;;
        *)
            ln -s "$PWD/$namespace/$name" "$target"
            echo "Linked $PWD/$namespace/$name to $target."
            ;;
    esac
  
  done
done


echo "Provisioning..."
~/.provision.secret/run-install.py
