#!/usr/bin/env bash
#
# This installation is destructive, as it removes exisitng files/directories.
# Use at your own risk.

UNAME=$(uname)

for name in *; do
  if [ ! $name == "README.md" -a ! $name == "install.sh" -a ! $name == "bootstrap.sh" ]; then
    target="$name"
    if [ ! $name == "nvim" -a ! $name == "bin"  ]; then
        target=".$name"
    fi
    target="$HOME/$target"

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
            cp -R "$PWD/$name" "$target"
            echo "Copied $PWD/$name to $target."
            ;;
        *)
            ln -s "$PWD/$name" "$target"
            echo "Linked $PWD/$name to $target."
            ;;
    esac
  fi
done

echo "Provisioning..."
~/.provision.secret/run-install.py
