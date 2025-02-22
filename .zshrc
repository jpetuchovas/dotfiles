export EDITOR=nvim

setopt AUTO_CD

HISTSIZE=100000
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE

alias dotfiles="git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME"
alias grep='grep --color=auto'
alias ll='ls -lah'
alias ls='ls -G'
alias -g vim=nvim

# Make an equivalent command to bash's help command.
# Based on zshcontrib manpage.
unalias run-help
autoload run-help
alias help=run-help
HELPDIR="/run/current-system/sw/share/zsh/$ZSH_VERSION/help"

bindkey -e

# Navigate through commands in history as usual, or if the cursor is at the
# last position of an inputted command, use the prefix up to the cursor
# position for searching.
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
# Up arrow.
bindkey '^[[A' up-line-or-beginning-search
# Down arrow.
bindkey '^[[B' down-line-or-beginning-search
bindkey -M emacs '^P' up-line-or-beginning-search
bindkey -M emacs '^N' down-line-or-beginning-search

# Perform history expansion when space is pressed after an event designator
# such as !!.
bindkey ' ' magic-space

# Bash-like navigation/deletion when using Alt and Ctrl.
autoload -U select-word-style
select-word-style bash
zle -N backward-kill-space-word backward-kill-word-match
zstyle :zle:backward-kill-space-word word-style space
bindkey '^w' backward-kill-space-word

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

precmd() {
  find_git_branch
  check_if_dirty
}

setopt PROMPT_SUBST
PS1='%F{blue}%(5~|%-1~/.../%3~|%4~)%F{yellow}${git_branch}%F{red}${git_dirty}%F{black}$%f '
PS2='%F{black}>%f '

export N_PREFIX="$HOME/n";

PATH="${HOME}/Dropbox/repos/scripts:${HOME}/bin:${N_PREFIX}/bin:${PATH}"

export HOMEBREW_NO_ANALYTICS=1
# Homebrew setup on M1 MacBook.
if [[ $(uname -m) == 'arm64' ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Make fzf respect .gitignore.
export FZF_DEFAULT_COMMAND='fd -t f --strip-cwd-prefix'

# zsh-completions.
FPATH=$HOME/.nix-profile/share/zsh/site-functions:$FPATH
autoload -Uz compinit
compinit

enable_zsh_autosuggestions() {
  local zsh_autosuggestions_path=$HOME/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  if [[ -f $zsh_autosuggestions_path ]]; then
    source $zsh_autosuggestions_path
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#928374"
  fi
}

enable_zsh_autosuggestions

export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
