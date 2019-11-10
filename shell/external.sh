export NVM_DIR="${HOME}/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh" --no-use

alias node='unalias node; unalias npm; nvm use default; node $@'
alias npm='unalias node; unalias npm; nvm use default; npm $@'

export PATH="${HOME}/tools/arcanist/bin:${PATH}"
