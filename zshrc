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
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"

alias cl='clear'
