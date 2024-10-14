export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000

export EDITOR=/usr/bin/nvim

# File system
alias ls='eza -lh --group-directories-first --icons'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'bat --theme=ansi --style=numbers --color=always {}'"
alias bat='bat --theme=ansi'
alias cd='z'

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Tools
alias n='nvim'
alias g='git'
alias lg='lazygit'

# plugins
source "$HOME/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# pure
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure

# fzf
source <(fzf --zsh)

# zoxide
eval "$(zoxide init zsh)"
