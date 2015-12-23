# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls --group-directories-first -F $LS_OPTIONS'
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

# screens
alias svim='screen -c ~/.vimscreen'
alias slua='screen -c ~/.luascreen.secret'
alias swork='screen -c ~/.workscreen.secret'
