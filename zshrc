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

export GOPRIVATE=github.com/braincorp
export PATH=$PATH:/usr/local/go/bin


# aliases
alias r="ranger"
alias g="gitui"
alias gs="git status"
alias gd="git diff"
alias t="trash-list"
alias b="brainos"
alias bs="brainos status"
alias bb="brainos sandbox"
alias bbr="brainos sandbox -r"

export JIRA_API_TOKEN=N0edAQ70mZQFZezCUkOH5A58

export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship.toml
eval "$(starship init zsh)"
