#!/usr/bin/env bash
#
# This installation is destructive, as it removes exisitng files/directories.
# Use at your own risk.

UNAME=$(uname)

for name in *; do
  if [ ! $name == "README.md" -a ! $name == "install.sh" ]; then
    target="$name"
    if [ ! $name == "nvim" ]; then
        target=".$name"
    fi
    target="$HOME/$target"

    if [ -h $target ]; then
      cp -f $target $target.bkup
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
