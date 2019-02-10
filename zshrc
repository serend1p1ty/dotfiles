# enable 256 colors
export TERM="xterm-256color"

# terminal accept <C-S> and <C-Q>
stty -ixon

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $HOME/.oh-my-zsh/oh-my-zsh.sh

####################
#  autosuggestion  #
####################
# change suggestion color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=24"

##################
#  fuzzy finder  #
##################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# open file in the current folder
fe()
{
    local files
    IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

alias cl='clear'
alias gl='git log'
alias ga='git add .'
alias gs='git status'
alias gc='git commit -m'
alias gd='git difftool'