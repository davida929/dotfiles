export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# PLUGINS
plugins=(
	git 
	vi-mode
	zsh-autosuggestions
	zsh-syntax-highlighting	
)

source $ZSH/oh-my-zsh.sh

# alias zshconfig="mate ~/.zshrc"
alias v="nvim"
alias ls="eza --icons"
alias tree="eza --tree --icons"


# nvm config
 export NVM_DIR="$HOME/.nvm"
 [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
 [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

 # yazi config
 function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
# zoxide config
eval "$(zoxide init zsh --cmd cd)"

# fzf config
source <(fzf --zsh)

# rust setup
. "$HOME/.cargo/env" 


# Pipx config
export PATH="$PATH:/home/davida/.local/bin"
