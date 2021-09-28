export ZSH="$HOME/.oh-my-zsh"

HYPHEN_INSENSITIVE="true"

plugins=(
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# sources
# source /etc/profile.d/vte.sh

# exports
export EDITOR=/usr/bin/nvim

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# aliases
alias r="ranger"
alias tig="tig --all"
alias tl="trash-list"

# git aliases
alias gits="git status"
alias gita="git add"
alias gitc="git commit"
alias gitp="git push"
alias gitd="git diff"
alias gitl="git log"
alias gitb="git branch"

PROMPT="%B%F{cyan}%d%f %F{green}[%j jobs]%f %F{magenta}[%? returned]%f%b "
