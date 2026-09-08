function emit_osc {
  [[ -n $TMUX ]] && printf '\ePtmux;\e%b\e\\' "$1" || printf '%b' "$1"
}

function ssh mosh {
  emit_osc '\e]11;#3a1414\a'
  command $0 "$@"
  local ret=$?
  emit_osc '\e]111\a'
  return $ret
}

function precmd {
  # vcs_info
  # Put the string "hostname::/full/directory/path" in the title bar:
  echo -ne "\e]2;$PWD\a"

  # Put the parentdir/currentdir in the tab
  echo -ne "\e]1;$PWD:h:t/$PWD:t\a"
}

function set_running_app {
  printf "\e]1; $PWD:t:$(history $HISTCMD | cut -b7- ) \a"
}

function preexec {
  set_running_app
}

function postexec {
  set_running_app
}
