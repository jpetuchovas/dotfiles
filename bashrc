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

source ~/.bash/plugins.bash
