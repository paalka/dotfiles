# -------------------------------------------------------------------
# any function from http://onethingwell.org/post/14669173541/any
# search for running processes
# ---
any() {
    emulate -L zsh
    unsetopt KSH_ARRAYS
    if [[ -z "$1" ]] ; then
        echo "any - grep for process(es) by keyword" >&2
        echo "Usage: any " >&2 ; return 1
    else
        ps xauwww | grep -i --color=auto "[${1[1]}]${1[2,-1]}"
    fi
}

# -------------------------------------------------------------------
#  Get my current IP address(es)
# -------------------------------------------------------------------
function myip() {
  ip addr show dev lo | grep 'inet ' | sed -e 's/:/ /' | awk '{print "lo       : " $2}'
  ip addr show dev eth0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "eth0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ip addr show dev eth0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "eth0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
  ip addr show dev wlan0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "wlan0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
  ip addr show dev wlan0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "wlan0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
}

# -------------------------------------------------------------------
#  Start a SSH-agent daemon, so that all SSH-keys are available.
# -------------------------------------------------------------------
function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/env ssh-agent -t 4h | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo "The SSH agent was started!"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
}

function add_keys {
   echo "Adding keys to existing SSH agent..."
   /usr/bin/env ssh-add;
}

function init_ssh_agent {
    # Source SSH settings, if applicable
    if [ -f "${SSH_ENV}" ]; then
        . "${SSH_ENV}" > /dev/null
	if ! ps -ef | grep ${SSH_AGENT_PID} | grep "ssh-agent.*$" > /dev/null; then
            start_agent;
	fi
    else
        start_agent;
    fi

    if ! ssh-add -l > /dev/null; then
	trap '' INT;
	(add_keys);
	trap - INT;
    fi
}
