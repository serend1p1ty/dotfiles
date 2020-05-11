# 指定终端类型
export TERM="xterm-256color"

# 使终端接受<C-S>和<C-Q>
stty -ixon

# 指定oh-my-zsh路径
export ZSH="$HOME/.oh-my-zsh"

# 设置zsh主题
ZSH_THEME="powerlevel10k/powerlevel10k"

# 设置zsh插件
plugins=(
    git
    zsh-autosuggestions
    autojump
    zsh-syntax-highlighting
)

# 加载oh-my-zsh
source $ZSH/oh-my-zsh.sh

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
alias svi="sudo nvim"
alias vi='nvim'
alias cl='clear'
alias to='tmux new -s editor'
alias tc='tmux kill-server'
alias gl='git log'
alias ga='git add .'
alias gs='git status'
alias gc='git commit -m'
alias gd='git difftool'
alias gp='git push origin master'
