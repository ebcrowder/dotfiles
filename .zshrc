# Path to your oh-my-zsh installation.
# export ZSH="/Users/ericcrowder/.oh-my-zsh" #macos
export ZSH="/home/ecrowder/.oh-my-zsh" #linux

ZSH_THEME=""
# PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT='%{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info) $ '

plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# go
export GOPATH=$HOME/go

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
