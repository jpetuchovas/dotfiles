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
sh .vscode-extensions
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

The `dotfiles` alias can be used to interact with the dotfiles repository.
