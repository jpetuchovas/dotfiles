export EDITOR=nvim

bindkey -e

setopt AUTO_CD

HISTSIZE=100000
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY

alias dotfiles="git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME"
alias grep='grep --color=auto'
alias ll='ls -ahl'
alias ls='ls -G'
alias vim=nvim

# Edit current command in EDITOR.
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Prompt customization.
find_git_branch() {
  local branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [ ! -z $branch ]; then
    git_branch=" ${branch}"
  else
    git_branch=''
  fi
}

check_if_dirty() {
  local git_status=$(git status --porcelain 2> /dev/null)
  if [[ "${git_status}" != "" ]]; then
    git_dirty=' x '
  else
    git_dirty=''
  fi
}

precmd() { find_git_branch; check_if_dirty }

setopt PROMPT_SUBST
PS1='%F{blue}%(5~|%-1~/.../%3~|%4~)%F{yellow}${git_branch}%F{red}${git_dirty}%F{black}$%f '
PS2='%F{black}>%f '

export PATH="${HOME}/Dropbox/repos/scripts:${HOME}/bin:${PATH}"

# zsh-completions.
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

export HOMEBREW_NO_ANALYTICS=1

# Added by n-install (see http://git.io/n-install-repo).
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

# Homebrew setup on M1 MacBook.
if [[ $(uname -m) == 'arm64' ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

eval "$(pyenv virtualenv-init -)"

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#928374"
