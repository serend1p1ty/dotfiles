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

    " 自动补全
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py', 'on': [] }
endif

if s:appearance > 0
    " 配色方案
    Plug 'lifepillar/vim-solarized8'

    " 彩虹括号
    Plug 'luochen1990/rainbow'

    " 状态栏
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Plug 'edkolev/tmuxline.vim'
endif

if s:text > 0
    " 代码片段补全
    Plug 'SirVer/ultisnips'
    Plug 'ppnman/vim-snippets'

    " 自动括号
    Plug 'jiangmiao/auto-pairs'

    " 操作成对符号
    Plug 'tpope/vim-surround'

    " 重复一个插件的操作
    Plug 'tpope/vim-repeat'

    " 去除行尾空格
    Plug 'ntpeters/vim-better-whitespace'

    " 文本对象
    Plug 'kana/vim-textobj-user'
    Plug 'kana/vim-textobj-indent'
    Plug 'sgur/vim-textobj-parameter'
endif

if s:python > 0
    " 代码检错
    Plug 'w0rp/ale', { 'for': 'python' }

    " 代码格式化
    Plug 'Chiel92/vim-autoformat', { 'on': 'Autoformat' }
endif

if s:git > 0
    " 显示gitdiff
    Plug 'mhinz/vim-signify'

    " git命令包装器
    Plug 'tpope/vim-fugitive'
endif

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Basic settings                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                " 关闭vi兼容模式
set number                      " 显示行号
set cursorline                  " 高亮光标所在行
set backspace=indent,eol,start  " Backspace删除
set noshowmode                  " 关闭左下角类似"-- INSERT --"的状态提示
set nowrap                      " 不自动换行
set signcolumn=yes              " 一直显示符号列
syntax enable                   " 语法高亮
set completeopt=longest,menu    " 关闭函数预览窗口
let python_highlight_all = 1    " 开启不规范python语法提示

""""""""""""""""
"  true color  "
""""""""""""""""
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum
set termguicolors

"""""""""
"  tab  "
"""""""""
set softtabstop=4               " 敲入tab键时实际占有的列数
set expandtab                   " 敲入tab键时将其转化为空格

""""""""""""
"  indent  "
""""""""""""
set shiftwidth=4                " <<和>>缩进的列数
set autoindent                  " 自动缩进
filetype plugin indent on       " 根据文件类型设置缩进风格

""""""""""""
"  search  "
""""""""""""
set ignorecase                  " 搜索时不区分大小写
set smartcase                   " 除非出现大写字母
set hlsearch                    " 高亮匹配项

""""""""""""""
"  encoding  "
""""""""""""""
set encoding=utf-8              " 内部工作编码
set fileencoding=utf-8          " 保存文件默认编码
set fileencodings=utf-8,gbk     " 打开文件时按照下面的顺序尝试识别编码

""""""""""
"  fold  "
""""""""""
set fdm=indent                  " 代码折叠默认使用缩进
set foldlevel=99                " 默认打开所有折叠

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Keymaps                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" space代替<leader>
let mapleader=" "
nnoremap <SPACE> <NOP>

" F7 打开/关闭粘贴模式
set pastetoggle=<F7>

" \\ 关闭高亮显示搜索项
nnoremap <silent> \\ :nohlsearch<CR>

" 在全文范围内替换光标处的单词
nnoremap <leader>s :%s/\<<C-R><C-W>\>//g<left><left>

"""""""""""""""
"  save/exit  "
"""""""""""""""
nnoremap <leader>q :q<CR>
nnoremap <leader>a :qa<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>x :x<CR>

"""""""""""""""""
"  multiwindow  "
"""""""""""""""""
" <C-H/J/K/L> 窗口之间的移动
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

""""""""""""
"  insert  "
""""""""""""
" zs 插入ipdb.set_trace()
nnoremap zs Oimport ipdb; ipdb.set_trace(context=7)<ESC>

" zj/k 在当前行的下/上方插入空行
nnoremap zj o<ESC>k
nnoremap zk O<ESC>j

" zh/l 在光标的左/右边插入空格
nnoremap zh i<SPACE><ESC>l
nnoremap zl a<SPACE><ESC>h

""""""""""""
"  buffer  "
""""""""""""
" F3 显示缓冲区
nnoremap <F3> :buffers<CR>

" [b 下一个缓冲区
nnoremap [b :bnext<CR>

" ]b 上一个缓冲区
nnoremap ]b :bprevious<CR>

