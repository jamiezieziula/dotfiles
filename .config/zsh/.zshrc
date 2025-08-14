# ===================
# oh-my-zsh
# ===================
# oh-my-zsh handles auto-completion (with aliases) natively
# so we don't need to set completealiases or define alias abbrieviations
# for the defined plugins

# path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

HYPHEN_INSENSITIVE="true"

plugins=(docker git gh kubectl terraform encode64 history)

source $ZSH/oh-my-zsh.sh



# ===================
# PS1
# ===================
function get_cluster_short() {
  echo "$1" | awk -F'_' '{print $NF}'
}

# ===================
# Environment variables
# ===================
# Claude
export CLAUDE_CONFIG_DIR="$HOME/.config/claude"

# Docker
export DOCKER_DEFAULT_PLATFORM=linux/amd64


# ===================
# Sources
# ===================
source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/functions.zsh"
source "$HOME/.config/zsh/private.zsh"

if command -v flux &> /dev/null; then
    source <(flux completion zsh)
fi

if command -v fzf &> /dev/null; then
  source <(fzf --zsh)
fi

# kubectl completion (oh-my-zsh plugin may not be enough)
if command -v kubectl &> /dev/null; then
  source <(kubectl completion zsh)
fi

# stern completion for Kubernetes log viewing
if command -v stern &> /dev/null; then
  source <(stern --completion zsh)
fi

# GCloud completion and configuration
if [[ -f "/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc" ]]; then
  source "/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc"
fi

# Enable GKE auth plugin
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# For managing tool versions
eval "$(mise activate zsh)"

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"
