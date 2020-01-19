# Path to your oh-my-zsh installation.
export ZSH="/Users/ericcrowder/.oh-my-zsh" #macos
# export ZSH="/home/ecrowder/.oh-my-zsh" #linux

ZSH_THEME=""

source ~/dotfiles/git-prompt.sh
precmd () { __git_ps1 "[%n]" " %~ %# " "[%s]" }
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM="auto"

plugins=(zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# go
export GOPATH=$HOME/go

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
