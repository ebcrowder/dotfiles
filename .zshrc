export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000

# aliases
alias ll="ls -la"
alias vim="nvim"
alias vi="nvim"
alias vimdiff="nvim -d"
alias tmux="env TERM=xterm-256color tmux"

# aws cli
alias aws='podman run --privileged --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli'

# go
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# cargo
. "$HOME/.cargo/env"

# sdkman
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# lua
alias luamake="$HOME/Projects/lua-language-server/3rd/luamake/luamake"
export PATH="$PATH:$HOME/Projects/lua-language-server/bin"

# plugins
source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# prompt
# refer to https://github.com/sindresorhus/pure
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
zstyle :prompt:pure:path color default
zstyle :prompt:pure:git:stash show yes
prompt pure
