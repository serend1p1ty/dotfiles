""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Plugins Management                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:basic = 1
let s:appearance = 1
let s:text = 1
let s:python = 1
let s:git = 1
let s:markdown = 1

silent fu! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endf

if LINUX()
    let plugin_path = '~/.vim/plugged'
else
    let plugin_path = '~/vimfiles/plugged'
endif

call plug#begin(plugin_path)

if s:basic > 0
    " 目录树
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

    " 撤销树
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

    " 搜索文件
    if LINUX()
        Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
    else
        Plug 'Yggdroot/LeaderF', { 'do': './install.bat' }
    endif

    " 异步执行
    Plug 'skywind3000/asyncrun.vim', { 'on': 'AsyncRun' }

    " 快速注释
    Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }

    " vim-tmux快速导航
    Plug 'christoomey/vim-tmux-navigator'

    " 光标快速移动
    Plug 'easymotion/vim-easymotion', { 'on': '<Plug>(easymotion-bd-w)' }

    " 自动补全
    if LINUX()
        Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
    else
        Plug 'Valloric/YouCompleteMe', { 'do': 'python install.py --clang-completer' }
    endif

    " 中文帮助文档
    Plug 'yianwillis/vimcdoc'

    " vim开始界面
    Plug 'mhinz/vim-startify'

    " tab补全
    " Plug 'ervandew/supertab'
endif

if s:appearance > 0
    " 配色方案
    " Plug 'morhetz/gruvbox'
    Plug 'joshdick/onedark.vim'

    " 彩虹括号
    Plug 'luochen1990/rainbow'

    " vim状态栏
    Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

    " tmux状态栏
    " Plug 'edkolev/tmuxline.vim'
endif

if s:text > 0
    " f命令查找多行
    " Plug 'rhysd/clever-f.vim', { 'on': ['<Plug>(clever-f-f)', '<Plug>(clever-f-F)'] }

    " 代码片段补全
    Plug 'SirVer/ultisnips' | Plug 'ppnman/vim-snippets'

    " 自动括号
    Plug 'jiangmiao/auto-pairs'

    " 操作成对符号
    Plug 'tpope/vim-surround'

    " 重复一个插件的操作
    Plug 'tpope/vim-repeat'

    " 文本排列
    Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }
endif

if s:python > 0
    " 代码检错
    Plug 'w0rp/ale', { 'for': 'python' }

    " 代码折叠
    Plug 'tmhedberg/SimpylFold', { 'for': 'python' }

    " 快速折叠
    Plug 'Konfekt/FastFold', { 'for': 'python' }
endif

if s:git > 0
    " Git状态显示
    Plug 'mhinz/vim-signify', { 'on': 'SignifyToggle' }

    " Git命令包装器
    Plug 'tpope/vim-fugitive'
endif

if s:markdown > 0
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }
endif

call plug#end()
