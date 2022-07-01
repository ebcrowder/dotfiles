# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000

# aliases
alias ll="exa -la --icons --git"
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

# rbenv / ruby
export PATH="$PATH:$HOME/.local/share/gem/ruby/3.1.0/bin"
export PATH="$PATH:$HOME/.rbenv/bin"
eval "$(rbenv init - zsh)"

# plugins
source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOME/.zsh/powerlevel10k/powerlevel10k.zsh-theme"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
