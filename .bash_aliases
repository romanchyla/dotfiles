# this file gets imported by default .bashrc; we take advantage of it
# to branch out and call other customizations - overriding/customizing
# the default settings

test -r ~/.bash_customizations . ~/.bash_customizations


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

alias dul='du -h --max-depth=1'
alias hi='history | tail -20'
alias cat='cat -v'
# Git aliases
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gcp='git cherry-pick'
alias gdiff='git diff'
alias gl='git prettylog'
alias gp='git push'
alias gs='git status'
alias gt='git tag'

# Others
alias be='bundle exec'
alias v='vagrant'
alias ox='xdg-open'
alias webstorm-fix-keyboard="sudo ibus restart"
alias restart-wifi="echo \"sudo kill -9 `pidof NetworkManager`\"; sudo kill -9 `pidof NetworkManager`"
# screens
alias svim='screen -c ~/.vimscreen'
alias slua='screen -c ~/.luascreen.secret'
alias swork='screen -c ~/.workscreen.secret'

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

#ssh -N -f -L 3307:adsx.cfa.harvard.edu:3306 rchyla@pogo3.cfa.harvard.edu
function work-tunnel() {
  local_port=${1}
  target_machine=${2:-adsx.cfa.harvard.edu:${1}}
  gateway_machine=${3:-rchyla@pogo5.cfa.harvard.edu}
  checkport $local_port
  echo "ssh -N -f -L $local_port:$target_machine $gateway_machine"
  ssh -N -f -L $local_port:$target_machine $gateway_machine
}

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_aliases.secret ]; then
    . ~/.bash_aliases.secret
fi