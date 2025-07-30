# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="half-life"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(docker gcloud git gh kubectl terraform encode64 history kube-ps1)

source $ZSH/oh-my-zsh.sh

# User configuration
# Configure PS1
function get_cluster_short() {
  echo "$1" | awk -F'_' '{print $NF}'
}

KUBE_PS1_CLUSTER_FUNCTION=get_cluster_short
export KUBE_PS1_SYMBOL_ENABLE=false
export KUBE_PS1_CTX_COLOR=green
source "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
# og prompt for theme
# "${purple}%n%{$reset_color%} in ${limegreen}%~%{$reset_color%}\$(virtualenv_prompt_info)\$(ruby_prompt_info)\$vcs_info_msg_0_${orange} λ%{$reset_color%} "

# default ps1
PS1='%{%F{135}%}%n%{%F{default}%} in %{%F{green}%}$(basename $(dirname "$PWD"))/$(basename "$PWD") %F{166}%}λ%{%}%{%F{default}%} '
PS1_DEFAULT="$PS1"
# kube ps1
PS1_A='$(kube_ps1) '$PS1

# function toggle_ps1() {
#     if [ "$PS1" = "$PS1_A" ]; then
#         PS1="$PS1_DEFAULT"
#     else
#         PS1="$PS1_A"
#     fi
# }

# alias tog='toggle_ps1'


# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias tfdoc="terraform-docs markdown ."
alias tfaaa="terraform apply --auto-approve"
alias tff="terraform fmt --recursive"
alias tfc="echo 'cat file.json | jq -c'"

alias ass=". awsume"

alias pca="pre-commit run --all-files"
alias pci="pre-commit install"

alias venv311="virtualenv venv --python=python3.11"

alias kx="kubectx"
alias kn="kubens"
alias kust="kubectl get kustomizations -A"
alias watcher="watch -n1 kubectl get kustomizations -n flux-system"
# alias pods="watch -n1 kubectl get pods"
# abbrieviated kubectl commands
alias pods="kubectl get pods"
alias nodes="kubectl get nodes"
alias deploy="kubectl get deployments"
alias rollout="kubectl rollout restart deployments"
# clean up functions
alias cleanps="kubectl delete pod -A --field-selector=status.phase==Succeeded,metadata.namespace!=kube-public,metadata.namespace!=kube-node-lease,metadata.namespace!=kube-system"
alias cleanpf="kubectl delete pod -A --field-selector=status.phase==Failed,metadata.namespace!=kube-public,metadata.namespace!=kube-node-lease,metadata.namespace!=kube-system"
alias cleanjs="kubectl delete jobs --field-selector status.successful=1"
alias cleanjf="kubectl delete jobs --field-selector status.successful=0"
alias podcount='kubectl get pods --all-namespaces | awk '\''{print $1}'\'' | sort | uniq -c | sort -k1 -n -r'
# flux reconcile commands
alias fgc="flux reconcile source git cluster-deployment"
alias fgm="flux reconcile source git monitoring-toolkit"
alias fgd="flux reconcile source git nebula-deployment"
alias fgn="flux reconcile source git nebula"
alias fkc="flux reconcile kustomization cluster-deployment"
alias fkm="flux reconcile kustomization monitoring-toolkit"
alias fkd="flux reconcile kustomization nebula-deployment"
alias fkn="flux reconcile kustomization nebula"
alias frk="flux reconcile kustomization"
# gcloud commands
alias gc="gcloud"
alias gset="gcloud config set project"
alias codez="cursor ~/.zshrc"
# git commands
alias cdm="cd main && git pull"
alias cdmain="cd ../main && git pull"
alias gs="(gco main) && ggpull"
alias empty="git commit --allow-empty -m 'Trigger Build'"
alias ghw="git push && gh pr create -w"
alias gmain="git pull origin main"
alias greset="git reset --soft HEAD^"
alias greset-hard="git reset --hard @{u}"
alias gdiff="git diff | pbcopy"
alias gapply="pbpaste | git apply -"
alias gprune="git remote prune origin"

# clear commands
alias rclear='clear'
alias arcle='clear'
alias cldar='clear'
alias rcle='clear'
alias clar='clear'
alias clkar='clear'
alias clera='clear'
alias claer='clear'
alias cleara='clear'
alias cleawr='clear'
alias celar='clear'
alias dlear='clear'
alias vlear='clear'
alias xlear='clear'
alias cpear='clear'
alias cmear='clear'
alias ckear='clear'
alias clesr='clear'
alias clezr='clear'
alias cleqr='clear'
alias cleae='clear'
alias cleat='clear'
alias cleag='clear'
alias cleaf='clear'
alias claew='clear'
alias clea='clear'
alias clae='clear'
# prefect api keys
alias prdauth='export PREFECT_API_KEY="pnu_xOOEOtJYgIIjFUyX1VxHQmduobTf2e4yzfp8"'
alias stgauth='export PREFECT_API_KEY="pnu_IntjBgjsUTza7WArRJS06PDEnZovv53VRess"'
alias devauth='export PREFECT_API_KEY="pnu_V7CprECVEGibjSvvVA4Z87HM3nTvC3265jcJ"'
# cloudsql proxy commands
alias cspnd='cloud-sql-proxy --auto-iam-authn --private-ip "prefect-dev-cloud2:us-east1:nebula-dev?port=3432"'
alias cspod='cloud-sql-proxy --auto-iam-authn --private-ip "prefect-dev-cloud2:us-east1:orion-dev?port=4432"'
alias cspns='cloud-sql-proxy --auto-iam-authn --private-ip "prefect-stg-cloud2:us-east1:nebula-stg?port=5432"'
alias cspos='cloud-sql-proxy --auto-iam-authn --private-ip "prefect-stg-cloud2:us-east1:orion-stg?port=6432"'
alias cspnp='cloud-sql-proxy --auto-iam-authn --private-ip "prefect-prd-cloud2:us-east1:nebula-prd?port=7432"'
alias cspop='cloud-sql-proxy --auto-iam-authn --private-ip "prefect-prd-cloud2:us-east1:orion-prd?port=8432"'

alias kvs='kubectl get virtualservices.networking.istio.io'

alias tempod='kubectl run -i --tty --rm jamie-debug --image=alpine --restart=Never -- sh'

# suspend and resume flux resources
function flux_toggle() {
    if [ $# -ne 3 ]; then
        echo "Usage: flux_toggle <type> <name> <namespace>"
        echo "Example: flux_toggle helmrelease orion cloud2"
        return 1
    fi
    
    local type="$1"
    local name="$2"
    local namespace="$3"
    
    flux suspend $type $name -n $namespace && flux resume $type $name -n $namespace
}

# cache working branch name, checkout to master + pull, delete working branch
function gsdb() {
    echo ""
    echo "This will delete your working branch.  Are you sure? (y/n)"
    echo ""
    read delete_confirmation

    if [[ $delete_confirmation = 'y' ]]; then
        unset curr_branch
        curr_branch=$(gb --show-current)
        gs
        gb -D $curr_branch
        unset curr_branch
        echo ""
        echo "Deleting working branch. You are done!"
        echo ""
    else
        echo "Aborted.  You must not be finished with your work!"
    fi
}

# list suspended flux resources
function fluxsus() { kubectl -n flux-system get ks -o json | jq -r '.items | map(select(.spec.suspend == true)) | ["SUSPENDED", "NAME"], ["---------", "----"], (.[] | [.spec.suspend, .metadata.name]) | @tsv' | column -t -s $'\t' }

# make and cd into a directory
function mcd() {
	mkdir $1
	cd $1
}

# release a new version of the cluster
function release() {
    git checkout main
    git pull
    pip install -r scripts/release/requirements.txt
    python scripts/release/cluster-release
}

function gwa() {
        local branch_name="${1}"
        local branch_name_escaped="$(echo $branch_name | sed 's;\/;-;g')"
        local location="../${branch_name_escaped}"
        local args=""
        if [ $(git branch --all | grep "remotes/origin/${branch_name}" | wc -l) -eq 0 ]
        then
                echo 'Branch does not exist on remote. Checking out a new branch...'
                args="-b"
        fi
        git worktree add ${location} ${args} ${branch_name}
        cd "${location}"
}

# checkout to main, pull, delete working branch
function gwr() {
        local branch_name=$(basename "${PWD}")
        cd ../main
        git pull origin main
        git worktree remove "${branch_name}"
        git branch -d "${branch_name}"
}

# update the branch of a gitrepository
function patch_gitrepo() {
    if [ $# -ne 2 ]; then
        echo "Usage: patch_gitrepo <gitrepository_name> <branch_name>"
        echo "Example: patch_gitrepo my-repo feature-branch"
        return 1
    fi
    
    local repo_name="$1"
    local branch_name="$2"
    
    kubectl patch gitrepository "$repo_name" -n flux-system --type='merge' -p "{\"spec\":{\"ref\":{\"branch\":\"$branch_name\"}}}"
}

# add new cluster credentials into their own context
function get_cluster_credentials() {
    if [ $# -ne 4 ]; then
        echo "Usage: get_cluster_credentials <context_name> <cluster_name> <region> <project>"
        echo "Example: get_cluster_credentials my-context my-cluster us-central1-a my-project-id"
        return 1
    fi
    
    local context_name="$1"
    local cluster_name="$2"
    local region="$3"
    local project="$4"
    
    KUBECONFIG="$HOME/.kube/contexts/$context_name" \
        gcloud container clusters get-credentials \
            "$cluster_name" \
            --region "$region" \
            --project "$project"
}

# connect to a cluster
# fzf will present a list for you to fuzzy search and select,
# but you can replace it with anything, such as manually providing
# the context name
function kon() {
  context=$(ls $HOME/.kube/contexts | fzf)
  export KUBECONFIG=$HOME/.kube/contexts/$context
  PS1="$PS1_A"
}

# disconnect from the cluster
function koff() {
  unset KUBECONFIG
  PS1="$PS1_DEFAULT"
}

# autocomplete things
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
source <(fzf --zsh)

command -v flux >/dev/null && . <(flux completion zsh)

autoload -U compinit && compinit

# allow to move across words using option
bindkey "^[^[[D" backward-word
bindkey "^[^[[C" forward-word

# add ssh keys to ssh-agent
eval "$(ssh-agent -s)" > /dev/null 2>&1
ssh-add -q /Users/jamie/.ssh/github
ssh-add -q /Users/jamie/.ssh/gitlab

# GOPATH
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin
export GO111MODULE=auto PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(/opt/homebrew/bin/mise activate zsh)"