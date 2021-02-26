ZSH_THEME="robbyrussell"

plugins=(git z zsh-autosuggestions zsh-syntax-highlighting)

source $HOME/.oh-my-zsh/oh-my-zsh.sh

####################
#  autosuggestion  #
####################
# set suggestion color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=24"

##################
#  fuzzy finder  #
##################
# make alt-c work in macos
bindkey "ç" fzf-cd-widget
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . "
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias cl='clear'
