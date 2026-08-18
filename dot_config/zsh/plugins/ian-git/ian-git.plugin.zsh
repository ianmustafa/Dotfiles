# super-pretty `log` - https://coderwall.com/p/euwpig/a-better-git-log
alias gll='git log --decorate --color --graph --pretty=format:"%C(yellow)%h%Creset [%C(bold green)%G?%Creset] -%C(auto)%d%Creset %s. %C(cyan)[%C(green)%cr%Creset by %C(bold blue)%cn%Creset%C(cyan)]%Creset" --abbrev-commit'
alias gla='gll --all'
alias glla='gla'

# takegitrepo
function takegitrepo() {
  local reponame
  reponame="$(basename ${1%%.git})-repo"
  git clone "$1" $reponame
  cd $reponame
}

# gitflian
alias gs='git stash'
alias gsp='git stash pop'
alias gsc='git stash clear'
alias gmd='gm develop'
alias gcl='gco local'
alias gml='gm local'
alias grbm='grbi master'
alias grbd='grbi develop'
alias gpm='gcd && echo -e "\n" && gm local && echo -e "\n" && gcm && echo -e "\n" && gm develop && echo -e "\n" && ggp && echo -e "\n" && gco local'
alias gldv='gcd && echo -e "\n" && ggl && echo -e "\n" && gco local && echo -e "\n" && grbi develop'
alias gpdv='gldv && echo -e "\n" && gcd && echo -e "\n" && gm local && echo -e "\n" && ggp && echo -e "\n" && gco local'
alias gpr='gcr && echo -e "\n" && gmd && echo -e "\n" && ggp && echo -e "\n" && gcd'
#alias grs='git reset'
alias gcde='gco development'
alias gci='gco ian-local'
alias gmi='gm ian-local'
alias grbde='grbi development'
alias gcr='gco release'
alias gmr='gm release'
alias gcs='gco staging'
alias gmde='gm development'
alias gldvi='gcd && echo -e "\n" && ggl && echo -e "\n" && gci && echo -e "\n" && grbd'
alias gpdvi='gldvi && echo -e "\n" && gcd && echo -e "\n" && gmi && echo -e "\n" && ggp && echo -e "\n" && gci'
alias gpri='gcr && echo -e "\n" && gmd && echo -e "\n" && ggp && echo -e "\n" && gci'
alias glud='gl upstream develop'
alias glum='gl upstream master'
