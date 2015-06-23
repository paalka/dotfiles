# To see the key combo you want to use just do:
# cat > /dev/null
# And press it

bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
bindkey '^R' history-incremental-pattern-search-backward
