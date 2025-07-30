# ===================
# oh-my-zsh
# ===================
# oh-my-zsh handles auto-completion (with aliases) natively
# so we don't need to set completealiases or define alias abbrieviations
# for the defined plugins

# path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="half-life"
HYPHEN_INSENSITIVE="true"

plugins=(docker gcloud git gh kubectl terraform encode64 history kube-ps1)

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

# define kube-ps1 settings
KUBE_PS1_CLUSTER_FUNCTION=get_cluster_short
export KUBE_PS1_SYMBOL_ENABLE=false
export KUBE_PS1_CTX_COLOR=green

# Define different PS1s
DEFAULT_PS1='%{%F{135}%}%n%{%F{default}%} in %{%F{green}%}$(basename $(dirname "$PWD"))/$(basename "$PWD") %F{166}%}λ%{%}%{%F{default}%} '
KUBE_PS1='$(kube_ps1) '$DEFAULT_PS1
# Set PS1
PS1="$DEFAULT_PS1"

# ===================
# Environment variables
# ===================

# Docker
export DOCKER_DEFAULT_PLATFORM=linux/amd64

# Golang
export GOPATH=$HOME/go
unset GOROOT
export PATH=$PATH:$GOPATH/bin


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
