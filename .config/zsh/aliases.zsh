# gcp
alias gc="gcloud"
alias gset="gcloud config set project"

# git
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

# flux

# kubectl
alias deploy="kubectl get deployments"
alias kust="kubectl get kustomizations -A"
alias nodes="kubectl get nodes"
alias pods="kubectl get pods"
alias rollout="kubectl rollout restart deployments"

alias cleanps="kubectl delete pod -A --field-selector=status.phase==Succeeded,metadata.namespace!=kube-public,metadata.namespace!=kube-node-lease,metadata.namespace!=kube-system"
alias cleanpf="kubectl delete pod -A --field-selector=status.phase==Failed,metadata.namespace!=kube-public,metadata.namespace!=kube-node-lease,metadata.namespace!=kube-system"
alias cleanjs="kubectl delete jobs --field-selector status.successful=1"
alias cleanjf="kubectl delete jobs --field-selector status.successful=0"

alias kn="kubens"
alias podcount='kubectl get pods --all-namespaces | awk '\''{print $1}'\'' | sort | uniq -c | sort -k1 -n -r'
alias nodecount='kubectl get pods --all-namespaces -o jsonpath='\''{range .items[*]}{.spec.nodeName}{"\n"}{end}'\'' | sort | uniq -c | sort -k1 -n -r'
alias tempod='kubectl run -i --tty --rm jamie-debug --image=alpine --restart=Never -- sh'
alias watcher="watch -n1 kubectl get kustomizations -n flux-system"

# precommit
alias pca="pre-commit run --all-files"
alias pci="pre-commit install"

# terraform
alias tfaaa="terraform apply --auto-approve"
alias tff="terraform fmt --recursive"

# tree 
alias t='tree -C -a -I .git'

# random
alias codez="cursor ~/.zshrc"
alias cdd='cd $(find ~/src -maxdepth 4 -type d | sort -u | fzf)'
alias randompw='openssl rand -base64 18'