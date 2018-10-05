ATTRIBUTE_RESET='\[\e[0m\]'

COLOR_BLUE='\[\e[34m\]'
COLOR_GRAY='\[\e[90m\]'
COLOR_YELLOW='\[\e[33m\]'
COLOR_RED='\[\e[31m\]'

TERMINAL_TITLE_BAR='\[\e]0;\u@\h: \w\a\]'

find_git_branch() {
  local branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/*\(.*\)/\1/')

  if [ ! -z $branch ]; then
    git_branch="${branch}"
  else
    git_branch=''
  fi
}

check_if_dirty() {
  local status=$(git status --porcelain 2> /dev/null)
  if [[ "$status" != "" ]]; then
    git_dirty=' ✗ '
  else
    git_dirty=''
  fi
}

PROMPT_COMMAND="find_git_branch; check_if_dirty; ${PROMPT_COMMAND}"

PROMPT_DIRTRIM=3
PS1="${TERMINAL_TITLE_BAR}${COLOR_BLUE}\w${COLOR_YELLOW}\$git_branch${COLOR_RED}\$git_dirty${COLOR_GRAY}\$ ${ATTRIBUTE_RESET}"
