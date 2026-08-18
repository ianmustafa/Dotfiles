# use eza instead of ls
alias ls="eza"
alias ll="eza -algF --group-directories-first --git --icons auto --smart-group"
alias la="eza -aalgF --group-directories-first --git --icons auto --smart-group"
alias lt="eza -TF --group-directories-first --icons auto --smart-group"
alias llt="eza -TalgF --group-directories-first --git --icons auto --smart-group"

# fallback for aptitude search
alias aps="sudo aptitude -F '* %p -> %d \n(%v/%V)' --no-gui --disable-columns search"

# faster yay shortcut
alias yas="yay -Ss"

# faster dig shortcut
alias digg="dig +noall +answer +stats"

# duf
alias dfl="duf -only local"

# use bat instead of cat
alias cat="bat"

