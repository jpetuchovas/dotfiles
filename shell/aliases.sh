if [ -x /usr/bin/dircolors ]; then
  eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
fi

alias ll='ls --all --human-readable -l'
alias la='ls --almost-all'
alias l='ls'
