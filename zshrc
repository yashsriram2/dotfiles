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
alias g="git"
alias gs="git status"
alias b="brainos"
alias bs="brainos status"
alias bb="brainos sandbox"
alias bbr="brainos sandbox -r"
alias t="trash-list"

export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship.toml
eval "$(starship init zsh)"
