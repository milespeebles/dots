# antigen / oh-my-zsh
ANTIGEN_FILE="$HOME/.zsh/antigen/antigen.zsh"
if [ -e $ANTIGEN_FILE ]; then
  source $ANTIGEN_FILE
  antigen use oh-my-zsh
  antigen theme dieter
  antigen bundle git
  antigen bundle dotenv
  antigen bundle fzf
  antigen bundle osx
  antigen bundle z
  antigen bundle zsh-users/zsh-syntax-highlighting
  antigen apply
fi

# tpm
TPM_FILE="$HOME/.tmux/plugins/tpm"
if [ ! -d $TPM_FILE ]; then
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

# options
setopt AUTO_CD
setopt MULTIOS
setopt CORRECT
setopt AUTO_PUSHD
setopt AUTO_NAME_DIRS
setopt GLOB_COMPLETE
setopt PUSHD_MINUS
setopt PUSHD_TO_HOME
setopt PUSHD_IGNORE_DUPS
setopt RM_STAR_WAIT
setopt ZLE
setopt NO_HUP
setopt VI
setopt IGNORE_EOF
setopt NO_FLOW_CONTROL
setopt NO_BEEP
setopt CLOBBER
setopt NO_CASE_GLOB
setopt NUMERIC_GLOB_SORT
setopt EXTENDED_GLOB
setopt RC_EXPAND_PARAM
unsetopt AUTO_NAME_DIRS

# exports
export PATH=$PATH:/usr/local/bin
export LC_CTYPE=en_US.UTF-8
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

# man page colors
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# functions
function doesCommandExist {
  command -v "$1" >/dev/null 2>&1
}

function processKill {
  for pid in $(pgrep -f $1); do
    kill -9 $pid
  done
}

function processFind {
  pgrep -f $1
}

function historyGrep {
  history | grep $1
}

function historyList {
  history | less
}

function mk {
  if [ -d $1 ]; then
    return
  else
    mkdir -p $1
  fi
}

function mkcd {
  if [ -d $1 ]; then
    cd $1
  else
    mk $1 && cd $1
  fi
}

function neovimEdit {
  if doesCommandExist "nvr"; then
    nvr --remote-silent -s "$@"
  elif doesCommandExist "nvim"; then
    nvim "$@"
  elif doesCommandExist "vim"; then
    vim "$@"
  else
    vi "$@"
  fi
}

function vimEdit {
  if doesCommandExist "vim"; then
    vim "$@"
  else
    vi "$@"
  fi
}

function async {
  $@ > /dev/null 2>&1 &
}

function edit {
  PREVIOUS_TERM=$TERM

  TERM='xterm-24bit' emacs -nw && TERM=$PREVIOUS_TERM
}

# aliases
alias e="neovimEdit"
alias v="vimEdit"
alias reload="source $HOME/.zshrc"
alias hg="historyGrep"
alias hl="historyList"
alias pk="processKill"
alias pf="processFind"
alias dots="sh $HOME/dev/dots/sync.sh"

# editor
if doesCommandExist "nvr"; then
  export EDITOR="nvr --remote-silent -s"
elif doesCommandExist "nvim"; then
  export EDITOR="nvim"
elif doesCommandExist "vim"; then
  export EDITOR="vim"
else
  export EDITOR="vi"
fi

# history search
bindkey -v
bindkey '^R' history-incremental-search-backward

# ag
alias a="ag --silent --ignore-dir node_modules"

# git
alias g="git"
alias ga="git add"
alias gap="git add --patch"
alias gb="git branch"
alias gba="git branch -a"
alias gbr="git branch --remote"
alias gc="git commit -v"
alias "gc!"="git commit -v --amend"

# youtube-dl
alias download="youtube-dl -f bestvideo+bestaudio --output \"~/Downloads/%(id)s.%(ext)s\""

# trash-cli
alias del="trash-put"
alias restore="trash-restore"
alias dive="trash-list"
alias empty="trash-empty"

# ncmpcpp
alias music='ncmpcpp --quiet'

# prettyping
alias p="ping google.com"
alias ping="prettyping --nolegend"

# tldr
function help { tldr $1 | less }

# bat
alias bat="bat --theme base16"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

FZF_CTRL_T_COMMAND='ag -l -g ""'
FZF_CTRL_T_OPTS="--bind 'ctrl-e:execute(nvr {}),ctrl-v:execute-silent(echo {} | pbcopy)+abort' --preview 'bat --theme base16 --style=numbers --color always {} | head -500' --height 60%"
FZF_ALT_C_COMMAND='fd -t d ""'
FZF_ALT_C_OPTS="--height 60% --preview 'fd -t d --full-path {}'"

alias f="ag --hidden -l g "" | fzf --bind 'ctrl-e:execute(nvr {}),ctrl-v:execute-silent(echo {} | pbcopy)+abort' --preview 'bat --theme base16 --style=numbers --color always {} | head -500' --height 60%"

