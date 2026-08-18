# Generate file name for Carbon.now.sh and VSCode's Polacode and CodeSnap
alias carbon="date +'carbon_%Y-%m-%d_%H-%M-%S.png' | pbcopy"
alias polacode="date +'polacode_%Y-%m-%d_%H-%M-%S.png' | pbcopy"
function codesnap() {
  mv ~/Desktop/code.png ~/Pictures/Snaps/`date +'Snap\ %Y-%m-%d\ %H-%M-%S.png'`
}
