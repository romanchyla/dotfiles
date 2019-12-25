# this file gets imported by default .bashrc; we take advantage of it
# to branch out and call other customizations - overriding/customizing
# the default settings



# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='LC_ALL=C ls --group-directories-first -F $LS_OPTIONS'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias touchpart-restart='sudo modprobe -r psmouse && sudo modprobe psmouse'
alias dul='du -h --max-depth=1'
alias hi='history | tail -20'
alias cat='cat -v'
# Git aliases
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gcp='git cherry-pick'
alias gdiff='git diff'
alias gl='git log --pretty'
alias gp='git push'
alias gs='git status'
alias gt='git tag'


alias ox='xdg-open'
alias webstorm-fix-keyboard="sudo ibus restart"
alias restart-wifi="echo \"sudo kill -9 `pidof NetworkManager`\"; sudo kill -9 `pidof NetworkManager`"
# screens
alias svim='screen -c ~/.vimscreen'
alias slua='screen -c ~/.luascreen.secret'
alias swork='screen -c ~/.workscreen.secret'

alias reload='source ~/.bashrc'
alias biggest='BLOCKSIZE=1048576; du -x | sort -nr | head -10'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

alias dt='date "+%F %T"'

function search_replace() {
	folder=${3:-`pwd`}
	read -p "Recursive '$1' -> '$2' in $folder? [y]:" answer
  if [ "${answer:-y}" == "y" ]; then
    echo "find $folder -type f -print0 | xargs -0 sed -i \"s/$1/$2/g\""
		find $folder -type f -print0 | xargs -0 sed -i "s/$1/$2/g"
  fi
}
alias sr=search_replace


function killport() {
  sudo kill $(fuser -n tcp $1 2> /dev/null)
}
function checkport() {
  a=("$@")
  for i in "${a[@]}" ; do
    p=`fuser -n tcp $i 2> /dev/null`
    if [ "$p" != "" ]; then
      read -e -p "Do you want to kill the process runnning on port $i ($p)?: " -i "y" answer
      if [ "${answer:-y}" == "y" ]; then
        killport $i
      fi
    fi
  done
}

# Easy extract
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

init-python () {
   if [ -e python ]; then
     echo "python already exists; please remove manually if you want me to recreate it"
   else
     echo "initializing python in " `pwd`
     virtualenv python
   fi

   source python/bin/activate

   if [ -f requirements.txt ]; then
     pip install -r requirements.txt
   fi

   if [ -f dev-requirements.txt ]; then
     pip install -r dev-requirements.txt
   fi
}


test -r ~/.bash_customizations && . ~/.bash_customizations


if [ -f ~/.bash_aliases.secret ]; then
    . ~/.bash_aliases.secret
fi
