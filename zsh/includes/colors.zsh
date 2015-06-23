autoload colors; colors

# The variables are wrapped in \%\{\%\}. This should be the case for every
# variable that does not contain space.
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
  eval PR_$COLOR='%{$fg_no_bold[${(L)COLOR}]%}'
  eval PR_BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done

eval RESET='$reset_color'
export PR_RED PR_GREEN PR_YELLOW PR_BLUE PR_WHITE PR_BLACK
export PR_BOLD_RED PR_BOLD_GREEN PR_BOLD_YELLOW PR_BOLD_BLUE
export PR_BOLD_WHITE PR_BOLD_BLACK

# Clear LSCOLORS
unset LSCOLORS
export CLICOLOR=1

if [[ $IS_MAC -eq 1 ]]; then
    export LS_COLORS=exfxcxdxbxegedabagacad
elif [[ $IS_LINUX -eq 1 ]]; then
    export LS_COLORS='di=1;34:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=1;36:*.rpm=90:*.tar=1;31'
fi
 
