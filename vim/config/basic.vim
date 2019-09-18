""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Basic settings                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                " 关闭vi兼容模式
set backspace=indent,eol,start  " backspace删除
set number                      " 显示行号
set hidden                      " 缓存区被放弃时设置为隐藏
set updatetime=300              " 光标静止300ms之后触发CursorHold事件
set history=1000                " 记录的历史命令条数最大为1000
set showcmd                     " 在屏幕的最后一行显示当前命令
set lazyredraw                  " 执行宏的时候屏幕不会重绘
set wildmenu                    " 增强命令行模式的tab补全
set noshowmode                  " 关闭左下角类似"-- INSERT --"的状态提示
set showtabline=2               " 始终显示标签行
set signcolumn=yes              " 始终显示符号列
set softtabstop=4               " 敲入tab键时实际占有的列数
set expandtab                   " 敲入tab键时将其转化为空格
set shiftwidth=4                " <<和>>缩进的列数
set hlsearch                    " 搜索时高亮匹配项
set incsearch                   " 搜索时显示匹配的过程
set ignorecase                  " 搜索时不区分大小写
set smartcase                   " 除非出现大写字母
set foldmethod=marker           " 设置折叠方法
set foldlevel=99                " 默认打开所有折叠
set noswapfile                  " 禁止生成临时文件
set autoindent                  " 自动缩进
set autoread                    " 文件在vim之外修改过，自动重新读入
set encoding=utf-8              " 内部工作编码
set fileencoding=utf-8          " 保存文件默认编码
set fileencodings=utf-8,gbk     " 打开文件时按照下面的顺序尝试识别编码
syntax enable                   " 语法高亮
filetype plugin indent on       " 根据文件类型设置缩进风格

" 打开文件时自动定位到最后一次编辑的位置
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif

" 进入终端时自动进入插入模式
if has('nvim')
    au WinEnter term://* startinsert
    au WinLeave term://* stopinsert
endif

" 高亮光标所在行直到其离开当前窗口
augroup CursorLine
    au!
    au VimEnter * setlocal cursorline
    au WinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" 根据终端类型开启真彩色
if $TERM =~ '^\(rxvt\|screen\|interix\|putty\)\(-.*\)\?$'
    set notermguicolors
elseif $TERM =~ '^\(tmux\|iterm\|vte\|gnome\)\(-.*\)\?$'
    set termguicolors
elseif $TERM =~ '^\(xterm\)\(-.*\)\?$'
    if $XTERM_VERSION != ''
        set termguicolors
    elseif $KONSOLE_PROFILE_NAME != ''
        set termguicolors
    elseif $VTE_VERSION != ''
        set termguicolors
    else
        set notermguicolors
    endif
endif
