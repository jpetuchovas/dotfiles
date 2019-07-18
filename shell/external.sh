# Prevent Python from creating .pyc files on the import of source modules.
export PYTHONDONTWRITEBYTECODE=true

export NVM_DIR="${HOME}/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh" --no-use

alias node='unalias node; unalias npm; nvm use default; node $@'
alias npm='unalias node; unalias npm; nvm use default; npm $@'
