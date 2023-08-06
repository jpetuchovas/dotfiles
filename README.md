# Dotfiles

My configuration files.

## Setup

Run the following commands:

```shell
cd
git clone --bare git@github.com:jpetuchovas/dotfiles.git .dotfiles.git
git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME checkout
exec $SHELL
dotfiles config --local status.showUntrackedFiles no
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

The `dotfiles` alias can be used to interact with the dotfiles repository.
