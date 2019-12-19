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
export SYNCDIR=$HOME/sync
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
export TIMEWARRIORDB=$SYNCDIR/data/timewarrior
# export SOURCES_PATH=$SYNCDIR/scripts/source.zsh

# man page colors
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# source
# [ -f $SOURCES_PATH ] && source $SOURCES_PATH

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

# aliases
alias e="neovimEdit"
alias v="vimEdit"
alias reload="source $HOME/.zshrc"
alias hg="historyGrep"
alias hl="historyList"
alias pk="processKill"
alias pf="processFind"
alias dots="sh $SYNCDIR/dots/sync.sh && zsh"

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

# direnv
if doesCommandExist "direnv"; then
  eval "$(direnv hook zsh)"
fi

# youtube-dl
alias download="youtube-dl -f bestvideo+bestaudio --output \"~/Downloads/%(id)s.%(ext)s\""

# productivity
alias todo="task"
alias add="todo add"
alias current="todo list +ACTIVE | head -n +5"
alias list="todo list"
alias modify="todo modify"
alias projects="todo projects"
alias timer="timew"
alias summary="timer summary"

function start {
  if [ -z "${1+x}" ]; then
    echo 'requires an ID'
    return
  else
    todo start $1
  fi
}

function stop {
  if [ -z "${1+x}" ]; then
    echo 'requires an ID'
    return
  else
    todo stop $1
  fi
}

function complete {
  if [ -z "${1+x}" ]; then
    echo 'requires an ID'
    return
  else
    todo $1 done
  fi
}

function count {
  if [ -z "${1+x}" ]; then
    echo 'requires a time value'
    return
  else
    true
  fi

  if [ -z "${2+x}" ]; then
    termdown $1 -B -c 10 --no-figlet
  else
    termdown $1 --title $2 -B -c 10 --no-figlet
  fi
}

function up {
  if [ -z "${1+x}" ]; then
    echo 'requires an ID'
    return
  else
    true
  fi

  if todo $1 info >/dev/null 2>&1; then
    true
  else
    echo "todo ID $1 not found"
    return
  fi

  if [ -z "${2+x}" ]; then
    TIMEBOX_AMOUNT="10m"
  else
    TIMEBOX_AMOUNT=$2
  fi

  todo start $1

  ACTIVE=$(task active > /dev/null | tail -3 | head -1)
  DESCRIPTION=$(task $1 info 2> /dev/null | head -5 | tail -1 | cut -d ' ' -f4-)

  termdown -o $HOME/.timer $TIMEBOX_AMOUNT --title $DESCRIPTION -B -c 10 --no-figlet

  todo stop $1
}

function down {
  if [ -z "${1+x}" ]; then
    TIMEBOX_AMOUNT="10m"
  else
    TIMEBOX_AMOUNT=$1
  fi

  timer start 'downtime'

 termdown -o $HOME/.timer $TIMEBOX_AMOUNT --title 'downtime' -B -c 10 --no-figlet

  timer stop
}

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
function fzfe {
  selection=$(ag -l -g "" | fzf --bind 'ctrl-e:execute(nvr {}),ctrl-v:execute-silent(echo {} | pbcopy)+abort' --preview 'bat --theme base16 --style=numbers --color always {} | head -500' --height 60%)

  if [ -z "$selection" ]; then
   return
  else
    nvr $selection
  fi
}

function fzfn {
  selection=$(ag -l -g "" $HOME/sync/notes | fzf --bind 'ctrl-e:execute(nvr {}),ctrl-v:execute-silent(echo {} | pbcopy)+abort' --preview 'bat --theme base16 --style=numbers --color always {} | head -500' --height 60%)

  if [ -z "$selection" ]; then
    :
  else
    nvr $selection
  fi
}

function fzfs {
  selection=$(ag --hidden -l -g "" $HOME/sync/dots | fzf --bind 'ctrl-e:execute(nvr {}),ctrl-v:execute-silent(echo {} | pbcopy)+abort' --preview 'bat --theme base16 --style=numbers --color always {} | head -500' --height 60%)

  if [ -z "$selection" ]; then
   :
  else
    nvr $selection
  fi
}

function fzfp {
  selection=$(ag -l -g "" $HOME/dev | fzf --bind 'ctrl-e:execute(nvr {}),ctrl-v:execute-silent(echo {} | pbcopy)+abort' --preview 'bat --theme base16 --style=numbers --color always {} | head -500' --height 60%)

  if [ -z "$selection" ]; then
    :
  else
    nvr $selection
  fi
}

bindkey -s '^e' 'fzfe\n'
bindkey -s '^n' 'fzfn\n'
bindkey -s '^s' 'fzfs\n'
bindkey -s '^p' 'fzfp\n'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

FZF_CTRL_T_COMMAND='ag -l -g ""'
FZF_CTRL_T_OPTS="--bind 'ctrl-e:execute(nvr {}),ctrl-v:execute-silent(echo {} | pbcopy)+abort' --preview 'bat --theme base16 --style=numbers --color always {} | head -500' --height 60%"
FZF_ALT_C_COMMAND='fd -t d ""'
FZF_ALT_C_OPTS="--height 60% --preview 'fd -t d --full-path {}'"

alias f="ag --hidden -l g "" | fzf --bind 'ctrl-e:execute(nvr {}),ctrl-v:execute-silent(echo {} | pbcopy)+abort' --preview 'bat --theme base16 --style=numbers --color always {} | head -500' --height 60%"

