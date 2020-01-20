#!/bin/bash

BASEDIR=$(dirname $0)
SYNCDIR=$HOME/dev/dots

# directories
mkdir -p $HOME/Desktop
mkdir -p $HOME/Downloads
mkdir -p $HOME/dev
mkdir -p $HOME/sync
mkdir -p $HOME/media
mkdir -p $HOME/gallery

# ignore
rm -rf $HOME/.ignore
rm -rf $HOME/.agignore
rm -rf $HOME/.fdignore
cp $BASEDIR/src/.ignore $HOME
cp $BASEDIR/src/.ignore $HOME/.agignore
cp $BASEDIR/src/.ignore $HOME/.fdignore

# neovim
rm -rf $HOME/.config/nvim
cp -r $BASEDIR/src/.config/nvim $HOME/.config

# zsh
rm -f $HOME/.zshrc
cp $BASEDIR/src/.zshrc $HOME
rm -rf $HOME/.zsh
cp -r $BASEDIR/src/.zsh $HOME

# tmux
mkdir -p $HOME/.tmux/plugins
rm -f $HOME/.tmux.conf
cp $BASEDIR/src/.tmux.conf $HOME/.tmux.conf
chmod +x $HOME/.tmux.conf

# ranger
mkdir -p $HOME/.config/ranger
rm -rf $HOME/.config/ranger/rc.conf
cp $BASEDIR/src/.config/ranger/rc.conf $HOME/.config/ranger
cp $BASEDIR/src/.config/ranger/scope.sh $HOME/.config/ranger
chmod +x $HOME/.config/ranger/scope.sh

# ncmpcpp
mkdir -p $HOME/.config/ncmpcpp
rm -rf $HOME/.config/ncmpcpp
cp -r $BASEDIR/src/.config/ncmpcpp $HOME/.config

# git
rm -f $HOME/.gitconfig
cp $SYNCDIR/src/.gitconfig $HOME
git config --global credential.helper store
git config --global user.name 'anonymous'
git config --global user.email '<>'

# fzf
rm -f $HOME/.fzf.zsh
cp $SYNCDIR/src/.fzf.zsh $HOME

# terminfo
rm -rf ~/.terminfo
tic -x -o ~/.terminfo $SYNCDIR/src/xterm-24bit.terminfo
export TERM=xterm-24bit