""""""""""""""""""
"  command mode  "
""""""""""""""""""
" ;和:功能互换
nnoremap ; :
nnoremap : ;

" <C-J> 下一条命令
cnoremap <C-J> <down>

" <C-K> 上一条命令
cnoremap <C-K> <up>

""""""""""""""
"  run code  "
""""""""""""""
" <F5> 在tmux的另一个窗格中执行上一条命令
nnoremap <F5> :call RunCode()<CR>
fu! RunCode()
    exec "w"
    exec "AsyncRun! tmux send-keys -t 0:0.1 C-P C-J"
endf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Plugins Configuration                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""
"  YouCompleteMe  "
"""""""""""""""""""
" 第一次进入插入模式时才加载ycm
augroup load_ycm
    autocmd!
    autocmd InsertEnter * call plug#load('YouCompleteMe') | autocmd! load_ycm
augroup END

" 输入两个字符后开启语义补全
let g:ycm_semantic_triggers =  {
                        \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
                        \ 'cs,lua,javascript': ['re!\w{2}'],
                        \ }

"""""""""""""""
"  UltiSnips  "
"""""""""""""""
" <C-Z> 补全代码片段
let g:UltiSnipsExpandTrigger="<C-Z>"

""""""""""""""""""""
"  vim-commentary  "
""""""""""""""""""""
" 设置这两个映射是为了延迟加载插件
" gc 可视模式下注释
map  gc  <Plug>Commentary

" gcc 注释行
nmap gcc <Plug>CommentaryLine

"""""""""""""""""""""""""""
"  vim-better-whitespace  "
"""""""""""""""""""""""""""
" <F8> 去除行尾空格
nnoremap <F8> :StripWhitespace<CR>

""""""""""""""""
"  easymotion  "
""""""""""""""""
" mw 跳转到单词
map mw <Plug>(easymotion-bd-w)

"""""""""""""
"  airline  "
"""""""""""""
" 启动顶部buffer状态栏
let g:airline#extensions#tabline#enabled = 1

" 设置airline主题
let g:airline_theme='solarized'

""""""""""""""
"  nerdtree  "
""""""""""""""
" F2 开启/关闭目录树
nnoremap <silent> <F2> :NERDTreeToggle<CR>

" 只剩下目录树时退出vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""
"  ale  "
"""""""""
" 语法错误提示信息的输出格式
let g:ale_echo_msg_format = '[%linter%]-[%severity%]-%s'

" 自定义错误提示符
let g:ale_sign_error = '•'

" 自定义警告提示符
let g:ale_sign_warning = '•'

""""""""""""""""""""
"  vim-autoformat  "
""""""""""""""""""""
" F4 代码格式化
noremap <F4> :Autoformat<CR>

"""""""""""""
"  LeaderF  "
"""""""""""""
" 取消LeaderF默认快捷键
let g:Lf_ShortcutF = ''

" <leader>fi 搜索当前目录下的文件
nnoremap <leader>fi :Leaderf file<CR>

" <leader>fm 搜索最近使用过的文件
nnoremap <leader>fm :Leaderf mru<CR>

" <leader>fc 搜索历史命令
nnoremap <leader>fc :Leaderf cmdHistory<CR>

" <leader>ff 搜索当前文件中定义的函数
nnoremap <leader>ff :Leaderf function<CR>

" <leader>fw 搜索光标处的单词
noremap <leader>fw :<C-U><C-R>=printf("Leaderf! rg -e %s", expand("<cword>"))<CR>

" <leader>fr 重新打开上一次的搜索结果
noremap <leader>fr :<C-U>Leaderf! rg --recall<CR>

"""""""""""""
"  rainbow  "
"""""""""""""
let g:rainbow_active = 1
let g:rainbow_conf = {
        \       'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
        \       'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
        \       'operators': '_,_',
        \       'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
        \       'separately': {
        \               '*': {},
        \               'tex': {
        \                       'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
        \               },
        \               'lisp': {
        \                       'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
        \               },
        \               'vim': {
        \                       'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
        \               },
        \               'html': {
        \                       'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
        \               },
        \               'css': 0,
        \       }
        \}

"""""""""""""""""
"  colorscheme  "
"""""""""""""""""
if isdirectory(expand('~/.vim/plugged/vim-solarized8'))
    set background=dark
    let g:solarized_term_italics = 1
    colorscheme solarized8
    highlight SignColumn guibg=#073642
endif
