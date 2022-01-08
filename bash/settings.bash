# Append to the history file, don't overwrite it.
shopt -s histappend

HISTSIZE=100000
HISTTIMEFORMAT='%F %T '

export EDITOR=nvim
