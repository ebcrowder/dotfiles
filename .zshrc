export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000

# aliases
alias ls="ls --color"
alias ll="ls -la --color"

# plugins
source "$HOME/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# pure
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure
