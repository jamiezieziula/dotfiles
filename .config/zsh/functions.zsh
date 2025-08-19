# ===================
# Git
# ===================
# Adds a git worktree using the project and branch name
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

# git worktree remove: changes back to the
# default branch directory and removes the PR
# branch directory.
function gwr() {
    local branch_name=$(basename "${PWD}")
    cd ../main
    git pull origin main
    git worktree remove "${branch_name}"
    git branch -d "${branch_name}"
}

# ===================
# Flux
# ===================
# list suspended flux resources
function fluxsus() { kubectl -n flux-system get ks -o json | jq -r '.items | map(select(.spec.suspend == true)) | ["SUSPENDED", "NAME"], ["---------", "----"], (.[] | [.spec.suspend, .metadata.name]) | @tsv' | column -t -s $'\t' }

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

# update the branch of a gitrepository
function patch_gitrepo() {
    if [ $# -eq 0 ]; then
        echo "Usage: patch_gitrepo <gitrepository_name> [branch_name]"
        echo "Example: patch_gitrepo my-repo feature-branch"
        echo "Note: branch_name defaults to 'main' if not specified"
        return 1
    fi
    
    local repo_name="$1"
    local branch_name="${2:-main}"
    
    kubectl patch gitrepository "$repo_name" -n flux-system --type='merge' -p "{\"spec\":{\"ref\":{\"branch\":\"$branch_name\"}}}"
}

# ===================
# Kubernetes
# ==================
# add new cluster credentials into their own context file
function knew() {
    if [ $# -ne 4 ]; then
        echo "Usage: knew <context_name> <cluster_name> <region> <project>"
        echo "Example: knew my-context my-cluster us-central1-a my-project-id"
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

# rename a cluster context
function krename() {
  context=$(kubectl config current-context)
  read new_name\?"New name for ${context}: "

  echo "renaming $context"
  kubectl config rename-context ${context} ${new_name}
  mv ~/.kube/contexts/${context} ~/.kube/contexts/${new_name}
}

# delete a cluster context
function kdelete() {
  contexts=$(ls ~/.kube/contexts | sort)
  context=$(printf "${contexts}\nquit" \
    | fzf --header='Select context to delete')

  if [ "${context}" = "quit" ]; then
    echo 'No context selected, exiting...'
    return
  fi

  echo "deleting $context"
  rm ~/.kube/contexts/$context
}

# connect to a cluster
# fzf will present a list for you to fuzzy search and select,
# but you can replace it with anything, such as manually providing
# the context name
function kon() {
  context=$(ls $HOME/.kube/contexts | fzf)
  export KUBECONFIG=$HOME/.kube/contexts/$context
}

# disconnect from the cluster
function koff() {
  unset KUBECONFIG
}

# ===================
# Utilities
# ===================
# make and cd into a directory
function mcd() {
	mkdir $1
	cd $1
}

# Function to decode base64-encoded values
function decode { echo ${1} | base64 --decode }

# Run a release script in a git repository
function release() {
    git checkout main
    git pull
    pip install -r scripts/release/requirements.txt
    python scripts/release/cluster-release
}