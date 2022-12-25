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
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Fix issues with tmux on macOS:
# https://github.com/tmux/tmux/issues/3218
# Related:
# https://www.rockyourcode.com/til-how-to-fix-cannot-read-termcap-database-with-tmux-and-kitty-on-macos/
# https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95
/*/*/Cellar/ncurses/6.3/bin/infocmp -x tmux-256color >tmux-256color.src
sudo /usr/bin/tic -x tmux-256color.src
```

The `dotfiles` alias can be used to interact with the dotfiles repository.
