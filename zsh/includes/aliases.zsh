# -------------------------------------------------------------------
# directory movement
# -------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias 'bk=cd $OLDPWD'

# -------------------------------------------------------------------
# directory information
# -------------------------------------------------------------------
alias lh='ls -d .*' # show hidden files/directories only
alias l='ls -al'
alias 'dus=du -sckx * | sort -nr' # directories sorted by size
alias ducks='du -cks * | sort -rn | head' # Get the largest folders

# -------------------------------------------------------------------
# Platform specific
# -------------------------------------------------------------------
alias ls='ls -Fha --color' # Colorize output, add file type indicator, and put sizes in human readable format
alias ll='ls -Fhla --color' # Same as above, but in long listing format

# -------------------------------------------------------------------
# Git
# -------------------------------------------------------------------
alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gpl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gs='git status'
alias gd='git diff'
alias gpu='git pull'
alias gcl='git clone'

# gu shows a list of all developers and the number of commits they've made
alias gu="git shortlog -s -n --all"

# -------------------------------------------------------------------
# Tmux
# -------------------------------------------------------------------
alias tmuxk="tmux kill-session -t"
alias tmuxa="tmux attach-session -t"
alias tmuxls="tmux list-sessions"

# -------------------------------------------------------------------
# emacs
# -------------------------------------------------------------------
alias e="emacsclient -c"
alias et="emacsclient -nw"

# -------------------------------------------------------------------
# Etc
# -------------------------------------------------------------------
# make rm command (potentially) less destructive
alias 'rm=rm -i'
alias 'mc=mosh cass'
alias 'less=less -R'
alias 'gdb=gdb -q'
alias 'latexcont=latexmk -pvc -interaction=nonstopmode'

# Fetch the weather for Trondheim
alias trd='finger 7012@graph.no | grep -v NRK'

