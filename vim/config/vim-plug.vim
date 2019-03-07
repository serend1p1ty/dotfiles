""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Plugins Management                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:basic = 1
let s:appearance = 1
let s:text = 1
let s:python = 1
let s:git = 1

call plug#begin('~/.vim/plugged')

if s:basic > 0
    " 目录树
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

    " 撤销树
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

    " 搜索文件
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh', 'on': 'Leaderf' }

    " 异步执行
    Plug 'skywind3000/asyncrun.vim', { 'on': 'AsyncRun' }

    " 快速注释
    Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }

    " vim-tmux快速导航
    Plug 'christoomey/vim-tmux-navigator'

    " 光标快速移动
    Plug 'easymotion/vim-easymotion', { 'on': '<Plug>(easymotion-bd-w)' }

    " tab补全
    " Plug 'ervandew/supertab'

    " 自动补全
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

    " 中文帮助文档
    Plug 'yianwillis/vimcdoc'
endif

if s:appearance > 0
    " 配色方案
    Plug 'morhetz/gruvbox'

    " 彩虹括号
    Plug 'luochen1990/rainbow'

    " vim状态栏
    Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

    " tmux状态栏
    " Plug 'edkolev/tmuxline.vim'
endif

if s:text > 0
    " f命令查找多行
    Plug 'rhysd/clever-f.vim'

    " 代码片段补全
    Plug 'SirVer/ultisnips' | Plug 'ppnman/vim-snippets'

    " 自动括号
    Plug 'jiangmiao/auto-pairs'

    " 操作成对符号
    Plug 'tpope/vim-surround'

    " 重复一个插件的操作
    Plug 'tpope/vim-repeat'

    " 去除行尾空格
    " Plug 'ntpeters/vim-better-whitespace'
endif

if s:python > 0
    " 代码补全
    " Plug 'davidhalter/jedi-vim'

    " 代码检错
    Plug 'w0rp/ale', { 'for': 'python' }

    " 代码格式化
    Plug 'Chiel92/vim-autoformat', { 'on': 'Autoformat' }
endif

if s:git > 0
    " Git状态显示
    Plug 'mhinz/vim-signify', { 'on': 'SignifyToggle' }

    " Git命令包装器
    Plug 'tpope/vim-fugitive'
endif

call plug#end()
