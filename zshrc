# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel9k/powerlevel9k"

plugins=(
    git
    zsh-autosuggestions
    autojump
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# powerlevel9k配置
# 双行提示
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# 去掉用户名和主机名提示
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
# 修改提示符样式
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="$ "
# 禁用右提示符
POWERLEVEL9K_DISABLE_RPROMPT=true

# autosuggestion配置
# 改变提示字符的颜色
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=24"

# fuzzy finder配置
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse \
                         --preview '(highlight -O ansi -l {} \
                         || cat {}) 2> /dev/null | head -500'"
