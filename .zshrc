# zshrc

# alias
alias ll="ls -la"
alias ..="cd .."

# git
source ~/dotfiles/git-prompt.sh
precmd () { __git_ps1 "[%n]" " %~ $ " "[%s]" }
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM="auto"

# go
export GOPATH=$HOME/go

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
