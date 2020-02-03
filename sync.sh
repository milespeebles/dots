#!/bin/bash

BASEDIR=$(dirname "$0")
SYNCDIR=$HOME/dev/dots

# directories
mkdir -p "$HOME/Desktop"
mkdir -p "$HOME/Downloads"
mkdir -p "$HOME/dev"
mkdir -p "$HOME/sync"

# ignore
rm -rf "$HOME/.ignore"
rm -rf "$HOME/.agignore"
rm -rf "$HOME/.fdignore"
cp "$BASEDIR/src/.ignore" "$HOME"
cp "$BASEDIR/src/.ignore" "$HOME/.agignore"
cp "$BASEDIR/src/.ignore" "$HOME/.fdignore"

# neovim
rm -rf "$HOME/.config/nvim"
cp -r "$BASEDIR/src/.config/nvim" "$HOME/.config"

# zsh
rm -f "$HOME/.zshrc"
cp "$BASEDIR/src/.zshrc" "$HOME"
rm -rf "$HOME/.zsh"
cp -r "$BASEDIR/src/.zsh" "$HOME"

# tmux
mkdir -p "$HOME/.tmux/plugins"
rm -f "$HOME/.tmux.conf"
cp "$BASEDIR/src/.tmux.conf" "$HOME/.tmux.conf"
chmod +x "$HOME/.tmux.conf"

# ranger
mkdir -p "$HOME/.config/ranger"
rm -rf "$HOME/.config/ranger/rc.conf"
cp "$BASEDIR/src/.config/ranger/rc.conf" "$HOME/.config/ranger"
cp "$BASEDIR/src/.config/ranger/scope.sh" "$HOME/.config/ranger"
chmod +x "$HOME/.config/ranger/scope.sh"

# ncmpcpp
mkdir -p "$HOME/.config/ncmpcpp"
rm -rf "$HOME/.config/ncmpcpp"
cp -r "$BASEDIR/src/.config/ncmpcpp" "$HOME/.config"

# git
rm -f "$HOME/.gitconfig"
cp "$SYNCDIR/src/.gitconfig" "$HOME"
git config --global credential.helper store
git config --global user.name 'anonymous'
git config --global user.email '<>'

# terminfo
rm -rf "$HOME/.terminfo"
tic -x -o "$HOME/.terminfo" "$SYNCDIR/src/xterm-24bit.terminfo"

# emacs
mkdir -p "$HOME/.doom.d"
cp "$SYNCDIR/src/.doom.d/config.el" "$HOME/.doom.d"
cp "$SYNCDIR/src/.doom.d/init.el" "$HOME/.doom.d"
cp "$SYNCDIR/src/.doom.d/packages.el" "$HOME/.doom.d"
