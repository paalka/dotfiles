# To see the key combo you want to use just do:
# cat > /dev/null
# And press it

bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^R' history-incremental-pattern-search-backward

autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line