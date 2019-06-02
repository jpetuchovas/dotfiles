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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/justinas/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/justinas/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/justinas/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/justinas/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

