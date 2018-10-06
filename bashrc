# If not running interactively, don't do anything.
case $- in
  *i*) ;;
  *) return;;
esac

source ~/.bash/settings.bash

source ~/.shell/external.sh

source ~/.shell/aliases.sh

source ~/.bash/prompt.bash

source ~/.shell/plugins.sh

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
