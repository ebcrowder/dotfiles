export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000

# File system
alias ls='eza -lh --group-directories-first --icons'
alias ll='ls -la'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'

# Tools
alias n='nvim'
alias g='git'

# plugins
source "$HOME/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# pure
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure
