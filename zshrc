# 指定终端类型
export TERM="xterm-256color"

# 使终端接受<C-S>和<C-Q>
stty -ixon

# 指定oh-my-zsh路径
export ZSH="$HOME/.oh-my-zsh"

# 设置zsh主题
ZSH_THEME="powerlevel9k/powerlevel9k"

# 设置zsh插件
plugins=(
    git
    zsh-autosuggestions
    autojump
    zsh-syntax-highlighting
)

# 加载oh-my-zsh
source $ZSH/oh-my-zsh.sh

##################
#  powerlevel9k  #
##################
# 双行提示
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# 去掉用户名和主机名提示
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)

# 修改提示符样式
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="$ "

# 禁用右提示符
POWERLEVEL9K_DISABLE_RPROMPT=true

####################
#  autosuggestion  #
####################
# 改变提示字符的颜色
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=24"

##################
#  fuzzy finder  #
##################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# 打开最近使用过的文件
v()
{
    local files
    files=$(grep '^>' ~/.viminfo | cut -c3- |
            while read line; do
                [ -f "${line/\~/$HOME}" ] && echo "$line"
            done | fzf -0 -1 -m -q "$*" | tr '\n' ' ')

    if [[ -n $files ]]
    then
        eval "nvim $files"
    fi
}

# 打开任何地方的文件
vf()
{
    local files
    files=(${(f)"$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1 -m)"})
    if [[ -n $files ]]
    then
        nvim $files
    fi
}

# 打开当前目录下的文件
fe()
{
    local files
    IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && ${EDITOR:-nvim} "${files[@]}"
}

# 别名
alias vi='nvim'
alias cl='clear'
alias to='tmux'
alias tc='tmux kill-server'
alias gl='git log'
alias ga='git add .'
alias gs='git status'
alias gc='git commit -m'
alias gd='git difftool'
alias gp='git push origin master'
