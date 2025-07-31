# ===================
# oh-my-zsh
# ===================
# oh-my-zsh handles auto-completion (with aliases) natively
# so we don't need to set completealiases or define alias abbrieviations
# for the defined plugins

# path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

HYPHEN_INSENSITIVE="true"

plugins=(docker gcloud git gh kubectl terraform encode64 history)

source $ZSH/oh-my-zsh.sh

source ~/dotfiles/.config/zsh/aliases.zsh
source ~/dotfiles/.config/zsh/functions.zsh
source ~/dotfiles/.config/zsh/private.zsh

# ===================
# PS1
# ===================
function get_cluster_short() {
  echo "$1" | awk -F'_' '{print $NF}'
}

# ===================
# Environment variables
# ===================

# Docker
export DOCKER_DEFAULT_PLATFORM=linux/amd64

# Golang
#export GOPATH=$HOME/go
# export PATH=$PATH:$GOPATH/bin


# ===================
# Sources
# ===================

if command -v flux &> /dev/null; then
    source <(flux completion zsh)
fi

if command -v fzf &> /dev/null; then
  source <(fzf --zsh)
fi

# required to autocomplete for gcp related tools like `bq` and `gutils`
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"

# For managing tool versions
eval "$(mise activate zsh)"

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"